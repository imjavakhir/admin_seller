import 'package:admin_seller/app_const/app_exports.dart';

class AddOrderFields extends StatelessWidget {
  final List<TextInputFormatter>? listformatters;
  final String title;
  final String hint;
  final bool isSoldField;
  final bool isDisabled;
  final TextEditingController textEditingController;
  final ValueChanged? valueChanged;
  final TextInputType textInputType;
  const AddOrderFields(
      {super.key,
      this.isDisabled = false,
      required this.title,
      this.isSoldField = false,
      required this.hint,
      required this.textEditingController,
      this.valueChanged,
      this.textInputType = TextInputType.text,
      this.listformatters});

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
            isDisabled: isDisabled,
            isSoldField: isSoldField,
            listFormater: listformatters,
            textInputType: textInputType,
            valueChanged: valueChanged,
            hintext: hint,
            textEditingController: textEditingController),
        ScreenUtil().setVerticalSpacing(10),
      ],
    );
  }
}

class OrderListModel {
  final String id;
  final String idOrder;
  final String category;
  final String idModel;
  final String furnitureType;
  final String furnitureModel;
  final String tissue;
  final String price;
  final String priceSale;
  final int count;
  final String details;
  final String salePercent;
  final String total;

  OrderListModel(
      {required this.id,
     required this.idOrder, 
      required this.salePercent,
      required this.total,
      required this.category,
      required this.idModel,
      required this.furnitureType,
      required this.furnitureModel,
      required this.tissue,
      required this.price,
      required this.priceSale,
      required this.count,
      required this.details});
}
