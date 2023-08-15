import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/pages/accept_order.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Заказы',
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
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
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
            height: 160.h,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OrderCardTile(
                  leading: 'ID',
                  trailing: '848484',
                ),
                const OrderCardTile(
                  leading: 'Клиент',
                  trailing: 'Лили',
                ),
                const OrderCardTile(
                  leading: 'Остаток',
                  trailing: '12 000 000 сум',
                ),
                const OrderCardTile(
                  leading: 'Статус',
                  trailing: 'В таблице',
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            visualDensity: const VisualDensity(vertical: -2),
                            foregroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.r))),
                        onPressed: () {},
                        child: Text(
                          'Подробнее',
                          style: Styles.headline5M
                              .copyWith(color: AppColors.primaryColor),
                        )),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
