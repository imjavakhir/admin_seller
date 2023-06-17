// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/seller/presentation/blocs/seller_bloc.dart';
import 'package:admin_seller/features/seller/presentation/widgets/seller_card.dart';
import 'package:admin_seller/services/api_service.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

bool _isReady = false;
bool isPaused = true;

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  void initState() {
    // ApiService().getSearchedCustomer(searchNumber: '77');
    BlocProvider.of<SellerBloc>(context).add(const ClientInfoListEvent([]));
    // BlocProvider.of<SellerBloc>(context).add(ConnectSocket());
    // SocketIOService().connectSocket();

    super.initState();
  }

  @override
  void dispose() {
    // SocketIOService().disconnectSocket();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
            title: 'Клиенты',
            actions: [
              StatefulBuilder(builder: (context, setState) {
                return IconButton(
                  splashRadius: 24.r,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.w, vertical: 12.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      !isPaused
                                          ? 'Вы хотите перерыв?'
                                          : 'Вы на перерыве, хотите вернуться к работе?',
                                      style: Styles.headline3,
                                    ),
                                    ScreenUtil().setVerticalSpacing(20.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        LongButton(
                                          paddingW: 0,
                                          buttonName: 'Да',
                                          fontsize: 12,
                                          onTap: () async {
                                            setState(() {
                                              isPaused = !isPaused;
                                            });
                                            ApiService().changePause(
                                                isPaused: isPaused);

                                            Navigator.of(context).pop();
                                          },
                                          height: 32,
                                          width: 64,
                                        ),
                                        ScreenUtil().setHorizontalSpacing(20.w),
                                        TransparentLongButton(
                                          paddingW: 0,
                                          width: 64,
                                          height: 32,
                                          fontsize: 12,
                                          buttonName: 'Нет',
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                  icon: SvgPicture.asset(
                    isPaused ? AppIcons.userTick : AppIcons.userRemove,
                    color: !isPaused ? AppColors.green : AppColors.red,
                    height: 32.h,
                    width: 32.w,
                  ),
                );
              })
            ],
          ),
          body: RefreshIndicator(
            backgroundColor: AppColors.primaryColor,
            color: AppColors.black,
            onRefresh: () async {
              return BlocProvider.of<SellerBloc>(context)
                  .add(const ClientInfoListEvent([]));
            },
            child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: StatefulBuilder(builder: (context, setState) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        // physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.clientInfoList.length,
                        itemBuilder: (context, index) => SellerCard(
                          parametrs: state.clientInfoList[index]!.details!,
                          ontapRed: () async {},
                          ontapGreenR: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.addClient);
                          },
                          ontapRedR: () async {
                            ApiService().sendEmptySelling();
                          },
                          ontapGreen: () {
                            setState(() {
                              _isReady = true;
                            });
                          },
                          isReady: _isReady,
                        ),
                      );
                    }),
                  )
                ]),
          ),
        );
      },
    );
  }
}
