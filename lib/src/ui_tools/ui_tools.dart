import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class UITools {
  static SnackBar customSnackBar({required String title}) => SnackBar(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppIcons.closeCircle,
            height: 20.h,
            width: 20.h,
            color: AppColors.grey,
          ),
          ScreenUtil().setHorizontalSpacing(8),
          Text(title, style: Styles.headline4Reg),
        ],
      ),
      duration: const Duration(milliseconds: 3000),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      backgroundColor: AppColors.white);
}
