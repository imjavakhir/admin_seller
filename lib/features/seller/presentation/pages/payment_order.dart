import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/presentation/pages/update_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

List<PaymentListModel> paymentList = [];

class PaymentsTabView extends StatefulWidget {
  const PaymentsTabView({super.key});

  @override
  State<PaymentsTabView> createState() => _PaymentsTabViewState();
}

class _PaymentsTabViewState extends State<PaymentsTabView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellingBloc, SellingState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.only(top: 10.h, bottom: 90.h),
          itemCount: paymentList.length,
          itemBuilder: (BuildContext context, int index) {
            return PaymentCard(
              onEditTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UpdatePaymentPage(
                      index: index,
                      payment: paymentList[index],
                    ),
                  ),
                );
              },
              onDeleteTap: () {
                paymentList.removeAt(index);
                setState(() {});
              },
              paymentListItem: paymentList[index],
            );
          },
        );
      },
    );
  }
}

class PaymentCard extends StatelessWidget {
  final VoidCallback onDeleteTap;
  final PaymentListModel paymentListItem;
  final VoidCallback onEditTap;

  const PaymentCard(
      {super.key,
      required this.paymentListItem,
      required this.onDeleteTap,
      required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: Key(paymentListItem.paymentId),
        startActionPane: ActionPane(
            extentRatio: 1 / 2,
            motion: const ScrollMotion(),
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 24.w, top: 5.h, bottom: 5.h),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          foregroundColor: Colors.grey),
                      onPressed: onEditTap,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.pencil_ellipsis_rectangle,
                            color: AppColors.grey,
                          ),
                          Text(
                            'Изменить',
                            style: Styles.headline4
                                .copyWith(color: AppColors.grey),
                          )
                        ],
                      )),
                ),
              )
            ]),
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
                      onPressed: onDeleteTap,
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
          height: 180.h,
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderCardTile(
                leading: 'Вид оплаты',
                trailing: paymentListItem.paymentType,
              ),
              OrderCardTile(
                leading: 'Предоплата(Сум)',
                trailing: "${paymentListItem.prepaymentSum} сум",
              ),
              OrderCardTile(
                leading: 'Предоплата(\$)',
                trailing: "${paymentListItem.prepaymentDollar} \$",
              ),
              OrderCardTile(
                leading: 'Курс \$100',
                trailing: "${paymentListItem.dollarExchange} сум",
              ),
              OrderCardTile(
                leading: 'Сумма по курсу',
                trailing:
                    "${MaskFormat.formatter.format(double.parse(paymentListItem.paymentDollarOnSum))} сум",
              ),
              OrderCardTile(
                leading: 'Здачи',
                trailing: "${paymentListItem.refund} сум",
              ),
              OrderCardTile(
                leading: 'Итого(Сум)',
                trailing:
                    "${MaskFormat.formatter.format(double.parse(paymentListItem.totalSum))} сум",
              ),
            ],
          ),
        ));
  }
}

class PaymentListModel {
  final String paymentId;
  final String paymentType;
  final String prepaymentDollar;
  final String prepaymentSum;
  final String dollarExchange;
  final String paymentDollarOnSum;
  final String refund;
  final String totalSum;

  PaymentListModel(
      {required this.paymentType,
      required this.paymentId,
      required this.prepaymentDollar,
      required this.prepaymentSum,
      required this.dollarExchange,
      required this.paymentDollarOnSum,
      required this.refund,
      required this.totalSum});
}
