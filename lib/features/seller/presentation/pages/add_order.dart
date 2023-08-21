import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/seller/presentation/blocs/selling_bloc/selling_bloc.dart';
import 'package:admin_seller/features/seller/presentation/widgets/add_order_button.dart';
import 'package:admin_seller/features/seller/presentation/widgets/add_order_dropdown.dart';
import 'package:admin_seller/features/seller/presentation/widgets/furnituretype_model_bottom_sheet.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final _tissueTextEditingController = TextEditingController();
  final _priceTextEditingController = TextEditingController();
  final _priceWithSaleTextEditingController = TextEditingController();
  final _countTextEditingController = TextEditingController();
  final _reportDetailTextEdtingController = TextEditingController();

  double salePercent = 0;
  double total = 0;
  @override
  void initState() {
    BlocProvider.of<SellingBloc>(context).add(GetIdSelling());
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
                  DropDownOrderWidget(
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
                  AddOrderFields(
                    title: 'Ткань',
                    hint: 'Ткань',
                    textEditingController: _tissueTextEditingController,
                  ),
                  AddOrderFields(
                    textInputType: TextInputType.number,
                    title: 'Цена',
                    hint: 'Цена',
                    textEditingController: _priceTextEditingController,
                  ),
                  AddOrderFields(
                    textInputType: TextInputType.number,
                    title: 'Цена со скидкой',
                    hint: 'Цена со скидкой',
                    textEditingController: _priceWithSaleTextEditingController,
                  ),
                  AddOrderFields(
                    textInputType: TextInputType.number,
                    title: 'Количество',
                    hint: 'Количество',
                    valueChanged: (value) {
                      if (_countTextEditingController.text.isNotEmpty &&
                          _priceTextEditingController.text.isNotEmpty &&
                          _priceWithSaleTextEditingController.text.isNotEmpty) {
                        salePercent = 100 -
                            ((double.parse(_priceWithSaleTextEditingController
                                        .text) /
                                    double.parse(
                                        _priceTextEditingController.text)) *
                                100);
                        total = double.parse(
                                _priceWithSaleTextEditingController.text) *
                            double.parse(_countTextEditingController.text);
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
                          '$total сум',
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
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddOrderFields extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController textEditingController;
  final ValueChanged? valueChanged;
  final TextInputType textInputType;
  const AddOrderFields(
      {super.key,
      required this.title,
      required this.hint,
      required this.textEditingController,
      this.valueChanged,
      this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            title,
            style: Styles.headline4,
          ),
        ),
        ScreenUtil().setVerticalSpacing(10),
        TextfieldWidget(
            textInputType: textInputType,
            valueChanged: valueChanged,
            hintext: hint,
            textEditingController: textEditingController),
        ScreenUtil().setVerticalSpacing(10),
      ],
    );
  }
}
