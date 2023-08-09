import 'package:admin_seller/app_const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AdminVisitsShimmer extends StatelessWidget {
  const AdminVisitsShimmer({
    super.key,
  });

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
        height: 190.h,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.grey.withOpacity(0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: AppColors.white),
                  ),
                  const Spacer(),
                  Container(
                    width: 80.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: AppColors.white),
                  ),
                ],
              ),
              ScreenUtil().setVerticalSpacing(6.h),
              Container(
                width: 150.w,
                height: 14.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.white),
              ),
              const Spacer(),
              const Divider(
                height: 0,
                color: AppColors.grey,
              ),
              ScreenUtil().setVerticalSpacing(6.h),
              Container(
                width: 90.w,
                height: 14.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.white),
              ),
              ScreenUtil().setVerticalSpacing(4.h),
              Container(
                width: 120.w,
                height: 14.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.white),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 80.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: AppColors.white),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
