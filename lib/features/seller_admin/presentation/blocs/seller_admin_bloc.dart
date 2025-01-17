import 'package:admin_seller/app_const/app_exports.dart';

part 'seller_admin_event.dart';
part 'seller_admin_state.dart';

class SellerAdminBloc extends Bloc<SellerAdminEvent, SellerAdminState> {
  SellerAdminBloc() : super(SellerAdminState(sellerList: [])) {
    on<GetSellerListEvent>(_getSellersEvent);
    on<GetSellerEvent>(_getSellerEvent);
    on<OnSellerChangeEvent>(_onSellerChangeEvent);
    on<SelectedSellerEvent>(_selectedSellerEvent);
    on<GetAdminVisitSellers>(_getAdminVisitSellers);
    on<GetAdminVisits>(_getAdminVisits);
    on<LoadMoreAdminVisits>(_loadMoreAdminVisits);
    on<GetAdminVisitStored>(_getAdminVisitStored);
    on<ChangePageView>(_changePageView);
    // on<GetAdminVisitsRefresh>(_getAdminVisitsRefresh);
  }
  final SellerAdminRepository _sellerAdminRepository = SellerAdminRepository();
  final scrollController = ScrollController();
  List<AdminVisitsInfo?> adminVisitList = [];

  int page = 1;

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

  Future<void> _loadMoreAdminVisits(
      LoadMoreAdminVisits event, Emitter<SellerAdminState> emit) async {
    if (state.loadMoreLoading) return;
    emit(state.copyWith(loadMoreLoading: true));
    if (!state.hasReached) {
      page++;
      debugPrint(page.toString());
    }
    final loadMoreVisits =
        await _sellerAdminRepository.getAdminSellerVisits(page: page, size: 10);
    if (loadMoreVisits!.data!.isEmpty) {
      emit(state.copyWith(hasReached: true));
    }
    adminVisitList.addAll(loadMoreVisits.data!);
    emit(state.copyWith(adminVisist: adminVisitList, loadMoreLoading: false));
  }

  Future<void> _getAdminVisits(
      GetAdminVisits event, Emitter<SellerAdminState> emit) async {
    emit(state.copyWith(showLoadingVisits: true));

    final adminSellerVisit =
        await _sellerAdminRepository.getAdminSellerVisits(page: 1, size: 10);
    adminVisitList = adminSellerVisit!.data!;
    page = 1;

    emit(state.copyWith(
        adminVisist: adminVisitList,
        showLoadingVisits: false,
        hasReached: false));
  }

  // Future<void> _getAdminVisitsRefresh(
  //     GetAdminVisitsRefresh event, Emitter<SellerAdminState> emit) async {
  //   emit(state.copyWith(adminVisist: adminVisitList, showLoadingVisits: true));
  //   final adminSellerVisit =
  //       await _sellerAdminRepository.getAdminSellerVisits(page: 1, size: 5);
  //   adminVisitList.clear();
  //   adminVisitList.addAll(adminSellerVisit!.data!);
  //   page = 2;
  //   emit(state.copyWith(
  //       adminVisist: adminVisitList,
  //       showLoadingVisits: false,
  //       hasReached: false));
  // }

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
