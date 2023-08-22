import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCardTile extends StatelessWidget {
  final String leading;
  final String trailing;
  const OrderCardTile({
    super.key,
    required this.leading,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 0,
        color: AppColors.grey,
      ))),
      child: Row(
        children: [
          Text(
            leading,
            style: Styles.headline5.copyWith(color: AppColors.grey),
          ),
          const Spacer(),
          SizedBox(
            width: 180.w,
            child: Text(
              trailing,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: Styles.headline5M.copyWith(color: AppColors.black),
            ),
          )
        ],
      ),
    );
  }
}
