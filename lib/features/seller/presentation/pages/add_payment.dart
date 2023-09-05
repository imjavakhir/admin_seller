import 'package:admin_seller/app_const/app_exports.dart';
import 'package:flutter/cupertino.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({
    super.key,
  });

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  @override
  void initState() {
    BlocProvider.of<SellingBloc>(context).add(GetWalletList());
    super.initState();
  }

  final _prepaymentSumContoller = TextEditingController();
  final _prepaymentDollarController =
      TextEditingController.fromValue(const TextEditingValue(text: '0'));
  final _refundController =
      TextEditingController.fromValue(const TextEditingValue(text: '0'));
  final _dollarExchangeContoller =
      TextEditingController.fromValue(const TextEditingValue(text: '0'));

  final GlobalKey<FormState> presumFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> preDollarFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> refundFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dollarexchangeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> typePayment = GlobalKey<FormState>();
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
                    Form(
                        key: typePayment,
                        child: const AddPaymentDropDownWidget()),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Предоплата(Сум)',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Form(
                      key: presumFormKey,
                      child: TextfieldWidget(
                          validator: Validators.empty,
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
                                  double.parse(_refundController.text
                                      .replaceAll('.', ''));

                              setState(() {});
                            }
                          },
                          listFormater: [ThousandsSeparatorInputFormatter()],
                          isSoldField: true,
                          hintext: 'Предоплата(Сум)',
                          textEditingController: _prepaymentSumContoller),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Предоплата(\$)',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Form(
                      key: preDollarFormKey,
                      child: TextfieldWidget(
                          validator: Validators.empty,
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
                                  double.parse(_refundController.text
                                      .replaceAll('.', ''));

                              setState(() {});
                            }
                          },
                          listFormater: [ThousandsSeparatorInputFormatter()],
                          isSum: false,
                          isSoldField: true,
                          hintext: 'Предоплата(\$)',
                          textEditingController: _prepaymentDollarController),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Курс \$100',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Form(
                      key: dollarexchangeFormKey,
                      child: TextfieldWidget(
                          validator: Validators.empty,
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
                                  double.parse(_refundController.text
                                      .replaceAll('.', ''));

                              setState(() {});
                            }
                          },
                          listFormater: [ThousandsSeparatorInputFormatter()],
                          isSoldField: true,
                          hintext: 'Курс \$100',
                          textEditingController: _dollarExchangeContoller),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Здачи',
                        style: Styles.headline4,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(10),
                    Form(
                      key: refundFormKey,
                      child: TextfieldWidget(
                          validator: Validators.empty,
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
                                  double.parse(_refundController.text
                                      .replaceAll('.', ''));

                              setState(() {});
                            }
                          },
                          listFormater: [ThousandsSeparatorInputFormatter()],
                          isSoldField: true,
                          hintext: 'Здачи',
                          textEditingController: _refundController),
                    ),
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
                    ScreenUtil().setVerticalSpacing(150.h),
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
                      final typePaymentValidate =
                          typePayment.currentState!.validate();
                      final presumValidate =
                          presumFormKey.currentState!.validate();
                      final predollarValidate =
                          preDollarFormKey.currentState!.validate();
                      final dollarExchangeValidate =
                          dollarexchangeFormKey.currentState!.validate();
                      final refundValidate =
                          refundFormKey.currentState!.validate();

                      if (typePaymentValidate &&
                          predollarValidate &&
                          dollarExchangeValidate &&
                          predollarValidate &&
                          presumValidate &&
                          refundValidate) {
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
                            paymentDollarOnSum: dollarExchangeSum.toString(),
                            refund: _refundController.text,
                            totalSum: totalSum.toString());
                        BlocProvider.of<SellingBloc>(context)
                            .add(SelectTypePayment(value: null));
                        paymentList.add(payment);
                        Navigator.of(context).pushNamed(AppRoutes.acceptOrder);
                      }
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
          return DropdownButtonFormField2(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              menuItemStyleData: MenuItemStyleData(
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w)),
              hint: Text(
                'Выберите категорию',
                style:
                    Styles.headline4.copyWith(color: AppColors.textfieldText),
              ),
              enableFeedback: false,
              decoration: InputDecoration(
                errorStyle: Styles.headline6.copyWith(color: AppColors.red),
                isCollapsed: true,
                filled: true,
                fillColor: AppColors.textfieldBackground,
                errorBorder: Decorations.errorBorder,
                focusedBorder: Decorations.focusedBorder,
                enabledBorder: Decorations.enabledBorder,
                focusedErrorBorder: Decorations.errorBorder,
              ),
              validator: (value) {
                return Validators.empty(value);
              },
              iconStyleData: IconStyleData(
                  iconEnabledColor: AppColors.borderColor,
                  iconSize: 24.h,
                  icon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const Icon(
                      CupertinoIcons.chevron_down,
                    ),
                  )),
              buttonStyleData: ButtonStyleData(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                height: 56.h,
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                padding: EdgeInsets.zero,
                maxHeight: 280.h,
                offset: const Offset(0, -4),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.white),
              ),
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
