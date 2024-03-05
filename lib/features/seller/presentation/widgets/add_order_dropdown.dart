import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';

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
      child: DropdownButtonFormField2(
        menuItemStyleData: MenuItemStyleData(
            height: 56.h, padding: EdgeInsets.symmetric(horizontal: 16.w)),
        hint: Text(
          'Выберите категорию',
          style: Styles.headline4.copyWith(color: AppColors.textfieldText),
        ),
        enableFeedback: false,
        validator: (value) {
          return Validators.empty(value);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          errorStyle: Styles.headline6.copyWith(color: AppColors.red),
          isCollapsed: true,
          filled: true,
          fillColor: AppColors.textfieldBackground,
          errorBorder: Decorations.errorBorder,
          focusedBorder: Decorations.focusedBorder,
          enabledBorder: Decorations.enabledBorder,
          focusedErrorBorder: Decorations.errorBorder,
        ),
        iconStyleData: IconStyleData(
            iconEnabledColor: AppColors.borderColor,
            iconSize: 24.h,
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const Icon(
                CupertinoIcons.chevron_down,
              ),
            )),
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
          height: 56.h,
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
        dropdownStyleData: DropdownStyleData(
          padding: EdgeInsets.zero,
          offset: const Offset(0, -4),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.white),
        ),
        isExpanded: true,
        onChanged: valueChanged,
        value: value,
        items: [
          DropdownMenuItem(
            value: 'заказ',
            child: Text(
              'Заказ',
              style: Styles.headline4,
            ),
          ),
          DropdownMenuItem(
            value: 'Продажа со склада',
            child: Text(
              'продажа со склада',
              style: Styles.headline4,
            ),
          )
        ],
      ),
    );
  }
}
