import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_icons.dart';
import 'package:admin_seller/src/decoration/input_decoration.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/validators/validators.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDownClientFrom extends StatelessWidget {
  final ValueChanged? valueChanged;
  final String? value;
  const DropDownClientFrom({
    super.key,
    required this.valueChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            'Откуда узнал о нас',
            style: Styles.headline4,
          ),
        ),
        ScreenUtil().setVerticalSpacing(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: DropdownButtonFormField2(
              hint: Text(
                'Откуда узнал о нас',
                style:
                    Styles.headline4.copyWith(color: AppColors.textfieldText),
              ),
              validator: (value) {
                return Validators.empty(value);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.textfieldBackground,
                  errorBorder: Decorations.errorBorder,
                  focusedBorder: Decorations.focusedBorder,
                  enabledBorder: Decorations.enabledBorder,
                  focusedErrorBorder: Decorations.errorBorder,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w)),
              enableFeedback: false,
              autofocus: true,
              barrierColor: Colors.grey.withOpacity(0.8),
              iconStyleData: IconStyleData(
                  iconEnabledColor: AppColors.borderColor,
                  iconSize: 24.h,
                  icon: const Icon(
                    CupertinoIcons.chevron_down,
                  )),
              dropdownStyleData: DropdownStyleData(
                padding: EdgeInsets.zero,
                offset: const Offset(0, -4),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.white),
              ),
              menuItemStyleData: MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16.w)),
              buttonStyleData: ButtonStyleData(
                width: double.maxFinite,
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10.r),
                //     color: AppColors.textfieldBackground,
                //     border:
                //         Border.all(width: 1, color: AppColors.borderColor))
              ),
              value: value,
              onChanged: valueChanged,
              items: [
                DropdownMenuItem(
                  value: 'instagram',
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.instagram,
                        height: 24.h,
                        width: 24.h,
                      ),
                      ScreenUtil().setHorizontalSpacing(16.w),
                      Text(
                        'Instagram',
                        style: Styles.headline4,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'telegram',
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.telegram,
                        height: 24.h,
                        width: 24.h,
                      ),
                      ScreenUtil().setHorizontalSpacing(16.w),
                      Text(
                        'Telegram',
                        style: Styles.headline4,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'facebook',
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.facebook,
                        height: 24.h,
                        width: 24.h,
                      ),
                      ScreenUtil().setHorizontalSpacing(16.w),
                      Text(
                        'Facebook',
                        style: Styles.headline4,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'recommended',
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.recommended,
                        height: 24.h,
                        width: 24.h,
                      ),
                      ScreenUtil().setHorizontalSpacing(16.w),
                      Text(
                        'Recommended',
                        style: Styles.headline4,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'banner',
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.baner,
                        height: 24.h,
                        width: 24.h,
                      ),
                      ScreenUtil().setHorizontalSpacing(16.w),
                      Text(
                        'Banner',
                        style: Styles.headline4,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'other',
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.other,
                        height: 24.h,
                        width: 24.h,
                      ),
                      ScreenUtil().setHorizontalSpacing(16.w),
                      Text(
                        'Other',
                        style: Styles.headline4,
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}
