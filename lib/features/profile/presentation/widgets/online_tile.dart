// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';

class OnlineTile extends StatelessWidget {
  final ValueChanged? onChanged;
  final bool value;
  final bool isVerified;
  const OnlineTile(
      {super.key,
      required this.onChanged,
      required this.value,
      this.isVerified = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isVerified ? AppColors.primaryColor.withOpacity(0.1) : null,
      height: 50.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 12.h,
      ),
      child: Row(
        children: [
          Text(
            'Онлайн',
            style: Styles.headline3M,
          ),
          const Spacer(),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
