import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/presentation/pages/selling_warehouse.dart';
import 'package:admin_seller/features/seller/presentation/widgets/order_tile_widget.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WarehouseCardWidget extends StatelessWidget {
  final VoidCallback onTapFirst;
  final VoidCallback onTapSecond;
  final VoidCallback onTapThird;
  final String id;
  final String warehouse;
  final String furnitureType;
  final String tissue;
  final String details;
  final String furnitureModel;
  final String productStatus;
  final bool canChange;

  const WarehouseCardWidget({
    this.productStatus = ProductStatus.active,
    super.key,
    required this.id,
    required this.warehouse,
    required this.furnitureType,
    required this.tissue,
    required this.details,
    required this.furnitureModel,
    this.canChange = false,
    required this.onTapFirst,
    required this.onTapSecond,
    required this.onTapThird,
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
          if (productStatus == ProductStatus.booked)
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
          if (productStatus == ProductStatus.active)
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
          OrderCardTile(
            leading: 'ID',
            trailing: id,
          ),
          OrderCardTile(
            leading: 'Склад',
            trailing: warehouse,
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
            leading: 'Примичение',
            trailing: details,
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: LongButton(
                isDisabled: !canChange && productStatus == ProductStatus.booked,
                paddingW: 8,
                buttonName: productStatus == ProductStatus.active
                    ? 'Бронь'
                    : 'Отменить',
                onTap: productStatus == ProductStatus.active
                    ? onTapFirst
                    : onTapSecond,
                height: 36,
                fontsize: 14,
              )),
              Expanded(
                  child: LongButton(
                paddingW: 8,
                isDisabled: !canChange || productStatus != ProductStatus.booked,
                buttonName: 'Выбрать',
                fontsize: 14,
                onTap: onTapThird,
                height: 36,
              )),
            ],
          )
        ],
      ),
    );
  }
}
