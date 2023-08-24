import 'package:admin_seller/app_const/app_exports.dart';

import 'package:flutter/cupertino.dart';

class AddPaymentPage extends StatelessWidget {
  const AddPaymentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenUtil().setVerticalSpacing(24),
            Center(
              child: Text(
                'Выберите продавца',
                style: Styles.headline2,
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            const Divider(
              color: AppColors.grey,
              height: 0,
            ),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Вид оплаты',
                style: Styles.headline4,
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            const AddPaymentDropDownWidget(),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Предоплата(Сум)',
                style: Styles.headline4,
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            TextfieldWidget(
                listFormater: [ThousandsSeparatorInputFormatter()],
                isSoldField: true,
                hintext: 'Предоплата(Сум)',
                textEditingController: TextEditingController()),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Предоплата(\$)',
                style: Styles.headline4,
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            TextfieldWidget(
                listFormater: [ThousandsSeparatorInputFormatter()],
                isSum: false,
                isSoldField: true,
                hintext: 'Предоплата(\$)',
                textEditingController: TextEditingController()),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Здачи',
                style: Styles.headline4,
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            TextfieldWidget(
                listFormater: [ThousandsSeparatorInputFormatter()],
                isSoldField: true,
                hintext: 'Здачи',
                textEditingController: TextEditingController()),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Курс \$100',
                style: Styles.headline4,
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            TextfieldWidget(
                listFormater: [ThousandsSeparatorInputFormatter()],
                isSoldField: true,
                hintext: 'Курс \$100',
                textEditingController: TextEditingController()),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Text(
                    'Сумма по курсу',
                    style: Styles.headline4,
                  ),
                  const Spacer(),
                  Text(
                    '1 245 000',
                    style: Styles.headline4Reg,
                  ),
                ],
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Text(
                    'Итого(Сум)',
                    style: Styles.headline4,
                  ),
                  const Spacer(),
                  Text(
                    '1 245 000',
                    style: Styles.headline4Reg,
                  ),
                ],
              ),
            ),
            ScreenUtil().setVerticalSpacing(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Text(
                    'Остаток',
                    style: Styles.headline4,
                  ),
                  const Spacer(),
                  Text(
                    '1 245 000',
                    style: Styles.headline4Reg,
                  ),
                ],
              ),
            ),
            ScreenUtil().setVerticalSpacing(120),
            LongButton(
                buttonName: 'Сохранить',
                onTap: () {
                  Navigator.of(context).pop();
                }),
            ScreenUtil().setVerticalSpacing(20)
          ],
        ),
      ),
    );
  }
}

class AddPaymentDropDownWidget extends StatelessWidget {
  const AddPaymentDropDownWidget({
    super.key,
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
        onChanged: (value) {},
        items: [
          DropdownMenuItem(
            value: 'cashwithcheck',
            child: Text(
              'Наличние с чеком',
              style: Styles.headline4,
            ),
          ),
          DropdownMenuItem(
            value: 'cash',
            child: Text(
              'Наличние без чека',
              style: Styles.headline4,
            ),
          )
        ],
      ),
    );
  }
}
