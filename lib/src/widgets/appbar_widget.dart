import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const AppBarWidget({
    super.key,
    required this.title,
    this.leading, this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      actions: actions,
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: Styles.headline2,
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => child;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.maxFinite, 56.h);
}
