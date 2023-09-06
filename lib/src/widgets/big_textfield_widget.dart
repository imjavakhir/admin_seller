import 'package:admin_seller/app_const/app_exports.dart';

class BigTextFieldWidget extends StatelessWidget {
  final String hintext;
  final TextEditingController textEditingController;
  final GlobalKey? textFieldKey = GlobalKey(debugLabel: 'bigTextFieldKey');
  final String? Function(String?)? validator;
  final ValueChanged? valueChanged;
  BigTextFieldWidget({
    super.key,
    required this.hintext,
    required this.textEditingController,
    this.validator,
    this.valueChanged,
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
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            onChanged: valueChanged,
            validator: validator,
            // key: textFieldKey,
            // onTap: () {
            //   Scrollable.ensureVisible(textFieldKey!.currentContext!);
            // },
            controller: textEditingController,
            maxLines: 10,
            decoration: InputDecoration(
                errorStyle: Styles.headline6.copyWith(color: AppColors.red),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                filled: true,
                fillColor: AppColors.textfieldBackground,
                hintText: hintext,
                focusedErrorBorder: Decorations.errorBorder,
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
