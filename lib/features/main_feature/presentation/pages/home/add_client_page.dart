import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/presentation/widgets/label_textfield.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/big_textfield_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddClientpage extends StatelessWidget {
  const AddClientpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
          const LabelTextField(
            label: 'Номер телефона',
          ),
          ScreenUtil().setVerticalSpacing(20.h),
          const LabelTextField(
            label: 'Имя и Фамилия',
          ),
          ScreenUtil().setVerticalSpacing(20.h),
        BigTextFieldWidget(hintext: 'Описание',textEditingController: TextEditingController(),),
          ScreenUtil().setVerticalSpacing(30.h),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: LongButton(buttonName: 'Оформить', onTap: () {}),
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
