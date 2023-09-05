import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';

class UpdatePaymentPage extends StatefulWidget {
  final int? index;
  final PaymentListModel? payment;
  const UpdatePaymentPage({
    super.key,
    this.index,
    this.payment,
  });

  @override
  State<UpdatePaymentPage> createState() => _UpdatePaymentPageState();
}

class _UpdatePaymentPageState extends State<UpdatePaymentPage> {
  late TextEditingController _prepaymentSumContoller;
  late TextEditingController _prepaymentDollarController;
  late TextEditingController _refundController;
  late TextEditingController _dollarExchangeContoller;
  @override
  void initState() {
      BlocProvider.of<SellingBloc>(context).add(GetWalletList());
    _prepaymentDollarController = TextEditingController.fromValue(
        TextEditingValue(text: widget.payment!.prepaymentDollar));
    _prepaymentSumContoller = TextEditingController.fromValue(
        TextEditingValue(text: widget.payment!.prepaymentSum));
    _refundController = TextEditingController.fromValue(
        TextEditingValue(text: widget.payment!.refund));
    _dollarExchangeContoller = TextEditingController.fromValue(
        TextEditingValue(text: widget.payment!.dollarExchange));
    totalSum = double.parse(widget.payment!.totalSum);
    dollarExchangeSum = double.parse(widget.payment!.paymentDollarOnSum);
    setState(() {});
    super.initState();
  }

  double totalSum = 0;
  double dollarExchangeSum = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocBuilder<SellingBloc, SellingState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBarWidget(
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
                title: 'Выберите продавца',
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Вид оплаты',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    const AddPaymentDropDownWidget(),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Предоплата(Сум)',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    TextfieldWidget(
                        textInputType: TextInputType.number,
                        valueChanged: (value) {
                          if (_prepaymentSumContoller.text.isNotEmpty &&
                              _prepaymentDollarController.text.isNotEmpty &&
                              _dollarExchangeContoller.text.isNotEmpty &&
                              _refundController.text.isNotEmpty) {
                            dollarExchangeSum = double.parse(
                                    _prepaymentDollarController.text
                                        .replaceAll('.', '')) *
                                (double.parse(_dollarExchangeContoller.text
                                        .replaceAll('.', '')) /
                                    100);

                            totalSum = (dollarExchangeSum +
                                    double.parse(_prepaymentSumContoller.text
                                        .replaceAll('.', ''))) -
                                double.parse(
                                    _refundController.text.replaceAll('.', ''));

                            setState(() {});
                          }
                        },
                        listFormater: [ThousandsSeparatorInputFormatter()],
                        isSoldField: true,
                        hintext: 'Предоплата(Сум)',
                        textEditingController: _prepaymentSumContoller),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Предоплата(\$)',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    TextfieldWidget(
                        textInputType: TextInputType.number,
                        valueChanged: (value) {
                          if (_prepaymentSumContoller.text.isNotEmpty &&
                              _prepaymentDollarController.text.isNotEmpty &&
                              _dollarExchangeContoller.text.isNotEmpty &&
                              _refundController.text.isNotEmpty) {
                            dollarExchangeSum = double.parse(
                                    _prepaymentDollarController.text
                                        .replaceAll('.', '')) *
                                (double.parse(_dollarExchangeContoller.text
                                        .replaceAll('.', '')) /
                                    100);

                            totalSum = (dollarExchangeSum +
                                    double.parse(_prepaymentSumContoller.text
                                        .replaceAll('.', ''))) -
                                double.parse(
                                    _refundController.text.replaceAll('.', ''));

                            setState(() {});
                          }
                        },
                        listFormater: [ThousandsSeparatorInputFormatter()],
                        isSum: false,
                        isSoldField: true,
                        hintext: 'Предоплата(\$)',
                        textEditingController: _prepaymentDollarController),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Здачи',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    TextfieldWidget(
                        textInputType: TextInputType.number,
                        valueChanged: (value) {
                          if (_prepaymentSumContoller.text.isNotEmpty &&
                              _prepaymentDollarController.text.isNotEmpty &&
                              _dollarExchangeContoller.text.isNotEmpty &&
                              _refundController.text.isNotEmpty) {
                            dollarExchangeSum = double.parse(
                                    _prepaymentDollarController.text
                                        .replaceAll('.', '')) *
                                (double.parse(_dollarExchangeContoller.text
                                        .replaceAll('.', '')) /
                                    100);

                            totalSum = (dollarExchangeSum +
                                    double.parse(_prepaymentSumContoller.text
                                        .replaceAll('.', ''))) -
                                double.parse(
                                    _refundController.text.replaceAll('.', ''));

                            setState(() {});
                          }
                        },
                        listFormater: [ThousandsSeparatorInputFormatter()],
                        isSoldField: true,
                        hintext: 'Здачи',
                        textEditingController: _refundController),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Курс \$100',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    TextfieldWidget(
                        textInputType: TextInputType.number,
                        valueChanged: (value) {
                          if (_prepaymentSumContoller.text.isNotEmpty &&
                              _prepaymentDollarController.text.isNotEmpty &&
                              _dollarExchangeContoller.text.isNotEmpty &&
                              _refundController.text.isNotEmpty) {
                            dollarExchangeSum = double.parse(
                                    _prepaymentDollarController.text
                                        .replaceAll('.', '')) *
                                (double.parse(_dollarExchangeContoller.text
                                        .replaceAll('.', '')) /
                                    100);

                            totalSum = (dollarExchangeSum +
                                    double.parse(_prepaymentSumContoller.text
                                        .replaceAll('.', ''))) -
                                double.parse(
                                    _refundController.text.replaceAll('.', ''));

                            setState(() {});
                          }
                        },
                        listFormater: [ThousandsSeparatorInputFormatter()],
                        isSoldField: true,
                        hintext: 'Курс \$100',
                        textEditingController: _dollarExchangeContoller),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Text(
                            'Сумма по курсу',
                            style: Styles.headline4,
                          ),
                          const Spacer(),
                          Text(
                            '${MaskFormat.formatter.format(dollarExchangeSum)} сум',
                            style: Styles.headline4Reg,
                          ),
                        ],
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Text(
                            'Итого(Сум)',
                            style: Styles.headline4,
                          ),
                          const Spacer(),
                          Text(
                            '${MaskFormat.formatter.format(totalSum)} сум',
                            style: Styles.headline4Reg,
                          ),
                        ],
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(96.h),
                  ],
                ),
              ),
              bottomSheet: Container(
                alignment: Alignment.center,
                height: 96.h,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    border: Border(
                        top: BorderSide(width: 0, color: AppColors.grey))),
                child: LongButton(
                    buttonName: 'Сохранить',
                    onTap: () {
                      final payment = PaymentListModel(
                          paymentType: state.walletList
                              .where((element) =>
                                  element!.id == state.paymentValue)
                              .first!
                              .name!,
                          paymentId: state.paymentValue!,
                          prepaymentDollar: _prepaymentDollarController.text,
                          prepaymentSum: _prepaymentSumContoller.text,
                          dollarExchange: _dollarExchangeContoller.text,
                          paymentDollarOnSum:
                              MaskFormat.formatter.format(dollarExchangeSum),
                          refund: _refundController.text,
                          totalSum: MaskFormat.formatter.format(totalSum));
                      BlocProvider.of<SellingBloc>(context)
                          .add(SelectTypePayment(value: null));
                      paymentList.add(payment);
                      Navigator.of(context).pushNamed(AppRoutes.paymentOrder);
                    }),
              ),
            );
          },
        ));
  }
}

class AddPaymentDropDownWidget extends StatelessWidget {
  const AddPaymentDropDownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: BlocBuilder<SellingBloc, SellingState>(
        builder: (context, state) {
          return DropdownButton2(
              menuItemStyleData: MenuItemStyleData(height: 56.h),
              hint: Text(
                'Выберите категорию',
                style:
                    Styles.headline4.copyWith(color: AppColors.textfieldText),
              ),
              enableFeedback: false,
              underline: const SizedBox(),
              iconStyleData: IconStyleData(
                  iconEnabledColor: AppColors.borderColor,
                  iconSize: 24.h,
                  icon: const Icon(
                    CupertinoIcons.chevron_down,
                  )),
              buttonStyleData: ButtonStyleData(
                  width: double.maxFinite,
                  height: 56.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                      color: AppColors.textfieldBackground,
                      borderRadius: BorderRadius.circular(10.r),
                      border:
                          Border.all(width: 1, color: AppColors.borderColor))),
              dropdownStyleData: DropdownStyleData(
                  maxHeight: 280.h,
                  offset: const Offset(0, -4),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.white,
                      border:
                          Border.all(width: 1, color: AppColors.borderColor))),
              isExpanded: true,
              value: state.paymentValue,
              onChanged: (value) {
                BlocProvider.of<SellingBloc>(context)
                    .add(SelectTypePayment(value: value));
                debugPrint(value);
              },
              items: List.generate(
                  state.walletList.length,
                  (index) => DropdownMenuItem(
                        value: state.walletList[index]!.id!,
                        child: Text(
                          state.walletList[index]!.name!,
                          style: Styles.headline4,
                        ),
                      )));
        },
      ),
    );
  }
}
