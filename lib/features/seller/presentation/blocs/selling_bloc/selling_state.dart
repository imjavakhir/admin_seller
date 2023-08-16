part of 'selling_bloc.dart';

class SellingState {
  final SellingWarehouseModel? sellingWarehouseModel;
  final bool showLoadingWarehouseProducts;

  SellingState(
      {this.sellingWarehouseModel, this.showLoadingWarehouseProducts = false});

  SellingState copyWith({final SellingWarehouseModel? sellingWarehouseModel,  final bool? showLoadingWarehouseProducts}) {
    return SellingState(
      showLoadingWarehouseProducts: showLoadingWarehouseProducts??this.showLoadingWarehouseProducts,
        sellingWarehouseModel:
            sellingWarehouseModel ?? this.sellingWarehouseModel);
  }
}
