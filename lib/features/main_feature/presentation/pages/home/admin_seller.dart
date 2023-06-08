import 'package:admin_seller/features/main_feature/presentation/blocs/main_feature_bloc.dart';
import 'package:admin_seller/features/main_feature/presentation/widgets/seller_tile.dart';
import 'package:admin_seller/services/socket_io_client_service.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/big_textfield_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Seller { auto, select }

int _selected = 0;
Seller selectedSellerMode = Seller.auto;

class AdminSellerPage extends StatefulWidget {
  const AdminSellerPage({super.key});

  @override
  State<AdminSellerPage> createState() => _AdminSellerPageState();
}

class _AdminSellerPageState extends State<AdminSellerPage> {
  String _selectedSeller = '';
  @override
  void initState() {
    SocketIOService().connectSocket();
    // AuthLocalDataSource().getFcmToken();
    // AuthLocalDataSource().getLogToken();

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
                const BigTextFieldWidget(
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
                          },
                          groupValue: state.seller),
                      ScreenUtil().setHorizontalSpacing(10.h),
                      MyCustomRadioButton(
                          text: 'Продавцы',
                          value: Seller.select,
                          onChanged: (value) {
                            BlocProvider.of<MainFeatureBloc>(context)
                                .add(OnSellerChangeEvent(value));

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
                                          itemCount: _sellers.length,
                                          itemBuilder: (context, index) =>
                                              SellerTile(
                                            onTap: () {
                                              setState(() {
                                                _selectedSeller =
                                                    _sellers[index];
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            title: _sellers[index],
                                          ),
                                        ),
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
                ScreenUtil().setVerticalSpacing(10.h),
                if (state.seller == Seller.auto)
                  const SellerTile(
                    onTap: null,
                    title: 'Toshmatov Eshmat',
                  ),
                if (state.seller == Seller.select)
                  SellerTile(
                    onTap: null,
                    title: _selectedSeller.isNotEmpty
                        ? _selectedSeller
                        : 'Выберите продавца',
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
                  SocketIOService().sendnotification();
                  // SocketIOService().disconnectSocket();
                }),
          );
        },
      ),
    );
  }
}

List _sellers = [
  'Asror',
  'Fathulloh',
  'Javoxir',
  'Rustam',
  'Bekzod',
  'Asror',
  'Asror',
  'Fathulloh',
  'Javoxir',
  'Rustam',
  'Asror',
  'Fathulloh',
  'Javoxir',
  'Rustam',
  'Bekzod',
  'Asror',
  'Asror',
  'Fathulloh',
  'Javoxir',
  'Rustam',
  'Asror',
  'Fathulloh',
  'Javoxir',
  'Rustam',
  'Bekzod',
  'Asror',
  'Asror',
  'Fathulloh',
  'Javoxir',
  'Rustam',
];
