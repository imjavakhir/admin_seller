part of 'seller_admin_bloc.dart';

class SellerAdminState {
  final List<Sellers?>? sellerList;
  final Sellers? seller;
  final bool showLoading;
  final bool showLoadingVisits;
  final bool showLoadingVisitsStored;
  final Seller sellerType;
  final Sellers? selectedSeller;
  final bool showLoadingVisitSellers;
  final List<AdminSellerVisitSellers?>? adminVisitSellers;
  final List<AdminVisitsInfo?>? adminVisist;
  final List<AdminVisitsInfo?>? adminVisitStored;
  final int pageIndex;
  final bool hasReached;
   int page;

   SellerAdminState(
      {this.sellerList,
      this.hasReached = false,
      this.pageIndex = 0,
      this.page =1,
      this.adminVisist,
      this.adminVisitStored,
      this.showLoadingVisitsStored = false,
      this.showLoadingVisits = false,
      this.showLoadingVisitSellers = false,
      this.adminVisitSellers,
      this.seller,
      this.showLoading = false,
      this.sellerType = Seller.auto,
      this.selectedSeller});

  SellerAdminState copyWith(
      {final bool? showLoading,
       int? page,
      final bool? hasReached,
      final int? pageIndex,
      final List<AdminVisitsInfo?>? adminVisitStored,
      final List<AdminVisitsInfo?>? adminVisist,
      final bool? showLoadingVisitsStored,
      final bool? showLoadingVisits,
      final bool? showLoadingVisitSellers,
      final List<AdminSellerVisitSellers?>? adminVisitSellers,
      final List<Sellers?>? sellerList,
      final Sellers? seller,
      final Seller? sellerType,
      final Sellers? selectedSeller}) {
    return SellerAdminState(
      page: page??this.page,
        hasReached: hasReached ?? this.hasReached,
        pageIndex: pageIndex ?? this.pageIndex,
        adminVisitStored: adminVisitStored ?? this.adminVisitStored,
        showLoadingVisitsStored:
            showLoadingVisitsStored ?? this.showLoadingVisitsStored,
        adminVisist: adminVisist ?? this.adminVisist,
        showLoadingVisitSellers:
            showLoadingVisitSellers ?? this.showLoadingVisitSellers,
        showLoadingVisits: showLoadingVisits ?? this.showLoadingVisits,
        adminVisitSellers: adminVisitSellers ?? this.adminVisitSellers,
        showLoading: showLoading ?? this.showLoading,
        seller: seller ?? this.seller,
        sellerList: sellerList ?? this.sellerList,
        sellerType: sellerType ?? this.sellerType,
        selectedSeller: selectedSeller ?? this.selectedSeller);
  }
}
