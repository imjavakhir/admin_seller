part of 'selling_bloc.dart';

class SellingState {
  final String furnitureTypeAndModel;
  final String searchText;
  final String? category;
  final String? idModel;
  final String idSelling;
  final List<Product?> sellingWarehouseModel;
  final bool showLoadingWarehouseProducts;
  final List<SellingMyOrders?>? sellingMyOrders;
  final bool showLoadingSellingMyOrders;
  final bool showSearchLoading;
  final List<FurnitureModelTypeModel?>? furnitureModelTypeModelList;
  final bool isHasSearch;

  final List<WalletModel?> walletList;
  final String? paymentValue;

  SellingState(
      {required this.sellingWarehouseModel,
      required this.walletList,
      this.paymentValue,
      this.idModel,
      this.searchText = '',
      this.category,
      this.isHasSearch = false,
      this.idSelling = '',
      this.furnitureTypeAndModel = '',
      this.showSearchLoading = false,
      required this.furnitureModelTypeModelList,
      this.showLoadingWarehouseProducts = false,
      this.showLoadingSellingMyOrders = false,
      this.sellingMyOrders});

  SellingState copyWith(
      {final List<Product?>? sellingWarehouseModel,
      final String? searchText,
      final List<PaymentListModel?>? paymentList,
      final String? paymentValue,
      final List<WalletModel?>? walletList,
      final List<OrderListModel?>? orderList,
      final List<FurnitureModelTypeModel?>? furnitureModelTypeModelList,
      final bool? showLoadingSellingMyOrders,
      final String? idSelling,
      final String? category,
      final bool? isHasSearch,
      final String? idModel,
      final String? furnitureTypeAndModel,
      final List<SellingMyOrders?>? sellingMyOrders,
      final bool? showSearchLoading,
      final bool? showLoadingWarehouseProducts}) {
    return SellingState(
        paymentValue: paymentValue ?? this.paymentValue,
        walletList: walletList ?? this.walletList,
        searchText: searchText ?? this.searchText,
        isHasSearch: isHasSearch ?? this.isHasSearch,
        idModel: idModel ?? this.idModel,
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
