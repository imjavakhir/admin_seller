import 'package:admin_seller/features/auth_feature/presentation/pages/auth_page.dart';
import 'package:admin_seller/features/main_feature/data/models/seller_model/sellers_model.dart';
import 'package:admin_seller/features/main_feature/presentation/blocs/main_feature_bloc.dart';
import 'package:admin_seller/features/main_feature/presentation/widgets/seller_tile.dart';
import 'package:admin_seller/services/login_service.dart';
import 'package:admin_seller/services/socket_io_client_service.dart';
import 'package:admin_seller/src/shimmers/sellertile_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/big_textfield_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Seller { auto, select }

bool _isloading = false;
int _selected = 0;
Seller selectedSellerMode = Seller.auto;

class AdminSellerPage extends StatefulWidget {
  const AdminSellerPage({super.key});

  @override
  State<AdminSellerPage> createState() => _AdminSellerPageState();
}

class _AdminSellerPageState extends State<AdminSellerPage> {
  final TextEditingController _detailsController = TextEditingController();
  final LoginService _loginService = LoginService();
  Sellers? _seller;
  List<Sellers?>? _sellerList;
  String _selectedSellerName = '';
  String _selectedSellerPhone = '';

  void getSeller() async {
    try {
      setState(() {
        isLoading = true;
      });
      final data = await LoginService().getSeller();
      setState(() {
        _seller = data;
        print(_seller!.fullname);
        isLoading = false;
      });
    } catch (ex) {
      print(ex);
    }
  }

  void getSellers() async {
    try {
      final data = await LoginService().getSellers();
      setState(() {
        _sellerList = data;
        print(_sellerList!.length);
      });
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void initState() {
    SocketIOService().connectSocket();
    getSeller();
    getSellers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainFeatureBloc(),
      child: BlocBuilder<MainFeatureBloc, MainFeatureState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const AppBarWidget(
              title: 'Продавцы',
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenUtil().setVerticalSpacing(10.h),
                BigTextFieldWidget(
                  textEditingController: _detailsController,
                  hintext: 'Параметры клиента',
                ),
                ScreenUtil().setVerticalSpacing(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                  ),
                  child: Text(
                    'Продавец',
                    style: Styles.headline4,
                  ),
                ),
                ScreenUtil().setVerticalSpacing(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      MyCustomRadioButton(
                          text: 'Авто',
                          value: Seller.auto,
                          onChanged: (value) {
                            BlocProvider.of<MainFeatureBloc>(context)
                                .add(OnSellerChangeEvent(value));
                            getSeller();
                          },
                          groupValue: state.seller),
                      ScreenUtil().setHorizontalSpacing(10.h),
                      MyCustomRadioButton(
                          text: 'Продавцы',
                          value: Seller.select,
                          onChanged: (value) {
                            BlocProvider.of<MainFeatureBloc>(context)
                                .add(OnSellerChangeEvent(value));
                            // getSellers();

                            //modalsheet
                            showModalBottomSheet(
                                useSafeArea: true,
                                isScrollControlled: true,
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r)),
                                builder: (_) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ScreenUtil().setVerticalSpacing(24),
                                      Center(
                                        child: Text(
                                          'Выберите продавца',
                                          style: Styles.headline2,
                                        ),
                                      ),
                                      Flexible(
                                        child: ListView.builder(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            shrinkWrap: true,
                                            itemCount: _sellerList!.length,
                                            itemBuilder: (context, index) {
                                              if (isLoading) {
                                                return const SellersShimmer();
                                              }
                                              return SellerTile(
                                                onTap: () {
                                                  setState(() {
                                                    _selectedSellerName =
                                                        _sellerList![index]!
                                                            .fullname;
                                                    _selectedSellerPhone =
                                                        _sellerList![index]!
                                                            .phoneNumber;
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                title: _sellerList![index]!
                                                    .fullname,
                                                subtitle: _sellerList![index]!
                                                    .phoneNumber,
                                              );
                                            }),
                                      )
                                    ],
                                  );
                                });
                          },
                          groupValue: state.seller)
                    ],
                  ),
                ),
                ScreenUtil().setVerticalSpacing(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                  ),
                  child: Text(
                    'Выбранний продавец',
                    style: Styles.headline4,
                  ),
                ),
                if (isLoading) const SellersShimmer(),
                if (state.seller == Seller.auto && !isLoading)
                  SellerTile(
                    title: _seller!.fullname,
                    subtitle: _seller!.phoneNumber,
                  ),
                if (state.seller == Seller.select)
                  SellerTile(
                    title: _selectedSellerName.isNotEmpty
                        ? _selectedSellerName
                        : 'Выберите продавца',
                    subtitle: _selectedSellerPhone.isNotEmpty
                        ? _selectedSellerPhone
                        : '',
                  ),
                ScreenUtil().setVerticalSpacing(30.h),
              ],
            ),
            persistentFooterAlignment: AlignmentDirectional.center,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: LongButton(
                buttonName: 'Отправить уведомление',
                onTap: () async {
                  if (state.seller == Seller.auto) {
                    print(
                        '${_seller!.fullname}---------------------${_seller!.id}');
                    SocketIOService()
                        .sendnotification(_seller!.id, _detailsController.text);
                  }
                  if (state.seller == Seller.select) {
                    print(
                        '$_selectedSellerName---------------------${_seller!.id}');
                    SocketIOService()
                        .sendnotification(_seller!.id, _detailsController.text);
                  }

                  // SocketIOService().disconnectSocket();
                }),
          );
        },
      ),
    );
  }
}
