import 'package:admin_seller/app_const/app_exports.dart';

class SellerCardShimmer extends StatelessWidget {
  const SellerCardShimmer({
    Key? key,
  }) : super(key: key);

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
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.grey.withOpacity(0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200.w,
                height: 18.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.white),
              ),
              ScreenUtil().setVerticalSpacing(6.h),
              Container(
                width: 150.w,
                height: 14.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.white),
              ),
            ],
          ),
        ));
  }
}
