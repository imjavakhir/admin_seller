part of 'seller_admin_bloc.dart';

class SellerAdminState {
  final List<Sellers?>? sellerList;
  final Sellers? seller;
  final bool showLoading;
  final Seller sellerType;
  final Sellers? selectedSeller;

  const SellerAdminState(
      {this.sellerList,
      this.seller,
      this.showLoading = false,
      this.sellerType = Seller.auto,
      this.selectedSeller});

  SellerAdminState copyWith(
      {final bool? showLoading,
      final List<Sellers?>? sellerList,
      final Sellers? seller,
      final Seller? sellerType,
      final Sellers? selectedSeller}) {
    return SellerAdminState(
        showLoading: showLoading ?? this.showLoading,
        seller: seller ?? this.seller,
        sellerList: sellerList ?? this.sellerList,
        sellerType: sellerType ?? this.sellerType,
        selectedSeller: selectedSeller ?? this.selectedSeller);
  }
}
