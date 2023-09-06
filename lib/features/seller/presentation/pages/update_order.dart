import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/presentation/widgets/add_order_field.dart';
import 'package:flutter/cupertino.dart';

class UpdateOrderPage extends StatefulWidget {
  final OrderListModel? order;
  final int? index;

  const UpdateOrderPage({
    super.key,
    this.order,
    this.index,
  });

  @override
  State<UpdateOrderPage> createState() => _UpdateOrderPageState();
}

class _UpdateOrderPageState extends State<UpdateOrderPage> {
  late TextEditingController _tissueTextEditingController;

  late TextEditingController _priceTextEditingController;

  late TextEditingController _priceWithSaleTextEditingController;

  late TextEditingController _countTextEditingController;

  late TextEditingController _reportDetailTextEdtingController;

  double salePercent = 0;
  double total = 0;
  @override
  void initState() {
    BlocProvider.of<SellingBloc>(context).add(SelectFurnitureTypeAndModel(
        '${widget.order!.furnitureType}--${widget.order!.furnitureModel}',
        widget.order!.idModel));
    _tissueTextEditingController = TextEditingController.fromValue(
        TextEditingValue(text: widget.order!.tissue));
    _countTextEditingController = TextEditingController.fromValue(
        TextEditingValue(text: widget.order!.count.toString()));
    _priceTextEditingController = TextEditingController.fromValue(
        TextEditingValue(text: widget.order!.price.toString()));
    _priceWithSaleTextEditingController = TextEditingController.fromValue(
        TextEditingValue(text: widget.order!.priceSale.toString()));
    _reportDetailTextEdtingController = TextEditingController.fromValue(
        TextEditingValue(text: widget.order!.details));
    BlocProvider.of<SellingBloc>(context).add(SelectFurnitureTypeAndModel(
        '${widget.order!.furnitureType}--${widget.order!.furnitureModel}',
        widget.order!.idModel));
    total = double.parse(widget.order!.total);
    salePercent = double.parse(widget.order!.salePercent);
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SellingBloc, SellingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarWidget(
              title: 'Изменить заказ',
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
                          widget.order!.id,
                          style: Styles.headline4Reg,
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
                          'Категория',
                          style: Styles.headline4,
                        ),
                        const Spacer(),
                        Text(
                          widget.order!.category,
                          style: Styles.headline4Reg,
                        )
                      ],
                    ),
                  ),

                  // DropDownOrderWidget(

                  //   value: state.category,
                  //   valueChanged: (value) {
                  //     BlocProvider.of<SellingBloc>(context)
                  //         .add(CategorySelling(value));
                  //     if (value == 'Продажа со склада') {
                  //       Navigator.of(context)
                  //           .pushNamed(AppRoutes.sellingWarehouse);
                  //     }
                  //   },
                  // ),
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
                    onPress: (widget.order!.category == 'Заказ')
                        ? () {
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
                          }
                        : null,
                    hint: state.furnitureTypeAndModel.isNotEmpty
                        ? state.furnitureTypeAndModel
                        : 'Виберите вид мебеля и модель',
                  ),
                  ScreenUtil().setVerticalSpacing(10),
                  AddOrderFields(
                    title: 'Ткань',
                    hint: 'Ткань',
                    textEditingController: _tissueTextEditingController,
                  ),
                  AddOrderFields(
                    isSoldField: true,
                    valueChanged: (value) {
                      if (_countTextEditingController.text.isNotEmpty &&
                          _priceTextEditingController.text.isNotEmpty &&
                          _priceWithSaleTextEditingController.text.isNotEmpty) {
                        salePercent = 100 -
                            ((double.parse(_priceWithSaleTextEditingController
                                        .text
                                        .replaceAll('.', '')) /
                                    double.parse(_priceTextEditingController
                                        .text
                                        .replaceAll('.', ''))) *
                                100);
                        total = double.parse(_priceWithSaleTextEditingController
                                .text
                                .replaceAll('.', '')) *
                            double.parse(_countTextEditingController.text
                                .replaceAll('.', ''));
                        setState(() {});
                      }
                    },
                    listformatters: [ThousandsSeparatorInputFormatter()],
                    textInputType: TextInputType.number,
                    title: 'Цена',
                    hint: 'Цена',
                    textEditingController: _priceTextEditingController,
                  ),
                  AddOrderFields(
                    isSoldField: true,
                    valueChanged: (value) {
                      if (_countTextEditingController.text.isNotEmpty &&
                          _priceTextEditingController.text.isNotEmpty &&
                          _priceWithSaleTextEditingController.text.isNotEmpty) {
                        salePercent = 100 -
                            ((double.parse(_priceWithSaleTextEditingController
                                        .text
                                        .replaceAll('.', '')) /
                                    double.parse(_priceTextEditingController
                                        .text
                                        .replaceAll('.', ''))) *
                                100);
                        total = double.parse(_priceWithSaleTextEditingController
                                .text
                                .replaceAll('.', '')) *
                            double.parse(_countTextEditingController.text
                                .replaceAll('.', ''));
                        setState(() {});
                      }
                    },
                    listformatters: [ThousandsSeparatorInputFormatter()],
                    textInputType: TextInputType.number,
                    title: 'Цена со скидкой',
                    hint: 'Цена со скидкой',
                    textEditingController: _priceWithSaleTextEditingController,
                  ),
                  AddOrderFields(
                    isDisabled: widget.order!.category != 'Заказ',
                    textInputType: TextInputType.number,
                    title: 'Количество',
                    hint: 'Количество',
                    valueChanged: (value) {
                      if (_countTextEditingController.text.isNotEmpty &&
                          _priceTextEditingController.text.isNotEmpty &&
                          _priceWithSaleTextEditingController.text.isNotEmpty) {
                        salePercent = 100 -
                            ((double.parse(_priceWithSaleTextEditingController
                                        .text
                                        .replaceAll('.', '')) /
                                    double.parse(_priceTextEditingController
                                        .text
                                        .replaceAll('.', ''))) *
                                100);
                        total = double.parse(_priceWithSaleTextEditingController
                                .text
                                .replaceAll('.', '')) *
                            double.parse(_countTextEditingController.text
                                .replaceAll('.', ''));
                        setState(() {});
                      }
                    },
                    textEditingController: _countTextEditingController,
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
                buttonName: 'Сохранить',
                onTap: () {
                  final order = OrderListModel(
                      idOrder: widget.order!.id,
                      id: widget.order!.id,
                      salePercent: salePercent.toString(),
                      total: total.toString(),
                      category: widget.order!.category,
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
                  orderList[widget.index!] = order;
                  setState(() {});
                  // BlocProvider.of<SellingBloc>(context)
                  //     .add(CategorySelling(null));
                  // BlocProvider.of<SellingBloc>(context)
                  //     .add(SelectFurnitureTypeAndModel('', ''));
                Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.acceptOrder,
                          ModalRoute.withName(AppRoutes.addClient));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
