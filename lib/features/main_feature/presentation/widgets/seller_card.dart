import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellerCard extends StatelessWidget {
  final VoidCallback ontapRed;
  final VoidCallback ontapGreenR;
  final VoidCallback ontapRedR;
  final VoidCallback ontapGreen;
  final bool isReady;

  const SellerCard(
      {Key? key,
      required this.ontapRed,
      required this.ontapGreenR,
      required this.ontapRedR,
      required this.ontapGreen,
      required this.isReady})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text(
                    'Красная рубашка, джинсы',
                    style: Styles.headline6,
                  ),
                ],
              ),
              const Spacer(),
              Container(
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
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LongButton(
                paddingW: 0,
                buttonName: !isReady ? 'Принимать' : 'Оформить',
                fontsize: 12,
                onTap: !isReady ? ontapGreen : ontapGreenR,
                height: 32,
                width: 120,
              ),
              ScreenUtil().setHorizontalSpacing(10),
              TransparentLongButton(
                paddingW: 0,
                width: 120,
                height: 32,
                fontsize: 12,
                buttonName: !isReady ? 'Отменить' : 'Пустой',
                onTap: !isReady ? ontapRed : ontapRed,
              )
            ],
          )
        ],
      ),
    );
  }
}
