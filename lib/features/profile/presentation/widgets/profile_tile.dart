// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/src/theme/text_styles.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const ProfileTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      height: 80.h,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.headline3M,
          ),
          ScreenUtil().setVerticalSpacing(8.h),
          Text(
            subtitle,
            style: Styles.headline5,
          )
        ],
      ),
    );
  }
}
