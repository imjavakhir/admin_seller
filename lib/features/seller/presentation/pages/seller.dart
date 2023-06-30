// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/seller/presentation/blocs/seller_bloc.dart';
import 'package:admin_seller/features/seller/presentation/widgets/seller_card.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

// bool _isReady = false;
// bool isPaused = true;

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  // final SellerRepository _sellerRepository = SellerRepository();
  @override
  void initState() {
    BlocProvider.of<SellerBloc>(context).add(GetClientsFromApi());
    BlocProvider.of<SellerBloc>(context).add(const ClientInfoListEvent([]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBarWidget(
          title: 'Клиенты',
          actions: [
            IconButton(
              enableFeedback: false,
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
                                  !state.isPaused
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
                                        BlocProvider.of<SellerBloc>(context)
                                            .add(SavePauseInfo());

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
                !state.isPaused ? AppIcons.userTick : AppIcons.userRemove,
                color: !state.isPaused ? AppColors.green : AppColors.red,
                height: 32.h,
                width: 32.w,
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          backgroundColor: AppColors.primaryColor,
          color: AppColors.black,
          onRefresh: () async {
            return BlocProvider.of<SellerBloc>(context)
                .add(GetClientsFromApi());
          },
          child:
              BlocBuilder<SellerBloc, SellerState>(builder: (context, state) {
            return state.clientInfoList.isEmpty
                ? Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            100.r,
                          ),
                          color: AppColors.primaryColor.withOpacity(0.5)),
                      child: Text(
                        'Пока нет клиентов',
                        style: Styles.headline4,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.clientInfoList.length,
                    itemBuilder: (context, index) {
                      return SellerCard(
                        selectedItem: state.selectedIndex,
                        index: index,
                        showLoading: state.showLoading,
                        parametrs: state.clientInfoList[index]!.details!,
                        ontapGreenR: () {
                          Navigator.of(context).pushNamed(AppRoutes.addClient,
                              arguments: state.clientInfoList[index]);
                          debugPrint(state.clientInfoList[index]!.details!);
                          debugPrint(state.clientInfoList[index]!.details!);
                        },
                        ontapRedR: () async {
                          BlocProvider.of<SellerBloc>(context).add(ClearVisits(
                              index, state.clientInfoList[index]!.id!));

                          // _sellerRepository
                          // .sendEmptySelling(id: state.clientInfoList[index]!.id!);
                        },
                      );
                    });
          }),
        ),
      );
    });
  }
}
