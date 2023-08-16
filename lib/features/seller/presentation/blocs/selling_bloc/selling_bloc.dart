import 'package:admin_seller/features/seller/data/selling_data/selling_warehouse_model.dart';
import 'package:admin_seller/features/seller/repository/selling_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selling_event.dart';
part 'selling_state.dart';

class SellingBloc extends Bloc<SellingEvent, SellingState> {
  SellingBloc() : super(SellingState()) {
    on<GetWarehouseProducts>(_getWarehouseProducts);
  }

  final SellingRepository _sellingRepository = SellingRepository();
  Future<void> _getWarehouseProducts(
      GetWarehouseProducts event, Emitter<SellingState> emit) async {
    SellingWarehouseModel? sellingWarehouseModel;
    emit(state.copyWith(showLoadingWarehouseProducts: true));
    sellingWarehouseModel =
        await _sellingRepository.getWarehouseProducts('', '', '');

    emit(state.copyWith(
        sellingWarehouseModel: sellingWarehouseModel,
        showLoadingWarehouseProducts: false));
  }
}
