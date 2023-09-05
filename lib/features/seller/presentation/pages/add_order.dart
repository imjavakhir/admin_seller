import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/presentation/widgets/add_order_field.dart';
import 'package:flutter/cupertino.dart';

List<OrderListModel> orderList = [];

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({
    super.key,
  });

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final TextEditingController _tissueTextEditingController =
      TextEditingController();
  final TextEditingController _priceTextEditingController =
      TextEditingController();
  final TextEditingController _priceWithSaleTextEditingController =
      TextEditingController();
  final TextEditingController _countTextEditingController =
      TextEditingController();
  final TextEditingController _reportDetailTextEdtingController =
      TextEditingController();

  final GlobalKey<FormState> tissueFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> priceFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> pricesaleFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> countFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> orderTypeFormKey = GlobalKey<FormState>();
  double salePercent = 0;
  double total = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SellingBloc, SellingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarWidget(
              title: 'Добавить заказ',
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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'ID',
                          style: Styles.headline4,
                        ),
                        const Spacer(),
                        Text(
                          state.idSelling,
                          style: Styles.headline4Reg,
                        )
                      ],
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'Категория',
                      style: Styles.headline4,
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Form(
                    key: orderTypeFormKey,
                    child: DropDownOrderWidget(
                      value: state.category,
                      valueChanged: (value) {
                        BlocProvider.of<SellingBloc>(context)
                            .add(CategorySelling(value));
                        if (value == 'Продажа со склада') {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.sellingWarehouse);
                        }
                      },
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'Вид мебеля и модель',
                      style: Styles.headline4,
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  AddOrderButtonWidget(
                    isSelected: state.furnitureTypeAndModel.isNotEmpty,
                    onPress: () {
                      showModalBottomSheet(
                        backgroundColor: AppColors.white,
                        useSafeArea: true,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        context: context,
                        builder: (context) {
                          return const ModelBottomSheetWidget();
                        },
                      );
                    },
                    hint: state.furnitureTypeAndModel.isNotEmpty
                        ? state.furnitureTypeAndModel
                        : 'Виберите вид мебеля и модель',
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Form(
                    key: tissueFormKey,
                    child: AddOrderFields(
                      title: 'Ткань',
                      hint: 'Ткань',
                      textEditingController: _tissueTextEditingController,
                    ),
                  ),
                  Form(
                    key: priceFormKey,
                    child: AddOrderFields(
                      valueChanged: (value) {
                        if (_countTextEditingController.text.isNotEmpty &&
                            _priceTextEditingController.text.isNotEmpty &&
                            _priceWithSaleTextEditingController
                                .text.isNotEmpty) {
                          salePercent = 100 -
                              ((double.parse(_priceWithSaleTextEditingController
                                          .text
                                          .replaceAll('.', '')) /
                                      double.parse(_priceTextEditingController
                                          .text
                                          .replaceAll('.', ''))) *
                                  100);
                          total = double.parse(
                                  _priceWithSaleTextEditingController.text
                                      .replaceAll('.', '')) *
                              double.parse(_countTextEditingController.text
                                  .replaceAll('.', ''));
                          setState(() {});
                        }
                      },
                      isSoldField: true,
                      listformatters: [ThousandsSeparatorInputFormatter()],
                      textInputType: TextInputType.number,
                      title: 'Цена',
                      hint: 'Цена',
                      textEditingController: _priceTextEditingController,
                    ),
                  ),
                  Form(
                    key: pricesaleFormKey,
                    child: AddOrderFields(
                      valueChanged: (value) {
                        if (_countTextEditingController.text.isNotEmpty &&
                            _priceTextEditingController.text.isNotEmpty &&
                            _priceWithSaleTextEditingController
                                .text.isNotEmpty) {
                          salePercent = 100 -
                              ((double.parse(_priceWithSaleTextEditingController
                                          .text
                                          .replaceAll('.', '')) /
                                      double.parse(_priceTextEditingController
                                          .text
                                          .replaceAll('.', ''))) *
                                  100);
                          total = double.parse(
                                  _priceWithSaleTextEditingController.text
                                      .replaceAll('.', '')) *
                              double.parse(_countTextEditingController.text
                                  .replaceAll('.', ''));
                          setState(() {});
                        }
                      },
                      isSoldField: true,
                      listformatters: [ThousandsSeparatorInputFormatter()],
                      textInputType: TextInputType.number,
                      title: 'Цена со скидкой',
                      hint: 'Цена со скидкой',
                      textEditingController:
                          _priceWithSaleTextEditingController,
                    ),
                  ),
                  Form(
                    key: countFormKey,
                    child: AddOrderFields(
                      textInputType: TextInputType.number,
                      title: 'Количество',
                      hint: 'Количество',
                      valueChanged: (value) {
                        if (_countTextEditingController.text.isNotEmpty &&
                            _priceTextEditingController.text.isNotEmpty &&
                            _priceWithSaleTextEditingController
                                .text.isNotEmpty) {
                          salePercent = 100 -
                              ((double.parse(_priceWithSaleTextEditingController
                                          .text
                                          .replaceAll('.', '')) /
                                      double.parse(_priceTextEditingController
                                          .text
                                          .replaceAll('.', ''))) *
                                  100);
                          total = double.parse(
                                  _priceWithSaleTextEditingController.text
                                      .replaceAll('.', '')) *
                              double.parse(_countTextEditingController.text
                                  .replaceAll('.', ''));
                          setState(() {});
                        }
                      },
                      textEditingController: _countTextEditingController,
                    ),
                  ),
                  AddOrderFields(
                    title: 'Примичение',
                    hint: 'Примичение',
                    textEditingController: _reportDetailTextEdtingController,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'Скидка',
                          style: Styles.headline4,
                        ),
                        const Spacer(),
                        Text(
                          "${((salePercent) * 100).ceil() / 100} %",
                          style: Styles.headline4,
                        )
                      ],
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'Сумма',
                          style: Styles.headline4,
                        ),
                        const Spacer(),
                        Text(
                          '${MaskFormat.formatter.format(total)} сум',
                          style: Styles.headline4,
                        ),
                      ],
                    ),
                  ),
                  ScreenUtil().setVerticalSpacing(120)
                ],
              ),
            ),
            bottomSheet: Container(
              alignment: Alignment.center,
              height: 96.h,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  border:
                      Border(top: BorderSide(width: 0, color: AppColors.grey))),
              child: LongButton(
                buttonName: 'Добавить',
                onTap: () {
                  final tissueValidate = tissueFormKey.currentState!.validate();
                  final orderTypeValidate =
                      orderTypeFormKey.currentState!.validate();

                  final priceValidate = priceFormKey.currentState!.validate();
                  final priceSaleValidate =
                      pricesaleFormKey.currentState!.validate();
                  final countValidate = countFormKey.currentState!.validate();

                  if (tissueValidate &&
                      orderTypeValidate &&
                      priceSaleValidate &&
                      priceValidate &&
                      countValidate) {
                    final order = OrderListModel(
                        idOrder: '',
                        id: state.idSelling,
                        salePercent: salePercent.toString(),
                        total: total.toString(),
                        category: state.category!,
                        idModel: state.idModel!,
                        furnitureType:
                            state.furnitureTypeAndModel.split('--').first,
                        furnitureModel:
                            state.furnitureTypeAndModel.split('--').last,
                        tissue: _tissueTextEditingController.text,
                        price: _priceTextEditingController.text,
                        priceSale: _priceWithSaleTextEditingController.text,
                        count: int.parse(_countTextEditingController.text),
                        details: _reportDetailTextEdtingController.text);
                    debugPrint(order.id);
                    debugPrint(order.category);
                    debugPrint(order.furnitureType);
                    debugPrint(order.furnitureModel);
                    debugPrint(order.tissue);
                    debugPrint(order.price.toString());
                    debugPrint(order.priceSale.toString());
                    debugPrint(order.details);
                    debugPrint(order.salePercent.toString());
                    debugPrint(order.total.toString());

                    orderList.add(order);
                    BlocProvider.of<SellingBloc>(context)
                        .add(SelectFurnitureTypeAndModel('', ''));
                    Navigator.of(context).pushNamed(AppRoutes.acceptOrder);
                  }

                  // BlocProvider.of<SellingBloc>(context)
                  //     .add(CategorySelling(null));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
