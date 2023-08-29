import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

List<PaymentListModel> paymentList = [];

class PaymentOrderPage extends StatefulWidget {
  const PaymentOrderPage({super.key});

  @override
  State<PaymentOrderPage> createState() => _PaymentOrderPageState();
}

class _PaymentOrderPageState extends State<PaymentOrderPage> {
  @override
  void initState() {
    BlocProvider.of<SellingBloc>(context).add(GetWalletList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellingBloc, SellingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
            title: 'Предоплаты',
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
            padding: EdgeInsets.only(top: 10.h, bottom: 90.h),
            itemCount: paymentList.length,
            itemBuilder: (BuildContext context, int index) {
              return PaymentCard(
                onDeleteTap: () {
                  paymentList.removeAt(index);
                  setState(() {});
                },
                paymentListItem: paymentList[index],
              );
            },
          ),
          bottomSheet: Container(
            height: 96.h,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: AppColors.white,
                border:
                    Border(top: BorderSide(width: 0, color: AppColors.grey))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: LongButton(buttonName: 'Подвердить', onTap: () {}),
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
                      Navigator.of(context).pushNamed(AppRoutes.addPayment);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    child: const Icon(
                      Icons.payments,
                    ),
                  ),
                ),
                ScreenUtil().setHorizontalSpacing(24),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PaymentCard extends StatelessWidget {
  final VoidCallback onDeleteTap;
  final PaymentListModel paymentListItem;

  const PaymentCard({
    super.key,
    required this.paymentListItem,
    required this.onDeleteTap,
  });

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
                      onPressed: () {},
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
                trailing: "${paymentListItem.paymentDollarOnSum} сум",
              ),
              OrderCardTile(
                leading: 'Здачи',
                trailing: "${paymentListItem.refund} сум",
              ),
              OrderCardTile(
                leading: 'Итого(Сум)',
                trailing: "${paymentListItem.totalSum} сум",
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
