import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';

class LongButton extends StatelessWidget {
  final bool isDisabled;
  final String buttonName;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double fontsize;
  final double paddingW;
  final bool isloading;
  const LongButton({
    Key? key,
    required this.buttonName,
    this.isDisabled = false,
    required this.onTap,
    this.width = double.maxFinite,
    this.height = 56,
    this.fontsize = 20,
    this.paddingW = 24,
    this.isloading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: paddingW.w,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isDisabled
              ? AppColors.primaryColor.withOpacity(0.2)
              : AppColors.primaryColor),
      width: width,
      height: height.h,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        enableFeedback: false,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        onPressed: isDisabled
            ? null
            : !isloading
                ? onTap
                : null,
        child: isloading
            ? Transform.scale(
                scale: 0.7,
                child: const CircularProgressIndicator(
                  color: AppColors.white,
                ),
              )
            : Text(
                buttonName,
                style: Styles.headline3.copyWith(
                    fontSize: fontsize.sp,
                    color: isDisabled
                        ? AppColors.black.withOpacity(0.2)
                        : AppColors.black),
              ),
      ),
    );
  }
}
