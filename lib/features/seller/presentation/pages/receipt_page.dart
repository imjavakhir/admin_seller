import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/data/hive_client_model.dart/hive_client_model.dart';
import 'package:admin_seller/features/seller/data/selling_orders_model.dart';
import 'package:admin_seller/features/seller/presentation/widgets/client_receipt_info.dart';
import 'package:admin_seller/features/seller/presentation/widgets/order_receipt_info.dart';
import 'package:admin_seller/features/seller/presentation/widgets/payment_receipt_info.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';

List<Map<String, dynamic>> sendPayment = [];
List<Map<String, dynamic>> sendOrder = [];

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  double totalofOrdersSum = 0;
  double rest = 0;
  double totalPaymentSum = 0;
  final _sellingRepository = SellingRepository();
  final _sellerRepository = SellerRepository();
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
    final hiveUserBox = Hive.box<HiveClientModel>('Client');
    final clientInfo = hiveUserBox.values.toList().cast<HiveClientModel>();
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
                    fullName: clientInfo.first.fullName,
                    phoneNumber: clientInfo.first.phoneNumber,
                    whereFrom: clientInfo.first.whereFrom,
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
                      onTap: () async {
                        final sendFormData = sellingFormDataToJson(
                            SellingFormData(
                                id: state.idSelling,
                                clientName: clientInfo.first.fullName,
                                phone: clientInfo.first.phoneNumber,
                                status: state.clientStatus,
                                deliveryDate: state.dateTimeDeliver,
                                whereFrom: clientInfo.first.whereFrom));
                        debugPrint(json.decode(sendFormData).toString());

                        for (var element in orderList) {
                          if (element.category != "заказ") {
                            debugPrint(element.idOrder);
                            debugPrint(element.id);
                            final newOrderDataWithId =
                                sellingOrdersWithIdToJson(SellingOrdersWithId(
                                    id: element.idOrder,
                                    orderId: element.id,
                                    model: element.idModel,
                                    qty: element.count,
                                    price: int.parse(
                                        element.price.replaceAll('.', '')),
                                    sale: double.parse(element.salePercent) != 0
                                        ? ((double.parse(element.salePercent)) *
                                                    100)
                                                .ceil() /
                                            100
                                        : double.parse(element.salePercent),
                                    sum: int.parse(
                                        element.total.replaceAll('.', '')),
                                    cathegory: element.category,
                                    tissue: element.tissue,
                                    title: element.details));
                            sendOrder.add(json.decode(newOrderDataWithId));
                            setState(() {});
                          } else {
                            final newOrderDataWithoutId =
                                sellingOrderWihoutIdToJson(SellingOrderWihoutId(
                                    model: element.idModel,
                                    qty: element.count,
                                    price: int.parse(
                                        element.price.replaceAll('.', '')),
                                    sale: ((double.parse(element.salePercent)) *
                                                100)
                                            .ceil() /
                                        100,
                                    sum: int.parse(
                                        element.total.replaceAll('.', '')),
                                    cathegory: element.category,
                                    tissue: element.tissue,
                                    title: element.details));
                            sendOrder.add(json.decode(newOrderDataWithoutId));
                            setState(() {});
                          }
                        }

                        for (var element in paymentList) {
                          debugPrint(element.totalSum
                              .replaceAll(RegExp(r'\.?0*$'), ''));
                          debugPrint(element.paymentDollarOnSum
                              .replaceAll(RegExp(r'\.?0*$'), ''));

                          final newPaymentData = sellingPaymentDataToJson(SellingPaymentData(
                              paymentType: element.paymentType,
                              totalSum: int.parse(element.totalSum
                                  .replaceAll(RegExp(r'\.?0*$'), '')),
                              change:
                                  int.parse(element.refund.replaceAll('.', '')),
                              id: 0,
                              walletId: element.paymentId,
                              kurs: int.parse(
                                  element.dollarExchange.replaceAll('.', '')),
                              amountByKurs: int.parse(element.paymentDollarOnSum
                                  .replaceAll(RegExp(r'\.?0*$'), '')),
                              payment: int.parse(
                                  element.prepaymentDollar.replaceAll('.', '')),
                              paymentSum: int.parse(
                                  element.prepaymentSum.replaceAll('.', ''))));

                          sendPayment.add(json.decode(newPaymentData));
                          setState(() {});
                        }
                        debugPrint(sendPayment.toString());
                        debugPrint(sendOrder.toString());

                        final Map<String, dynamic> apidata = {
                          'orders': sendOrder,
                          'formData': json.decode(sendFormData),
                          'payments': sendPayment
                        };

                        debugPrint(apidata.toString());
                        final createdSelling = await _sellingRepository
                            .sendSellingOrder(apiData: apidata);

                        final soldSelling =
                            await _sellerRepository.sendSoldSelling(
                                sharedid: /* reporShareId */ '',
                                report: false,
                                whereFrom: clientInfo.first.whereFrom,
                                id: clientInfo.first.id,
                                details: clientInfo.first.details,
                                fullName: clientInfo.first.fullName,
                                phoneNumber: clientInfo.first.phoneNumber
                                    .replaceAll('-', '')
                                    .replaceAll('(', '')
                                    .replaceAll(')', '')
                                    .replaceAll(' ', ''),
                                price: totalofOrdersSum);

                        debugPrint(soldSelling!.whereComeFrom!);

                        if (createdSelling == "Created successfully" &&
                            soldSelling.details != null) {
                          orderList.clear();
                          paymentList.clear();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.main, (route) => false);
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
                        final data = {"data": "salom"};
                        debugPrint(data.toString());
                        sendOrder.clear();
                        sendPayment.clear();
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     AppRoutes.acceptOrder,
                        //     ModalRoute.withName(AppRoutes.addClient));
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
