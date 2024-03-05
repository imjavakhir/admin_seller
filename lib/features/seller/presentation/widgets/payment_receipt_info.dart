import 'package:admin_seller/app_const/app_exports.dart';
class PaymentReceiptInfo extends StatelessWidget {
  final PaymentListModel paymentLisItem;
  final int index;
  const PaymentReceiptInfo({
    required this.index,
    super.key,
    required this.paymentLisItem,
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
            leading: 'Вид оплаты',
            trailing: paymentLisItem.paymentType,
          ),
          ReceiptCardTile(
            leading: 'Предоплата(Сум)',
            trailing: "${paymentLisItem.prepaymentSum} сум",
          ),
          ReceiptCardTile(
            leading: 'Предоплата(\$)',
            trailing: "${paymentLisItem.prepaymentDollar} \$",
          ),
          ReceiptCardTile(
            leading: 'Курс \$100',
            trailing: "${paymentLisItem.dollarExchange} сум",
          ),
          ReceiptCardTile(
            leading: 'Сумма по курсу',
            trailing:
                "${MaskFormat.formatter.format(double.parse(paymentLisItem.paymentDollarOnSum))} сум",
          ),
          ReceiptCardTile(
            leading: 'Здачи',
            trailing: "${paymentLisItem.refund} сум",
          ),
          ReceiptCardTile(
            isLast: true,
            leading: 'Итого(Сум)',
            trailing:
                "${MaskFormat.formatter.format(double.parse(paymentLisItem.totalSum))} сум",
          ),
        ],
      ),
    );
  }
}