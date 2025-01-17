import 'package:admin_seller/app_const/app_exports.dart';

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

class ReceiptCardTile extends StatelessWidget {
  final String leading;
  final String trailing;
  final bool isLast;

  const ReceiptCardTile({
    super.key,
    required this.leading,
    this.isLast = false,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: !isLast
              ? const Border(
                  bottom: BorderSide(
                  width: 0,
                  color: AppColors.grey,
                ))
              : null),
      child: Row(
        children: [
          Text(
            leading,
            style: Styles.headline6.copyWith(color: AppColors.grey),
          ),
          const Spacer(),
          SizedBox(
            width: 180.w,
            child: Text(
              trailing,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: Styles.headline6.copyWith(color: AppColors.black),
            ),
          )
        ],
      ),
    );
  }
}
