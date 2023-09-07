
import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/presentation/widgets/add_order_field.dart';
class OrderReceiptInfo extends StatelessWidget {
  final OrderListModel orderListModelItem;
  final int index;
  const OrderReceiptInfo({
    required this.index,
    super.key,
    required this.orderListModelItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 24.w),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 20.r,
              color: AppColors.cardShadow,
              offset: const Offset(4, 4))
        ],
        border: const Border(
          right: BorderSide(
            width: 0,
            color: AppColors.grey,
          ),
          bottom: BorderSide(
            width: 0,
            color: AppColors.grey,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}.',
            style: Styles.headline5M,
          ),
          ReceiptCardTile(
            leading: 'Категория',
            trailing: orderListModelItem.category,
          ),
          ReceiptCardTile(
            leading: 'ID',
            trailing: orderListModelItem.id,
          ),
          ReceiptCardTile(
            leading: 'Вид мебели',
            trailing: orderListModelItem.furnitureType,
          ),
          ReceiptCardTile(
            leading: 'Модель',
            trailing: orderListModelItem.furnitureModel,
          ),
          ReceiptCardTile(
            leading: 'Ткань',
            trailing: orderListModelItem.tissue,
          ),
          ReceiptCardTile(
            leading: 'Примечание',
            trailing: orderListModelItem.details,
          ),
          ReceiptCardTile(
            leading: 'Цена',
            trailing: "${orderListModelItem.price} сум",
          ),
          ReceiptCardTile(
            leading: 'Цена со скидкой',
            trailing: "${orderListModelItem.priceSale} сум",
          ),
          ReceiptCardTile(
            leading: 'Скидка',
            trailing:
                '${((double.parse(orderListModelItem.salePercent)) * 100).ceil() / 100} %',
          ),
          ReceiptCardTile(
            leading: 'Количество',
            trailing: "${orderListModelItem.count}",
          ),
          ReceiptCardTile(
            isLast: true,
            leading: 'Сумма',
            trailing:
                "${MaskFormat.formatter.format(double.parse(orderListModelItem.total))} сум",
          ),
        ],
      ),
    );
  }
}
