// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/data/models/search_customer/search_customer.dart';
import 'package:admin_seller/features/seller/presentation/widgets/label_textfield.dart';
import 'package:admin_seller/services/api_service.dart';
import 'package:admin_seller/src/decoration/input_decoration.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

String? sendingFullname;

class PhoneField extends StatefulWidget {
  final TextEditingController textEditingControllerPhone;
  final TextEditingController textEditingControllerName;

  const PhoneField({
    super.key,
    required this.textEditingControllerPhone,
    required this.textEditingControllerName,
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
          child: TypeAheadField<SearchedCustomer?>(
            loadingBuilder: (context) => const SizedBox(),
            textFieldConfiguration: TextFieldConfiguration(
                controller: widget.textEditingControllerPhone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintStyle: Styles.headline4
                        .copyWith(color: AppColors.textfieldText),
                    filled: true,
                    fillColor: AppColors.textfieldBackground,
                    hintText: 'Номер телефона',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    enabledBorder: Decorations.enabledBorder,
                    focusedBorder: Decorations.focusedBorder,
                    errorBorder: Decorations.errorBorder)),
            suggestionsCallback: (pattern) {
              return ApiService().getSearchedCustomer(searchNumber: pattern);
            },
            itemBuilder: (context, itemData) {
              final seachedCustomer = itemData;
              return ListTile(
                visualDensity: const VisualDensity(vertical: -3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                dense: true,
                title: Text(
                  seachedCustomer!.phoneNumber!,
                  style: Styles.headline4,
                ),
                subtitle: Text(
                  seachedCustomer.fullname,
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
                widget.textEditingControllerPhone.text =
                    suggestion!.phoneNumber!;
                widget.textEditingControllerName.text = suggestion.fullname;
                print(sendingFullname);
              });
            },
            debounceDuration: const Duration(milliseconds: 500),
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        LabelTextField(
          textEditingController: widget.textEditingControllerName,
          label: 'Имя и Фамилия',
        ),
      ],
    );
  }
}

  // Autocomplete<String>(
  //           fieldViewBuilder:
  //               (context, textEditingController, focusNode, onFieldSubmitted) =>
  //                   StatefulBuilder(builder: (context, setState) {
  //             return TextfieldWidget(
  //               valueChanged: (value) async {
  //                 if (textEditingController.text.isNotEmpty) {
  //                   searchList = await ApiService()
  //                       .getSearchedCustomer(searchNumber: value);
  //                   list.clear();
  //                 }
  //                 setState(() {
  //                   for (var element in searchList) {
  //                     if (!list.contains(element!.phoneNumber)) {
  //                       list.add(element.phoneNumber!);
  //                     }
  //                   }
  //                 });
  //               },
  //               hintext: 'Номер телефона',
  //               textEditingController: textEditingController,
  //               onEditingComplete: onFieldSubmitted,
  //               focusNode: focusNode,
  //             );
  //           }),
  //           optionsViewBuilder: (context, onSelected, options) {
  //             return Material(
  //               color: Colors.transparent,
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10.r)),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     constraints: BoxConstraints(maxHeight: 235.h),
  //                     margin:
  //                         EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
  //                     decoration: BoxDecoration(
  //                         color: AppColors.white,
  //                         borderRadius: BorderRadius.circular(10.r),
  //                         border: Border.all(color: AppColors.blue, width: 1),
  //                         boxShadow: const [
  //                           BoxShadow(
  //                               blurRadius: 20,
  //                               color: AppColors.cardShadow,
  //                               offset: Offset(0, 0))
  //                         ]),
  //                     child: ListView.separated(
  //                         separatorBuilder: (context, index) => Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: 10.w),
  //                             child: const Divider(
  //                               color: AppColors.dividerColor,
  //                               height: 0,
  //                             )),
  //                         shrinkWrap: true,
  //                         padding: EdgeInsets.zero,
  //                         itemBuilder: (context, index) {
  //                           final option = options.elementAt(index);

  //                           return StatefulBuilder(
  //                               builder: (context, setState) {
  //                             return Material(
  //                               color: Colors.transparent,
  //                               shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10.r)),
  //                               child: ListTile(
  //                                 enableFeedback: false,
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10.r),
  //                                 ),
  //                                 onTap: () {
  //                                   setState(() {
  //                                     sendingphoneNumber = option;
  //                                   });
  //                                   onSelected(option);
  //                                 },
  //                                 dense: true,
  //                                 title: Text(
  //                                   option.toString(),
  //                                   style: Styles.headline4,
  //                                 ),
  //                               ),
  //                             );
  //                           });
  //                         },
  //                         itemCount: options.length),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //           optionsBuilder: (textEditingValue) {
  //             if (textEditingValue == '') {
  //               return const Iterable<String>.empty();
  //             }
  //             return list.where((String item) {
  //               return item
  //                   .toLowerCase()
  //                   .contains(textEditingValue.text.toLowerCase());
  //             });
  //           },
  //           onSelected: (option) {
  //             print('was $option selected');
  //           },
  //         ),