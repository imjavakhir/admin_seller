import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCustomRadioButton<T> extends StatelessWidget {
  final T value;
  final ValueChanged onChanged;
  final T groupValue;
  final String? text;

  const MyCustomRadioButton(
      {super.key,
      required this.text,
      required this.value,
      required this.onChanged,
      required this.groupValue});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRadio(),
        const SizedBox(
          width: 8,
        ),
        _buildText()
      ],
    );
  }

  Widget _buildRadio() {
    final bool isSelected = value == groupValue;
    return MaterialButton(
      highlightColor: AppColors.blue.withOpacity(0.2),
      enableFeedback: false,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 24.h,
      height: 24.h,
      visualDensity: const VisualDensity(horizontal: -3, vertical: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
      onPressed: () => onChanged(value),
      child: Container(
          alignment: Alignment.center,
          height: 22,
          width: 22,
          decoration: ShapeDecoration(
              shape: CircleBorder(
                  side: BorderSide(
                      color: isSelected ? AppColors.blue : AppColors.grey,
                      width: 1.5))),
          child: CircleAvatar(
            backgroundColor: isSelected ? AppColors.blue : AppColors.white,
            radius: 7,
          )),
    );
  }

  Widget _buildText() {
    return Text(
      text!,
      style: Styles.headline5M,
    );
  }
}
