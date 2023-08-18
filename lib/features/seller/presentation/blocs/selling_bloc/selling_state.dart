part of 'selling_bloc.dart';

class SellingState {
  final SellingWarehouseModel? sellingWarehouseModel;
  final bool showLoadingWarehouseProducts;
  final List<SellingMyOrders?>? sellingMyOrders;
  final bool showLoadingSellingMyOrders;

  SellingState(
      {this.sellingWarehouseModel,
      this.showLoadingWarehouseProducts = false,
      this.showLoadingSellingMyOrders = false,
      this.sellingMyOrders});

  SellingState copyWith(
      {final SellingWarehouseModel? sellingWarehouseModel,
      final bool? showLoadingSellingMyOrders,
      final List<SellingMyOrders?>? sellingMyOrders,
      final bool? showLoadingWarehouseProducts}) {
    return SellingState(
        showLoadingSellingMyOrders:
            showLoadingSellingMyOrders ?? this.showLoadingSellingMyOrders,
        sellingMyOrders: sellingMyOrders ?? this.sellingMyOrders,
        showLoadingWarehouseProducts:
            showLoadingWarehouseProducts ?? this.showLoadingWarehouseProducts,
        sellingWarehouseModel:
            sellingWarehouseModel ?? this.sellingWarehouseModel);
  }
}
