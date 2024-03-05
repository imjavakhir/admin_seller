import 'package:admin_seller/app_const/app_exports.dart';

abstract class UITools {
  static SnackBar customSnackBar({required String title}) => SnackBar(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppIcons.closeCircle,
            height: 20.h,
            width: 20.h,
            colorFilter:
                const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
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
