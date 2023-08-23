import 'package:admin_seller/features/seller/data/selling_data/furniture_model_type_model.dart';
import 'package:admin_seller/features/seller/data/selling_data/selling_my_orders_model.dart';
import 'package:admin_seller/features/seller/data/selling_data/selling_warehouse_model.dart';
import 'package:admin_seller/features/seller/repository/selling_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selling_event.dart';
part 'selling_state.dart';

class SellingBloc extends Bloc<SellingEvent, SellingState> {
  SellingBloc()
      : super(SellingState(
            furnitureModelTypeModelList: [], sellingWarehouseModel: [])) {
    on<GetWarehouseProducts>(_getWarehouseProducts);
    on<BookWarehouseProduct>(_bookWarehouseProduct);
    on<UnbookWarehouseProduct>(_unbookWarehouseProduct);
    on<GetSellingMyOrders>(_getSellingMyOrders);
    on<SearchFurnitureTypeModel>(_searchFurnitureModel);
    on<GetIdSelling>(_getIdSelling);
    on<CategorySelling>(_categorySelling);
    on<SelectFurnitureTypeAndModel>(_selectFurnitureTypeAndModel);
    on<SearchWarehouseProduct>(_searchWarehouseProduct);
    on<SearchHasEvent>(_searchHasEvent);
  }

  final SellingRepository _sellingRepository = SellingRepository();

  void _searchHasEvent(SearchHasEvent event, Emitter<SellingState> emit) {
    emit(state.copyWith(isHasSearch: !state.isHasSearch, searchText: ''));
  }

  void _selectFurnitureTypeAndModel(
      SelectFurnitureTypeAndModel event, Emitter<SellingState> emit) {
    emit(state.copyWith(
        furnitureTypeAndModel: event.furnitureTypeAndModel,
        idModel: event.idModel,
        furnitureModelTypeModelList: []));
  }

  void _categorySelling(CategorySelling event, Emitter<SellingState> emit) {
    emit(state.copyWith(category: event.category));
  }

  Future<void> _getIdSelling(
      GetIdSelling event, Emitter<SellingState> emit) async {
    final idSelling = await _sellingRepository.sellingGetId();
    emit(state.copyWith(idSelling: idSelling));
  }

  Future<void> _searchFurnitureModel(
      SearchFurnitureTypeModel event, Emitter<SellingState> emit) async {
    emit(state.copyWith(showSearchLoading: true));

    final searchModels =
        await _sellingRepository.searchFurnitureModel(event.searchText);
    debugPrint("${event.searchText}______");
    emit(state.copyWith(
        furnitureModelTypeModelList:
            event.searchText.isEmpty ? [] : searchModels,
        showSearchLoading: false));
  }

  Future<void> _getSellingMyOrders(
      GetSellingMyOrders event, Emitter<SellingState> emit) async {
    emit(state.copyWith(showLoadingSellingMyOrders: true));
    final sellingMyOrders = await _sellingRepository.getSellingMyOrders();

    emit(state.copyWith(
        sellingMyOrders: sellingMyOrders, showLoadingSellingMyOrders: false));
  }

  Future<void> _getWarehouseProducts(
      GetWarehouseProducts event, Emitter<SellingState> emit) async {
    emit(state.copyWith(showLoadingWarehouseProducts: true));

    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts('', '', '');

    emit(state.copyWith(
        sellingWarehouseModel: sellingWarehouseModel!.products!,
        showLoadingWarehouseProducts: false));
  }

  Future<void> _searchWarehouseProduct(
      SearchWarehouseProduct event, Emitter<SellingState> emit) async {
    emit(state.copyWith(showLoadingWarehouseProducts: true));
    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts('', '', event.searchText);

    emit(state.copyWith(
        searchText: event.searchText,
        sellingWarehouseModel:
            event.searchText.isEmpty ? [] : sellingWarehouseModel!.products,
        showLoadingWarehouseProducts: false));
  }

  Future<void> _bookWarehouseProduct(
      BookWarehouseProduct event, Emitter<SellingState> emit) async {
    await _sellingRepository.bookWareHouseProduct(event.dateTime, event.id);
    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts('', '', state.searchText);
    emit(state.copyWith(
        sellingWarehouseModel: sellingWarehouseModel!.products!));
  }

  Future<void> _unbookWarehouseProduct(
      UnbookWarehouseProduct event, Emitter<SellingState> emit) async {
    await _sellingRepository.unbookWareHouseProduct(event.id);
    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts('', '', state.searchText);
    emit(state.copyWith(
        sellingWarehouseModel: sellingWarehouseModel!.products!));
  }
}
