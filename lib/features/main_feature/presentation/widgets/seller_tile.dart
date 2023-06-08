import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;

  const SellerTile({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: AppColors.blue.withOpacity(0.05),
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
      onTap: onTap,
      title: Text(
        title,
        style: Styles.headline4Reg,
      ),
    );
  }
}
