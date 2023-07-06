import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/transparent_longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerNotificationCard extends StatelessWidget {
  final String fullName;
  const SellerNotificationCard({super.key, required this.fullName});

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
      height: 200.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'От кого',
            style: Styles.headline4,
          ),
          ScreenUtil().setVerticalSpacing(6.h),
          Text(
            fullName,
            style: Styles.headline6,
          ),
          ScreenUtil().setVerticalSpacing(10.h),
          Text(
            'Параметры клиента',
            style: Styles.headline4,
          ),
          ScreenUtil().setVerticalSpacing(6.h),
          SizedBox(
            width: 250.w,
            child: Text(
              'Красная шапка',
              style: Styles.headline6,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 3,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LongButton(
                paddingW: 0,
                buttonName: 'Подвердить',
                fontsize: 12,
                onTap: () {},
                height: 32,
                width: 120,
              ),
              ScreenUtil().setHorizontalSpacing(10),
              TransparentLongButton(
                paddingW: 0,
                width: 120,
                height: 32,
                fontsize: 12,
                buttonName: 'Отменить',
                onTap: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
