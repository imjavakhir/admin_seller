import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/presentation/widgets/add_order_field.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  double totalofOrdersSum = 0;
  double rest = 0;
  double totalPaymentSum = 0;

  @override
  void initState() {
    BlocProvider.of<SellingBloc>(context).add(GetIdSelling());
    for (var element in orderList) {
      totalofOrdersSum = totalofOrdersSum + double.parse(element.total);
    }
    for (var element in paymentList) {
      totalPaymentSum = totalPaymentSum + double.parse(element.totalSum);
    }

    rest = totalofOrdersSum - totalPaymentSum;
    debugPrint(totalofOrdersSum.toString());
    debugPrint(totalPaymentSum.toString());
    debugPrint(rest.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellingBloc, SellingState>(
      builder: (context, state) {
        return Scaffold(
            appBar: const AppBarWidget(
              title: 'Квитанции',
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Icon(
                      CupertinoIcons.exclamationmark_circle_fill,
                      color: AppColors.orange,
                      size: 40.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Center(
                      child: Text(
                        'Убедитесь, что вы заполнили правильно!',
                        style: Styles.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'Данные о клиенте',
                      style: Styles.headline4,
                    ),
                  ),
                  ClientReceiptInfo(
                    dateTime: state.dateTimeDeliver!,
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: DottedLine(
                      lineThickness: 1.0,
                      dashColor: AppColors.black,
                      dashRadius: 100.r,
                      dashGapLength: 4.w,
                      dashLength: 8.w,
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'Данные о заказов',
                      style: Styles.headline4,
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderReceiptInfo(
                        orderListModelItem: orderList[index],
                        index: index,
                      );
                    },
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: DottedLine(
                      lineThickness: 1.0,
                      dashColor: AppColors.black,
                      dashRadius: 100.r,
                      dashGapLength: 4.w,
                      dashLength: 8.w,
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'Данные об облате',
                      style: Styles.headline4,
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: paymentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PaymentReceiptInfo(
                        paymentLisItem: paymentList[index],
                        index: index,
                      );
                    },
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: DottedLine(
                      lineThickness: 1.0,
                      dashColor: AppColors.black,
                      dashRadius: 100.r,
                      dashGapLength: 4.w,
                      dashLength: 8.w,
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Остаток',
                          style: Styles.headline2,
                        ),
                        const Spacer(),
                        Text(
                          "${MaskFormat.formatter.format(rest)} сум",
                          style: Styles.headline2,
                        ),
                      ],
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(120.h)
                ],
              ),
            ),
            bottomSheet: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              alignment: Alignment.center,
              height: 96.h,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  border:
                      Border(top: BorderSide(width: 0, color: AppColors.grey))),
              child: Row(
                children: [
                  Expanded(
                    child: LongButton(
                      paddingW: 0,
                      buttonName: 'Правильно',
                      onTap: () {
                        debugPrint(state.dateTimeDeliver.toString());
                        for (var element in orderList) {
                          debugPrint("${element.idModel}   model");
                          debugPrint("${element.id}   id");
                          debugPrint("${element.idOrder}   orderid");
                        }
                        for (var element in paymentList) {
                          debugPrint("${element.paymentId} payment id");
                        }
                      },
                    ),
                  ),
                  ScreenUtil().setHorizontalSpacing(20.w),
                  Expanded(
                    child: TransparentLongButton(
                      paddingW: 0,
                      buttonName: 'Неправильно',
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

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

class ClientReceiptInfo extends StatelessWidget {
  final DateTime dateTime;

  const ClientReceiptInfo({
    super.key,
    required this.dateTime,
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
          const ReceiptCardTile(leading: 'Имя клиента', trailing: ''),
          const ReceiptCardTile(
            leading: 'Номер телефона',
            trailing: "",
          ),
          const ReceiptCardTile(
            leading: 'Откуда пришёл',
            trailing: "",
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

  // Material(
  //                   color: AppColors.white,
  //                   child: ListTile(
  //                     trailing: Icon(
  //                       CupertinoIcons.chevron_right,
  //                       color: AppColors.black,
  //                       size: 20.h,
  //                     ),
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10.r)),
  //                     onTap: () {},
  //                     contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
  //                     dense: true,
  //                     visualDensity: const VisualDensity(vertical: -4),
  //                     title: Text(
  //                       'Salom',
  //                       style: Styles.headline6
  //                           .copyWith(color: AppColors.textfieldText),
  //                     ),
  //                     subtitle: Text(
  //                       'Salom',
  //                       style: Styles.headline6,
  //                     ),
  //                   ),
  //                 ),

  