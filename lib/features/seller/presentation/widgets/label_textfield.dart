import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final ValueChanged? valueChanged;
    final String? Function(String?)? validator;

  final TextEditingController textEditingController;
  const LabelTextField({
    super.key,
    required this.label,
    required this.textEditingController,
    this.initialValue, this.valueChanged, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            label,
            style: Styles.headline4,
          ),
        ),
        ScreenUtil().setVerticalSpacing(10.h),
        TextfieldWidget(
          validator: validator,
          valueChanged: valueChanged,
          initialValue: initialValue,
          hintext: label,
          textEditingController: textEditingController,
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}
