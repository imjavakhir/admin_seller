import 'package:admin_seller/app_const/app_exports.dart';
import 'package:intl/intl.dart';

class ClientReceiptInfo extends StatelessWidget {
  final DateTime dateTime;
  final String fullName;
  final String phoneNumber;
  final String whereFrom;

  const ClientReceiptInfo({
    super.key,
    required this.dateTime,
    required this.fullName,
    required this.phoneNumber,
    required this.whereFrom,
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
          ReceiptCardTile(leading: 'Имя клиента', trailing: fullName),
          ReceiptCardTile(
            leading: 'Номер телефона',
            trailing: "+998$phoneNumber",
          ),
          ReceiptCardTile(
            leading: 'Откуда пришёл',
            trailing: whereFrom,
          ),
          ReceiptCardTile(
            isLast: true,
            leading: 'Дата доставки',
            trailing: DateFormat('dd.MM.yyyy').format(dateTime),
          ),
        ],
      ),
    );
  }
}
