import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/decoration/input_decoration.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigTextFieldWidget extends StatelessWidget {
  final String hintext;
  final TextEditingController textEditingController;
  final GlobalKey? textFieldKey = GlobalKey(debugLabel: 'bigTextFieldKey');
  BigTextFieldWidget({
    super.key,
    required this.hintext,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintext,
            style: Styles.headline4,
          ),
          ScreenUtil().setVerticalSpacing(10.h),
          TextField(
            key: textFieldKey,
            onTap: () {
              Scrollable.ensureVisible(textFieldKey!.currentContext!);
            },
            controller: textEditingController,
            maxLines: 10,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                filled: true,
                fillColor: AppColors.textfieldBackground,
                hintText: hintext,
                hintStyle:
                    Styles.headline4.copyWith(color: AppColors.textfieldText),
                enabledBorder: Decorations.enabledBorder,
                focusedBorder: Decorations.focusedBorder,
                errorBorder: Decorations.errorBorder),
          )
        ],
      ),
    );
  }
}
