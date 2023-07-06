import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller_admin/presentation/blocs/seller_admin_bloc.dart';
import 'package:admin_seller/features/seller_admin/presentation/widgets/seller_tile.dart';
import 'package:admin_seller/features/seller_admin/presentation/widgets/sellers_widget.dart';
import 'package:admin_seller/services/socket_io_client_service.dart';
import 'package:admin_seller/src/shimmers/sellertile_shimmer.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/validators/validators.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/big_textfield_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Seller { auto, select }

Seller selectedSellerMode = Seller.auto;

class AdminSellerPage extends StatefulWidget {
  const AdminSellerPage({super.key});

  @override
  State<AdminSellerPage> createState() => _AdminSellerPageState();
}

class _AdminSellerPageState extends State<AdminSellerPage> {
  final TextEditingController _detailsController = TextEditingController();
  final GlobalKey<FormState> paramFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<SellerAdminBloc>(context).add(GetSellerEvent());
    SocketIOService().connectSocket();

    super.initState();
  }

  @override
  void dispose() {
    SocketIOService().disconnectSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerAdminBloc, SellerAdminState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              appBar: const AppBarWidget(
                title: 'Продавцы',
              ),
              body: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenUtil().setVerticalSpacing(10.h),
                        Form(
                          key: paramFormKey,
                          child: BigTextFieldWidget(
                            validator: Validators.empty,
                            valueChanged: (value) {
                              paramFormKey.currentState!.validate();
                            },
                            textEditingController: _detailsController,
                            hintext: 'Параметры клиента',
                          ),
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
                                    BlocProvider.of<SellerAdminBloc>(context)
                                        .add(OnSellerChangeEvent(value));
                                    BlocProvider.of<SellerAdminBloc>(context)
                                        .add(GetSellerEvent());
                                  },
                                  groupValue: state.sellerType),
                              ScreenUtil().setHorizontalSpacing(10.h),
                              MyCustomRadioButton(
                                  text: 'Продавцы',
                                  value: Seller.select,
                                  onChanged: (value) {
                                    BlocProvider.of<SellerAdminBloc>(context)
                                        .add(OnSellerChangeEvent(value));
                                    showModalBottomSheet(
                                        backgroundColor: AppColors.white,
                                        useSafeArea: true,
                                        isScrollControlled: true,
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r)),
                                        builder: (context) {
                                          return const SellerListWidget();
                                        });
                                  },
                                  groupValue: state.sellerType)
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
                        if (state.showLoading &&
                            state.sellerType == Seller.auto)
                          const SellersShimmer(),
                        if (!state.showLoading &&
                            state.sellerType == Seller.auto &&
                            state.seller != null)
                          SellerTile(
                            isSeller:
                                state.seller!.fullname != null ? false : true,
                            title: !state.showLoading &&
                                    state.seller!.fullname != null
                                ? state.seller!.fullname!
                                : 'Нет онлайн продавца',
                            subtitle: !state.showLoading &&
                                    state.seller!.phoneNumber != null
                                ? state.seller!.phoneNumber!
                                : '',
                          ),
                        if (state.sellerType == Seller.select)
                          SellerTile(
                              title: state.selectedSeller != null
                                  ? state.selectedSeller!.fullname!
                                  : 'Виберите продавца',
                              subtitle: state.selectedSeller != null
                                  ? state.selectedSeller!.phoneNumber!
                                  : ''),
                        ScreenUtil().setVerticalSpacing(30.h),
                        const Spacer(),
                        LongButton(
                            buttonName: 'Отправить уведомление',
                            onTap: () async {
                              final isValidated =
                                  paramFormKey.currentState!.validate();
                              if (isValidated) {
                                if (state.sellerType == Seller.auto) {
                                  debugPrint(
                                      '${state.seller!.fullname}---------------------8484${state.seller!.id}');
                                  SocketIOService().sendnotification(
                                      state.seller!.id!,
                                      _detailsController.text);
                                }

                                if (state.sellerType == Seller.select) {
                                  print(
                                      '${state.selectedSeller!.phoneNumber}---------------------${_detailsController.text}');
                                  SocketIOService().sendnotification(
                                      state.selectedSeller!.id!,
                                      _detailsController.text);
                                }
                                BlocProvider.of<SellerAdminBloc>(context).add(
                                    const OnSellerChangeEvent(Seller.auto));

                                _detailsController.text = '';
                              }

                              // SocketIOService().disconnectSocket();
                            }),
                        ScreenUtil().setVerticalSpacing(30.h),
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
