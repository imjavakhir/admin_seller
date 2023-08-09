import 'package:admin_seller/features/main_feature/data/models/seller_model/sellers_model.dart';
import 'package:admin_seller/features/seller_admin/data/admin_seller_visits.dart';
import 'package:admin_seller/features/seller_admin/data/admin_seller_visits_sellers.dart';
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
    on<GetAdminVisitSellers>(_getAdminVisitSellers);
    on<GetAdminVisits>(_getAdminVisits);
    on<GetAdminVisitStored>(_getAdminVisitStored);
    on<ChangePageView>(_changePageView);
  }
  final SellerAdminRepository _sellerAdminRepository = SellerAdminRepository();

  void _changePageView(ChangePageView event, Emitter<SellerAdminState> emit) {
    emit(state.copyWith(pageIndex: event.pageIndex));
  }

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

  Future<void> _getAdminVisitSellers(
      GetAdminVisitSellers event, Emitter<SellerAdminState> emit) async {
    emit(state.copyWith(showLoadingVisitSellers: true));

    final adminSellerVisitSellers =
        await _sellerAdminRepository.getAdminSellerVisitSellers(id: event.id);
    emit(state.copyWith(
        adminVisitSellers: adminSellerVisitSellers,
        showLoadingVisitSellers: false));
  }

  Future<void> _getAdminVisits(
      GetAdminVisits event, Emitter<SellerAdminState> emit) async {
    emit(state.copyWith(showLoadingVisits: true));

    final adminSellerVisit =
        await _sellerAdminRepository.getAdminSellerVisits();
    emit(state.copyWith(
        adminVisist: adminSellerVisit, showLoadingVisits: false));
  }

  Future<void> _getAdminVisitStored(
      GetAdminVisitStored event, Emitter<SellerAdminState> emit) async {
    emit(state.copyWith(showLoadingVisitsStored: true));

    final adminVisitStored =
        await _sellerAdminRepository.getAdminSellerVisitsStored();
    emit(state.copyWith(
        adminVisitStored: adminVisitStored, showLoadingVisitsStored: false));
  }

  void _onSellerChangeEvent(
      OnSellerChangeEvent event, Emitter<SellerAdminState> emit) {
    emit(state.copyWith(
        sellerType: event.seller,
        selectedSeller:
            Sellers(id: '', fullname: 'Виберите продавца', phoneNumber: '')));
  }

  void _selectedSellerEvent(
      SelectedSellerEvent event, Emitter<SellerAdminState> emit) {
    emit(state.copyWith(selectedSeller: event.selectedSeller));
  }
}
