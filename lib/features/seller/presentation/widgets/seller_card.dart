import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/blocs/seller_bloc.dart';
import 'package:admin_seller/features/seller/presentation/widgets/share_seller_list.dart';
import 'package:admin_seller/features/seller_admin/presentation/widgets/seller_tile.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerCard extends StatelessWidget {
  // final VoidCallback ontapRed;
  final VoidCallback ontapGreenR;
  final VoidCallback ontapRedR;
  final VoidCallback? sharePress;
  final String shareId;
  final bool isShared;
  // final VoidCallback ontapGreen;
  // final bool isReady;
  final int selectedItem;
  final int index;
  final String parametrs;
  final bool showLoading;
  const SellerCard(
      {Key? key,
      // required this.ontapRed,
      this.isShared = false,
      required this.ontapGreenR,
      required this.ontapRedR,
      this.showLoading = false,
      required this.selectedItem,
      // required this.ontapGreen,
      // required this.isReady,
      required this.parametrs,
      required this.index,
      this.sharePress,
      required this.shareId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 600),
      crossFadeState: selectedItem == index && isShared
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      secondChild: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                  blurRadius: 20.r,
                  color: AppColors.cardShadow,
                  offset: const Offset(0, 0))
            ]),
        height: 200.h,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Параметры клиента',
                      style: Styles.headline4,
                    ),
                    ScreenUtil().setVerticalSpacing(6.h),
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        parametrs,
                        style: Styles.headline6,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (shareId.isEmpty)
                  Material(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r)),
                    child: IconButton(
                        enableFeedback: false,
                        splashRadius: 24.r,
                        onPressed: sharePress,
                        icon: Icon(
                          CupertinoIcons.share,
                          size: 24.h,
                          color: AppColors.black,
                        )),
                  )
              ],
            ),
            const Spacer(),
            BlocBuilder<SellerBloc, SellerState>(
              builder: (context, state) {
                return Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 0, color: AppColors.borderColor))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300.w,
                        child: Material(
                          type: MaterialType.transparency,
                          child: SellerTile(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: AppColors.white,
                                context: (context),
                                useSafeArea: true,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r)),
                                builder: (context) => ShareSellerList(
                                  clientInfoIndex: index,
                                ),
                              );
                            },
                            title: state.selectedSeller != null
                                ? state.selectedSeller!.fullname!
                                : "Не выбрали продавца",
                            subtitle: state.selectedSeller != null
                                ? state.selectedSeller!.phoneNumber!
                                : "",
                          ),
                        ),
                      ),
                      const Spacer(),
                      Material(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r)),
                        child: IconButton(
                            enableFeedback: false,
                            splashRadius: 24.r,
                            onPressed: state.selectedSeller != null
                                ? () {
                                    BlocProvider.of<SellerBloc>(context)
                                        .add(ShareClient(
                                      state.clientInfoList[index]!.id!,
                                      state.selectedSeller!.id!,
                                    ));

                                    // HelpShareClient(
                                    //     state.clientInfoList[index]!.id!,
                                    //     state.selectedSeller!.id!));

                                    // Navigator.of(context).pop();
                                  }
                                : null,
                            icon: Icon(
                              CupertinoIcons.paperplane,
                              color: state.selectedSeller != null
                                  ? AppColors.black
                                  : AppColors.borderColor,
                            )),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
      firstChild: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20.r,
                      color: AppColors.cardShadow,
                      offset: const Offset(0, 0))
                ]),
            height: 164.h,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Параметры клиента',
                          style: Styles.headline4,
                        ),
                        ScreenUtil().setVerticalSpacing(6.h),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            parametrs,
                            style: Styles.headline6,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (shareId.isEmpty)
                      Material(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r)),
                        child: IconButton(
                            enableFeedback: false,
                            splashRadius: 24.r,
                            onPressed: sharePress,
                            icon: Icon(
                              CupertinoIcons.share,
                              size: 24.h,
                              color: AppColors.black,
                            )),
                      )
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LongButton(
                      paddingW: 0,
                      buttonName: /* !isReady ? 'Принимать' : */ 'Оформить',
                      fontsize: 12,
                      onTap: /* !isReady ? ontapGreen : */ ontapGreenR,
                      height: 32,
                      width: 120,
                    ),
                    ScreenUtil().setHorizontalSpacing(10),
                    TransparentLongButton(
                      paddingW: 0,
                      width: 120,
                      height: 32,
                      fontsize: 12,
                      buttonName: /* !isReady ? 'Отменить' : */ 'Пустой',
                      onTap: /* !isReady ? ontapRed : */ ontapRedR,
                    )
                  ],
                )
              ],
            ),
          ),
          if (showLoading && selectedItem == index)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 164.h,
              width: double.maxFinite,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.white),
              ),
            )
        ],
      ),
    );
  }
}

/*  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    height: 22.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: !isReady
                            ? AppColors.orange.withOpacity(0.1)
                            : AppColors.green.withOpacity(0.1)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          !isReady ? AppIcons.clock : AppIcons.tick,
                          height: 14.h,
                          width: 14.h,
                          color: !isReady ? AppColors.orange : AppColors.green,
                        ),
                        ScreenUtil().setHorizontalSpacing(2.w),
                        Text(
                          !isReady ? 'В ожидание' : 'Принято',
                          style: Styles.headline5.copyWith(
                              fontSize: 10.sp,
                              color: !isReady ? AppColors.orange : AppColors.green),
                        ),
                      ],
                    ),
                  ) */

                    /*  Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      height: 22.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: !isReady
                              ? AppColors.orange.withOpacity(0.1)
                              : AppColors.green.withOpacity(0.1)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            !isReady ? AppIcons.clock : AppIcons.tick,
                            height: 14.h,
                            width: 14.h,
                            color: !isReady ? AppColors.orange : AppColors.green,
                          ),
                          ScreenUtil().setHorizontalSpacing(2.w),
                          Text(
                            !isReady ? 'В ожидание' : 'Принято',
                            style: Styles.headline5.copyWith(
                                fontSize: 10.sp,
                                color: !isReady ? AppColors.orange : AppColors.green),
                          ),
                        ],
                      ),
                    ) */