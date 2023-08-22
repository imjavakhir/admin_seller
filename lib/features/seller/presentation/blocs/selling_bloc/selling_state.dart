part of 'selling_bloc.dart';

class SellingState {
  final String furnitureTypeAndModel;
  final String? category;
  final String? idModel;
  final String idSelling;
  final SellingWarehouseModel? sellingWarehouseModel;
  final bool showLoadingWarehouseProducts;
  final List<SellingMyOrders?>? sellingMyOrders;
  final bool showLoadingSellingMyOrders;
  final bool showSearchLoading;
  final List<FurnitureModelTypeModel?>? furnitureModelTypeModelList;

  SellingState(
      {this.sellingWarehouseModel,
      this.idModel,
      this.category,
      this.idSelling = '',
      this.furnitureTypeAndModel = '',
      this.showSearchLoading = false,
      required this.furnitureModelTypeModelList,
      this.showLoadingWarehouseProducts = false,
      this.showLoadingSellingMyOrders = false,
      this.sellingMyOrders});

  SellingState copyWith(
      {final SellingWarehouseModel? sellingWarehouseModel,
      final List<FurnitureModelTypeModel?>? furnitureModelTypeModelList,
      final bool? showLoadingSellingMyOrders,
      final String? idSelling,
      final String? category,
      final String? idModel,
      final String? furnitureTypeAndModel,
      final List<SellingMyOrders?>? sellingMyOrders,
      final bool? showSearchLoading,
      final bool? showLoadingWarehouseProducts}) {
    return SellingState(
      idModel: idModel??this.idModel,
        furnitureTypeAndModel:
            furnitureTypeAndModel ?? this.furnitureTypeAndModel,
        category: category ?? this.category,
        idSelling: idSelling ?? this.idSelling,
        showSearchLoading: showSearchLoading ?? this.showSearchLoading,
        furnitureModelTypeModelList:
            furnitureModelTypeModelList ?? this.furnitureModelTypeModelList,
        showLoadingSellingMyOrders:
            showLoadingSellingMyOrders ?? this.showLoadingSellingMyOrders,
        sellingMyOrders: sellingMyOrders ?? this.sellingMyOrders,
        showLoadingWarehouseProducts:
            showLoadingWarehouseProducts ?? this.showLoadingWarehouseProducts,
        sellingWarehouseModel:
            sellingWarehouseModel ?? this.sellingWarehouseModel);
  }
}
