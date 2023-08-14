import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/pages/accept_order.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellingWareHouse extends StatelessWidget {
  const SellingWareHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Продажа со склада',
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: listWarehouse.length,
              itemBuilder: (BuildContext context, int index) {
                return listWarehouse[index];
              },
            ),
          ),
          ScreenUtil().setVerticalSpacing(96),
        ],
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 96.h,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(width: 0, color: AppColors.grey))),
        child: LongButton(
          buttonName: 'Сохранить',
          onTap: () {},
        ),
      ),
    );
  }
}

List<Widget?> listWarehouse = [
  const WarehouseCardWidget(
    isBooked: true,
  ),
  const WarehouseCardWidget(),
];

class WarehouseCardWidget extends StatelessWidget {
  final bool isBooked;
  const WarehouseCardWidget({
    this.isBooked = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                blurRadius: 20.r,
                color: AppColors.cardShadow,
                offset: const Offset(0, 0))
          ]),
      height: 250.h,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isBooked)
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: AppColors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100.r)),
              height: 30.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.exclamationmark_circle_fill,
                    size: 20.h,
                    color: AppColors.orange,
                  ),
                  ScreenUtil().setHorizontalSpacing(4),
                  Text(
                    'Забронирована',
                    style: Styles.headline5M.copyWith(color: AppColors.orange),
                  ),
                ],
              ),
            ),
          if (!isBooked)
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100.r)),
              height: 30.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    size: 20.h,
                    color: AppColors.green,
                  ),
                  ScreenUtil().setHorizontalSpacing(4),
                  Text(
                    'Готова',
                    style: Styles.headline5M.copyWith(color: AppColors.green),
                  ),
                ],
              ),
            ),
          ScreenUtil().setVerticalSpacing(6),
          const OrderCardTile(
            leading: 'ID',
            trailing: '848484',
          ),
          const OrderCardTile(
            leading: 'Склад',
            trailing: 'Чиланзарский склад',
          ),
          const OrderCardTile(
            leading: 'Вид мебели',
            trailing: 'Диван Прямой',
          ),
          const OrderCardTile(
            leading: 'Модель',
            trailing: 'Оливия',
          ),
          const OrderCardTile(
            leading: 'Ткань',
            trailing: 'Хопе',
          ),
          const OrderCardTile(
            leading: 'Примичение',
            trailing: 'Криса',
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: LongButton(
                buttonName: 'Бронь',
                onTap: () {},
                height: 40,
                fontsize: 16,
              )),
              Expanded(
                  child: LongButton(
                isDisabled: true,
                buttonName: 'Выбрать',
                fontsize: 16,
                onTap: () {},
                height: 40,
              )),
            ],
          )
        ],
      ),
    );
  }
}
