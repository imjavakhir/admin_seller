part of 'seller_bloc.dart';

class SellerState {
  final bool isPaused;
  final String? whereFrom;
  final bool showLoading;
  final int selectedIndex;
  final List<Sellers?> sellerList;
  List<ClientInfo?> clientInfoList;
  final bool showLoadingBottomSheet;
  final Sellers? selectedSeller;

  SellerState(
      {required this.clientInfoList,
    required  this.sellerList,
        this.selectedSeller,
      this.isPaused = false,
      this.whereFrom,
      this.showLoading = false,
      this.showLoadingBottomSheet = false,
      this.selectedIndex = -1});

  SellerState copyWith({
    final List<ClientInfo?>? clientInfoList,
    final bool? isPaused,
    final String? whereFrom,
    final bool? showLoading,
    final int? selectedIndex,
    final bool? showLoadingBottomSheet,
    final List<Sellers?>? sellerList,
     final Sellers? selectedSeller
  }) {
    // debugPrint('Error ------------- $error');
    return SellerState(
      isPaused: isPaused ?? this.isPaused,
      clientInfoList: clientInfoList ?? this.clientInfoList,
      whereFrom: whereFrom ?? this.whereFrom,
      showLoading: showLoading ?? this.showLoading,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      showLoadingBottomSheet:
          showLoadingBottomSheet ?? this.showLoadingBottomSheet,
      sellerList: sellerList ?? this.sellerList,
      selectedSeller: selectedSeller??this.selectedSeller
    );
  }
}
