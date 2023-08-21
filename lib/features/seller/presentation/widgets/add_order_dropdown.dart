import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/textfield_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownOrderWidget extends StatelessWidget {
  final ValueChanged valueChanged;
  final String? value;
  const DropDownOrderWidget({
    super.key,
    required this.valueChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: DropdownButton2(
        menuItemStyleData: MenuItemStyleData(height: 56.h),
        hint: Text(
          'Выберите категорию',
          style: Styles.headline4.copyWith(color: AppColors.textfieldText),
        ),
        enableFeedback: false,
        underline: const SizedBox(),
        iconStyleData: IconStyleData(
            iconEnabledColor: AppColors.borderColor,
            iconSize: 24.h,
            icon: const Icon(
              CupertinoIcons.chevron_down,
            )),
        buttonStyleData: ButtonStyleData(
            width: double.maxFinite,
            height: 56.h,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
                color: AppColors.textfieldBackground,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(width: 1, color: AppColors.borderColor))),
        dropdownStyleData: DropdownStyleData(
            offset: const Offset(0, -4),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.white,
                border: Border.all(width: 1, color: AppColors.borderColor))),
        isExpanded: true,
        onChanged: valueChanged,
        value: value,
        items: [
          DropdownMenuItem(
            value: 'Заказ',
            child: Text(
              'Заказ',
              style: Styles.headline4,
            ),
          ),
          DropdownMenuItem(
            value: 'Продажа со склада',
            child: Text(
              'Продажа со склада',
              style: Styles.headline4,
            ),
          )
        ],
      ),
    );
  }
}
