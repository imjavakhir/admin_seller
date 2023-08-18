import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AcceptOrderPage extends StatelessWidget {
  const AcceptOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Приём заказа',
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
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  endActionPane: ActionPane(
                      extentRatio: 1 / 2,
                      motion: const ScrollMotion(),
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 24.w, top: 5.h, bottom: 5.h),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    foregroundColor: Colors.red),
                                onPressed: () {
                                  debugPrint('statement');
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.delete,
                                      color: AppColors.red,
                                    ),
                                    Text(
                                      'Удалить',
                                      style: Styles.headline4
                                          .copyWith(color: AppColors.red),
                                    )
                                  ],
                                )),
                          ),
                        )
                      ]),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 20.r,
                              color: AppColors.cardShadow,
                              offset: const Offset(0, 0))
                        ]),
                    height: 300.h,
                    width: double.maxFinite,
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const OrderCardTile(
                          leading: 'Категория',
                          trailing: 'Заказ',
                        ),
                        const OrderCardTile(
                          leading: 'ID',
                          trailing: '3526849',
                        ),
                        const OrderCardTile(
                          leading: 'Вид мебели',
                          trailing: 'Матрас',
                        ),
                        const OrderCardTile(
                          leading: 'Модель',
                          trailing: 'Муга',
                        ),
                        const OrderCardTile(
                          leading: 'Ткань',
                          trailing: 'Хопе',
                        ),
                        const OrderCardTile(
                          leading: 'Примечание',
                          trailing: 'Криса',
                        ),
                        const OrderCardTile(
                          leading: 'Цена',
                          trailing: '1 000 000 сум',
                        ),
                        const OrderCardTile(
                          leading: 'Цена со скидкой',
                          trailing: '950 000 сум',
                        ),
                        const OrderCardTile(
                          leading: 'Скидка',
                          trailing: '5%',
                        ),
                        const OrderCardTile(
                          leading: 'Количество',
                          trailing: '1',
                        ),
                        const OrderCardTile(
                          leading: 'Сумма',
                          trailing: '950 000 сум',
                        ),
                        const Spacer(),
                        LongButton(
                          buttonName: 'Изменить',
                          onTap: () {},
                          height: 36,
                          fontsize: 14,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ScreenUtil().setVerticalSpacing(96)
        ],
      ),
      bottomSheet: Container(
        height: 96.h,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(width: 0, color: AppColors.grey))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: LongButton(
                  buttonName: 'Подвердить',
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.checkOrder);
                  }),
            ),
            Container(
              height: 56.h,
              width: 56.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.primaryColor),
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.addOrder);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                child: const Icon(
                  CupertinoIcons.cart_badge_plus,
                ),
              ),
            ),
            ScreenUtil().setHorizontalSpacing(24),
          ],
        ),
      ),
    );
  }
}

class OrderCardTile extends StatelessWidget {
  final String leading;
  final String trailing;
  const OrderCardTile({
    super.key,
    required this.leading,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 0,
        color: AppColors.grey,
      ))),
      child: Row(
        children: [
          Text(
            leading,
            style: Styles.headline5.copyWith(color: AppColors.grey),
          ),
          const Spacer(),
          SizedBox(
            width: 180.w,
            child: Text(
              trailing,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: Styles.headline5M.copyWith(color: AppColors.black),
            ),
          )
        ],
      ),
    );
  }
}
