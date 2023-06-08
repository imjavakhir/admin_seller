// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/features/main_feature/presentation/pages/home/admin_seller.dart';
import 'package:admin_seller/src/widgets/radio_button.dart';

class SelectSellerWidget extends StatefulWidget {
  const SelectSellerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectSellerWidget> createState() => _SelectSellerWidgetState();
}

class _SelectSellerWidgetState extends State<SelectSellerWidget> {
  Seller selectedSellerMode = Seller.auto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          MyCustomRadioButton(
              text: 'Авто',
              value: Seller.auto,
              onChanged: (value) {
                setState(() {
                  selectedSellerMode = value;
                });
              },
              groupValue: selectedSellerMode),
          ScreenUtil().setHorizontalSpacing(10.h),
          MyCustomRadioButton(
              text: 'Продавцы',
              value: Seller.select,
              onChanged: (value) {
                setState(() {
                  selectedSellerMode = value;
                });
              },
              groupValue: selectedSellerMode)
        ],
      ),
    );
  }
}
