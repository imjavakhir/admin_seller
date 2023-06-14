import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/widgets/phone_textfield.dart';
import 'package:admin_seller/services/api_service.dart';
import 'package:admin_seller/src/decoration/input_text_mask.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/big_textfield_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/radio_button.dart';
import 'package:admin_seller/src/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Sold { sold, notSold }

Sold soldInfo = Sold.notSold;
bool isSoldInfo = false;

class AddClientpage extends StatelessWidget {
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  AddClientpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenUtil().setVerticalSpacing(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Параметры клиента',
                  style: Styles.headline4,
                ),
              ),
              ScreenUtil().setVerticalSpacing(6.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Красная рубашка, джинсы',
                  style: Styles.headline6.copyWith(fontSize: 18.sp),
                ),
              ),
              ScreenUtil().setVerticalSpacing(10.h),
              PhoneField(
                listformater: [MaskFormat.mask],
                textEditingControllerPhone: _phoneController,
                textEditingControllerName: _fullNameController,
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              BigTextFieldWidget(
                hintext: 'Описание',
                textEditingController: _detailsController,
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              StatefulBuilder(builder: (contex, setState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Состаяние товара',
                        style: Styles.headline4,
                      ),
                      ScreenUtil().setVerticalSpacing(10.h),
                      Row(
                        children: [
                          MyCustomRadioButton(
                              text: 'Не продано',
                              value: Sold.notSold,
                              onChanged: (value) {
                                setState(() {
                                  soldInfo = value;
                                  isSoldInfo = true;
                                  _priceController.clear();
                                });
                              },
                              groupValue: soldInfo),
                          ScreenUtil().setHorizontalSpacing(10.h),
                          MyCustomRadioButton(
                              text: 'Продано',
                              value: Sold.sold,
                              onChanged: (value) {
                                setState(() {
                                  soldInfo = value;
                                  isSoldInfo = false;
                                });
                              },
                              groupValue: soldInfo)
                        ],
                      ),
                      ScreenUtil().setVerticalSpacing(10.h),
                      TextfieldWidget(
                          isDisabled: isSoldInfo,
                          isSoldField: true,
                          paddingW: 0,
                          hintext: '0',
                          textEditingController: _priceController)
                    ],
                  ),
                );
              }),
              ScreenUtil().setVerticalSpacing(30.h),
              const Spacer(),
              LongButton(
                  buttonName: 'Оформить',
                  onTap: () async {
                    if (soldInfo == Sold.notSold) {
                      ApiService().sendNotSoldSelling(
                          details: _detailsController.text,
                          phoneNumber: MaskFormat.mask.getUnmaskedText(),
                          fullName: _fullNameController.text);
                    }
                    if (soldInfo == Sold.sold) {
                      ApiService().sendSoldSelling(
                          details: _detailsController.text,
                          fullName: _fullNameController.text,
                          phoneNumber: MaskFormat.mask.getUnmaskedText(),
                          price: double.parse(_priceController.text));
                    }
                    // LoginService().sendSoldSelling();
                  }),
              ScreenUtil().setVerticalSpacing(30.h),
            ],
          ),
        )
      ]),
      appBar: AppBarWidget(
        title: 'Оформить клиента',
        leading: IconButton(
            splashRadius: 24.r,
            iconSize: 24.h,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              CupertinoIcons.chevron_left,
              color: AppColors.black,
            )),
      ),
    );
  }
}
