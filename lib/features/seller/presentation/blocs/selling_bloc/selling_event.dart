part of 'selling_bloc.dart';

class SellingEvent {}

class GetWarehouseProducts extends SellingEvent {}

class BookWarehouseProduct extends SellingEvent {
  final String id;
  final DateTime dateTime;

  BookWarehouseProduct(this.id, this.dateTime);
}

class UnbookWarehouseProduct extends SellingEvent {
  final String id;

  UnbookWarehouseProduct(this.id);
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

  SelectFurnitureTypeAndModel(this.furnitureTypeAndModel,this.idModel);
}
class SearchHasEvent extends SellingEvent{
  
}
