import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';

class TextfieldWidget extends StatelessWidget {
  final String hintext;
  final String? initialValue;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final bool obsecure;
  final VoidCallback? eyeTap;
  final bool isPasswordField;
  final double paddingW;
  final bool isSoldField;
  final bool isDisabled;
  final Widget? suffixWidget;
  final Function()? onEditingComplete;
  final ValueChanged? valueChanged;
  final bool isPhoneNumber;
  final List<TextInputFormatter>? listFormater;
  final GlobalKey? textFieldKey = GlobalKey(debugLabel: 'textFfieldKey');
  final String? Function(String?)? validator;
  final bool isSum;
  final bool isReadOnly;
  final VoidCallback? onTap;
  TextfieldWidget({
    Key? key,
    required this.hintext,
    this.isReadOnly = false,
    this.onTap,
    this.suffixWidget,
    this.isSum = true,
    this.textInputType = TextInputType.text,
    required this.textEditingController,
    this.obsecure = false,
    this.eyeTap,
    this.isPhoneNumber = false,
    this.isPasswordField = false,
    this.paddingW = 24,
    this.isSoldField = false,
    this.isDisabled = false,
    this.onEditingComplete,
    this.valueChanged,
    this.initialValue,
    this.listFormater,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingW.w),
        child: TextFormField(
          maxLength: isSoldField ? 11 : null,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // key: textFieldKey,
          // onTap: () {
          //   Scrollable.ensureVisible(textFieldKey!.currentContext!);
          // },
          onTap: onTap,
          initialValue: initialValue,
          onChanged: valueChanged,
          enableSuggestions: false,
          style: Styles.headline4,
          onEditingComplete: onEditingComplete,
          enabled: !isDisabled,
          inputFormatters: listFormater,
          readOnly: isReadOnly,
          obscureText: obsecure,
          textInputAction: TextInputAction.next,
          controller: textEditingController,
          keyboardType: textInputType,
          decoration: InputDecoration(
              errorStyle: Styles.headline6.copyWith(color: AppColors.red),
              counterText: '',
              isCollapsed: true,
              prefixIcon: isPhoneNumber
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: 1, color: AppColors.textfieldText))),
                      child: Text(
                        '+998',
                        style: Styles.headline4,
                      ),
                    )
                  : null,
              disabledBorder: Decorations.disabledBorder,
              suffix: isSoldField
                  ? Text(
                      isSum ? 'Сум' : '\$',
                      style: Styles.headline5,
                    )
                  : null,
              suffixIcon: isPasswordField
                  ? IconButton(
                      enableFeedback: false,
                      onPressed: eyeTap,
                      splashRadius: 24.r,
                      icon: Icon(
                        obsecure
                            ? CupertinoIcons.eye_slash_fill
                            : CupertinoIcons.eye_fill,
                        color: AppColors.greyIcon,
                      ))
                  : suffixWidget,
              hintText: hintext,
              hintStyle:
                  Styles.headline4.copyWith(color: AppColors.textfieldText),
              prefixIconConstraints: const BoxConstraints(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              filled: true,
              focusedErrorBorder: Decorations.errorBorder,
              fillColor: AppColors.textfieldBackground,
              enabledBorder: Decorations.enabledBorder,
              focusedBorder: Decorations.focusedBorder,
              errorBorder: Decorations.errorBorder),
        ));
  }
}
