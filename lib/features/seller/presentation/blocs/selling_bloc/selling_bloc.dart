import 'package:admin_seller/features/seller/data/selling_data/selling_my_orders_model.dart';
import 'package:admin_seller/features/seller/data/selling_data/selling_warehouse_model.dart';
import 'package:admin_seller/features/seller/repository/selling_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selling_event.dart';
part 'selling_state.dart';

class SellingBloc extends Bloc<SellingEvent, SellingState> {
  SellingBloc() : super(SellingState()) {
    on<GetWarehouseProducts>(_getWarehouseProducts);
    on<BookWarehouseProduct>(_bookWarehouseProduct);
    on<UnbookWarehouseProduct>(_unbookWarehouseProduct);
    on<GetSellingMyOrders>(_getSellingMyOrders);
  }

  final SellingRepository _sellingRepository = SellingRepository();
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
        sellingWarehouseModel: sellingWarehouseModel,
        showLoadingWarehouseProducts: false));
  }

  Future<void> _bookWarehouseProduct(
      BookWarehouseProduct event, Emitter<SellingState> emit) async {
    await _sellingRepository.bookWareHouseProduct(event.dateTime, event.id);
    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts('', '', '');
    emit(state.copyWith(sellingWarehouseModel: sellingWarehouseModel));
  }

  Future<void> _unbookWarehouseProduct(
      UnbookWarehouseProduct event, Emitter<SellingState> emit) async {
    await _sellingRepository.unbookWareHouseProduct(event.id);
    final sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts('', '', '');
    emit(state.copyWith(sellingWarehouseModel: sellingWarehouseModel));
  }
}
