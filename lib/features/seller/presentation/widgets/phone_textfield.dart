// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/data/models/search_customer/search_customer.dart';
import 'package:admin_seller/features/seller/presentation/widgets/dropdown_client_from.dart';
import 'package:admin_seller/features/seller/presentation/widgets/label_textfield.dart';
import 'package:admin_seller/features/seller/repository/seller_repo.dart';
import 'package:admin_seller/src/decoration/input_decoration.dart';
import 'package:admin_seller/src/decoration/input_text_mask.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PhoneField extends StatefulWidget {
  final TextEditingController textEditingControllerPhone;
  final TextEditingController textEditingControllerName;
  final List<TextInputFormatter>? listformater;
  final ValueChanged? valueChanged;
  final ValueChanged? valueChangedname;
  final String? Function(String?)? validator;
  final String? Function(String?)? validatorName;
  final GlobalKey<FormState>? formState;
  final ValueChanged valueChangedDrop;
  final String? valueDrop;
  final TextEditingController textEditingControllerID;

  const PhoneField({
    super.key,
    required this.textEditingControllerPhone,
    required this.textEditingControllerName,
    this.listformater,
    this.valueChanged,
    this.validator,
    this.validatorName,
    this.formState,
    this.valueChangedname,
    required this.valueChangedDrop,
    this.valueDrop,
    required this.textEditingControllerID,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            'Номер телефона',
            style: Styles.headline4,
          ),
        ),
        ScreenUtil().setVerticalSpacing(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: TypeAheadFormField<SearchedCustomers?>(
            validator: widget.validator,
            loadingBuilder: (context) => const SizedBox(),
            textFieldConfiguration: TextFieldConfiguration(
                onChanged: widget.valueChanged,
                inputFormatters: widget.listformater,
                controller: widget.textEditingControllerPhone,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    prefixIconConstraints: const BoxConstraints(),
                    prefixIcon: Container(
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
                    ),
                    isCollapsed: true,
                    hintStyle: Styles.headline4
                        .copyWith(color: AppColors.textfieldText),
                    filled: true,
                    fillColor: AppColors.textfieldBackground,
                    hintText: 'Номер телефона',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    enabledBorder: Decorations.enabledBorder,
                    focusedErrorBorder: Decorations.errorBorder,
                    focusedBorder: Decorations.focusedBorder,
                    errorBorder: Decorations.errorBorder)),
            suggestionsCallback: (pattern) {
              print(MaskFormat.mask.getUnmaskedText());
              return SellerRepository().getSearchedCustomer(
                  searchNumber: MaskFormat.mask.getUnmaskedText());
            },
            itemBuilder: (context, itemData) {
              final seachedCustomer = itemData;
              return ListTile(
                enableFeedback: false,
                visualDensity: const VisualDensity(vertical: -3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                dense: true,
                title: Text(
                  seachedCustomer!.customer!.phoneNumber!,
                  style: Styles.headline4,
                ),
                subtitle: Text(
                  seachedCustomer.customer!.fullname!,
                  style: Styles.headline6,
                ),
              );
            },
            noItemsFoundBuilder: (context) {
              return const SizedBox();
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: const BorderSide(
                      width: 1,
                      color: AppColors.blue,
                    )),
                constraints: const BoxConstraints(maxHeight: 250)),
            onSuggestionSelected: (suggestion) {
              setState(() {
                widget.textEditingControllerID.text =
                    suggestion!.whereComeFrom!;

                widget.textEditingControllerPhone.text =
                    '(${suggestion.customer!.phoneNumber![0]}${suggestion.customer!.phoneNumber![1]}) ${suggestion.customer!.phoneNumber![2]}${suggestion.customer!.phoneNumber![3]}${suggestion.customer!.phoneNumber![4]}-${suggestion.customer!.phoneNumber![5]}${suggestion.customer!.phoneNumber![6]}-${suggestion.customer!.phoneNumber![7]}${suggestion.customer!.phoneNumber![8]}';
                widget.textEditingControllerName.text =
                    suggestion.customer!.fullname!;

                print('---------${suggestion.customer!.phoneNumber!}---------');
              });
            },
            debounceDuration: const Duration(milliseconds: 500),
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        Form(
          key: widget.formState,
          child: LabelTextField(
            valueChanged: widget.valueChangedname,
            validator: widget.validatorName,
            textEditingController: widget.textEditingControllerName,
            label: 'Имя и Фамилия',
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        DropDownClientFrom(
          value: widget.textEditingControllerID.text != ''
              ? widget.textEditingControllerID.text
              : widget.valueDrop,
          valueChanged: widget.valueChangedDrop,
        ),
      ],
    );
  }
}
