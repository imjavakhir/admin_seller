import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/seller/presentation/widgets/add_order_button.dart';
import 'package:admin_seller/features/seller/presentation/widgets/add_order_dropdown.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOrderPage extends StatelessWidget {
  const AddOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'Добавить заказ',
          leading: IconButton(
              enableFeedback: false,
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenUtil().setVerticalSpacing(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Text(
                      'ID',
                      style: Styles.headline4,
                    ),
                    const Spacer(),
                    Text(
                      '3526189',
                      style: Styles.headline4Reg,
                    )
                  ],
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Категория',
                  style: Styles.headline4,
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              DropDownOrderWidget(
                valueChanged: (value) {
                  if (value == 'warehouse') {
                    Navigator.of(context).pushNamed(AppRoutes.sellingWarehouse);
                  }
                },
              ),
              ScreenUtil().setVerticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Вид мебели',
                  style: Styles.headline4,
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              AddOrderButtonWidget(
                onPress: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    context: context,
                    builder: (context) {
                      return const ModelBottomSheetWidget();
                    },
                  );
                },
                hint: 'Виберите вид мебеля',
              ),
              ScreenUtil().setVerticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Модель',
                  style: Styles.headline4,
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              AddOrderButtonWidget(
                onPress: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    context: context,
                    builder: (context) {
                      return const ModelBottomSheetWidget();
                    },
                  );
                },
                hint: 'Виберите модель',
              ),
              ScreenUtil().setVerticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Ткань',
                  style: Styles.headline4,
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              TextfieldWidget(
                  hintext: 'Ткань',
                  textEditingController: TextEditingController()),
              ScreenUtil().setVerticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Цена',
                  style: Styles.headline4,
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              TextfieldWidget(
                  hintext: 'Цена',
                  textEditingController: TextEditingController()),
              ScreenUtil().setVerticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Цена со скидкой',
                  style: Styles.headline4,
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              TextfieldWidget(
                  hintext: 'Цена со скидкой',
                  textEditingController: TextEditingController()),
              ScreenUtil().setVerticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Количество',
                  style: Styles.headline4,
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              TextfieldWidget(
                  hintext: 'Количество',
                  textEditingController: TextEditingController()),
              ScreenUtil().setVerticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Text(
                      'Скидка',
                      style: Styles.headline4,
                    ),
                    const Spacer(),
                    Text(
                      '13%',
                      style: Styles.headline4,
                    )
                  ],
                ),
              ),
              ScreenUtil().setVerticalSpacing(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Text(
                      'Сумма',
                      style: Styles.headline4,
                    ),
                    const Spacer(),
                    Text(
                      '13 000 000 сум',
                      style: Styles.headline4,
                    ),
                  ],
                ),
              ),
              ScreenUtil().setVerticalSpacing(20),
              LongButton(buttonName: 'Добавить', onTap: () {}),
              ScreenUtil().setVerticalSpacing(20),
            ],
          ),
        ),
      ),
    );
  }
}

class ModelBottomSheetWidget extends StatelessWidget {
  const ModelBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 1,
      maxChildSize: 1,
      initialChildSize: 1,
      builder: (context, scrollController) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScreenUtil().setVerticalSpacing(24),
          Center(
            child: Text(
              'Виберите модель',
              style: Styles.headline2,
            ),
          ),
          ScreenUtil().setVerticalSpacing(10),
          const Divider(
            height: 0,
            color: AppColors.grey,
          ),
          Flexible(
            child: Scrollbar(
              radius: Radius.circular(100.r),
              thickness: 4,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    onTap: () {},
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                    ),
                    dense: true,
                    title: Text(
                      '$index mebel',
                      style: Styles.headline5M,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
