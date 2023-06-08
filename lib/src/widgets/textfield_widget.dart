import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/decoration/input_decoration.dart';
import 'package:admin_seller/src/theme/text_styles.dart';

class TextfieldWidget extends StatelessWidget {
  final String hintext;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final bool obsecure;
  final VoidCallback? eyeTap;
  final bool isPasswordField;
  const TextfieldWidget(
      {Key? key,
      required this.hintext,
      this.textInputType = TextInputType.text,
      required this.textEditingController,
      this.obsecure = false,
      this.eyeTap,
      this.isPasswordField = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: TextField(
          obscureText: obsecure,
          textInputAction: TextInputAction.next,
          controller: textEditingController,
          keyboardType: textInputType,
          decoration: InputDecoration(
              suffixIcon: isPasswordField
                  ? IconButton(
                    enableFeedback: false,
                      onPressed: eyeTap,
                      splashRadius: 24,
                      icon: Icon(
                        obsecure
                            ? CupertinoIcons.eye_slash_fill
                            : CupertinoIcons.eye_fill,
                        color: AppColors.greyIcon,
                      ))
                  : null,
              hintText: hintext,
              hintStyle:
                  Styles.headline4.copyWith(color: AppColors.textfieldText),
              prefixIconConstraints: const BoxConstraints(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              filled: true,
              fillColor: AppColors.textfieldBackground,
              enabledBorder: Decorations.enabledBorder,
              focusedBorder: Decorations.focusedBorder,
              errorBorder: Decorations.errorBorder),
        ));
  }
}
