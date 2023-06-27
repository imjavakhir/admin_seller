import 'package:admin_seller/features/main_feature/data/models/seller_model/sellers_model.dart';
import 'package:admin_seller/features/seller_admin/presentation/pages/admin_seller.dart';
import 'package:admin_seller/features/seller_admin/repository/seller_admin_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seller_admin_event.dart';
part 'seller_admin_state.dart';

class SellerAdminBloc extends Bloc<SellerAdminEvent, SellerAdminState> {
  SellerAdminBloc() : super(const SellerAdminState(sellerList: [])) {
    on<GetSellerListEvent>(_getSellersEvent);
    on<GetSellerEvent>(_getSellerEvent);
    on<OnSellerChangeEvent>(_onSellerChangeEvent);
    on<SelectedSellerEvent>(_selectedSellerEvent);
  }
  final SellerAdminRepository _sellerAdminRepository = SellerAdminRepository();
  void _getSellersEvent(
      GetSellerListEvent event, Emitter<SellerAdminState> emit) async {
    emit(state.copyWith(showLoading: true));
    final sellerList = await _sellerAdminRepository.getSellers();
    emit(state.copyWith(sellerList: sellerList, showLoading: false));
  }

  Future<void> _getSellerEvent(
      GetSellerEvent event, Emitter<SellerAdminState> emit) async {
    emit(state.copyWith(showLoading: true));
  
    final seller = await _sellerAdminRepository.getSeller();
    emit(state.copyWith(seller: seller, showLoading: false));
  }

  void _onSellerChangeEvent(
      OnSellerChangeEvent event, Emitter<SellerAdminState> emit) {
    emit(state.copyWith(sellerType: event.seller));
  }

  void _selectedSellerEvent(
      SelectedSellerEvent event, Emitter<SellerAdminState> emit) {
    emit(state.copyWith(selectedSeller: event.selectedSeller));
  }
}
