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
