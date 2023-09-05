part of 'selling_bloc.dart';

class SellingEvent {}

class GetWarehouseProducts extends SellingEvent {}

class BookWarehouseProduct extends SellingEvent {
  final String id;
  final DateTime dateTime;
  final int indexItem;

  BookWarehouseProduct(this.id, this.dateTime, this.indexItem);
}

class UnbookWarehouseProduct extends SellingEvent {
  final String id;
  final int indexItem;

  UnbookWarehouseProduct(this.id,this.indexItem);
}

class GetSellingMyOrders extends SellingEvent {}

class SearchFurnitureTypeModel extends SellingEvent {
  final String searchText;

  SearchFurnitureTypeModel(this.searchText);
}

class SearchWarehouseProduct extends SellingEvent {
  final String searchText;

  SearchWarehouseProduct(this.searchText);
}

class GetIdSelling extends SellingEvent {}

class CategorySelling extends SellingEvent {
  final String? category;

  CategorySelling(this.category);
}

class SelectFurnitureTypeAndModel extends SellingEvent {
  final String furnitureTypeAndModel;
  final String idModel;

  SelectFurnitureTypeAndModel(this.furnitureTypeAndModel, this.idModel);
}

class SearchHasEvent extends SellingEvent {}

class GetWalletList extends SellingEvent {}

class SelectTypePayment extends SellingEvent {
  final String? value;

  SelectTypePayment({required this.value});
}

class ClientStatusChange extends SellingEvent {
  final String? clientStatus;

  ClientStatusChange({required this.clientStatus});
}

class CheckOrderDatePick extends SellingEvent {
  final DateTime? dateTimeDeliver;

  CheckOrderDatePick({required this.dateTimeDeliver});
}

class LoadMoreWarehouseProducts extends SellingEvent {}
