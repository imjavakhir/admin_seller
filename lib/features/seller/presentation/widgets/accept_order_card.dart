import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/pages/add_order.dart';
import 'package:admin_seller/features/seller/presentation/widgets/order_tile_widget.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AcceptOrderCard extends StatelessWidget {
  final String id;
  final String category;
  final String idModel;
  final String furnitureType;
  final String furnitureModel;
  final String tissue;
  final double price;
  final double priceSale;
  final int count;
  final String details;
  final double salePercent;
  final double total;
  final OrderListModel orderListModelItem;

  const AcceptOrderCard({
    super.key,
    required this.id,
    required this.category,
    required this.idModel,
    required this.furnitureType,
    required this.furnitureModel,
    required this.tissue,
    required this.price,
    required this.priceSale,
    required this.count,
    required this.details,
    required this.salePercent,
    required this.total,
    required this.orderListModelItem,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
          extentRatio: 1 / 2,
          motion: const ScrollMotion(),
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 24.w, top: 5.h, bottom: 5.h),
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
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
                          style:
                              Styles.headline4.copyWith(color: AppColors.red),
                        )
                      ],
                    )),
              ),
            )
          ]),
      child: Container(
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
        height: 300.h,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderCardTile(
              leading: 'Категория',
              trailing: category,
            ),
            OrderCardTile(
              leading: 'ID',
              trailing: id,
            ),
            OrderCardTile(
              leading: 'Вид мебели',
              trailing: furnitureType,
            ),
            OrderCardTile(
              leading: 'Модель',
              trailing: furnitureModel,
            ),
            OrderCardTile(
              leading: 'Ткань',
              trailing: tissue,
            ),
            OrderCardTile(
              leading: 'Примечание',
              trailing: details,
            ),
            OrderCardTile(
              leading: 'Цена',
              trailing: '$price сум',
            ),
            OrderCardTile(
              leading: 'Цена со скидкой',
              trailing: '$priceSale сум',
            ),
            OrderCardTile(
              leading: 'Скидка',
              trailing: '${((salePercent) * 100).ceil() / 100} %',
            ),
            OrderCardTile(
              leading: 'Количество',
              trailing: '$count',
            ),
            OrderCardTile(
              leading: 'Сумма',
              trailing: '$total сум',
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
  }
}
