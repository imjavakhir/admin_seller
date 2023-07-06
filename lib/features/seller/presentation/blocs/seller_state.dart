part of 'seller_bloc.dart';

class SellerState {
  final bool isReported;
  final bool isPaused;
  final String? whereFrom;
  final bool showLoading;
  final int selectedIndex;
  final List<Sellers?> sellerList;
  List<ClientInfo?> clientInfoList;
  final bool showLoadingBottomSheet;
  final Sellers? selectedSeller;
  final bool isShared;
  List<HelpClientInfo?> helpClients;
  final bool loadingdata;

  SellerState(
      {required this.clientInfoList,
      this.isReported = false,
      required this.helpClients,
      required this.sellerList,
      this.isShared = false,
      this.selectedSeller,
      this.isPaused = false,
      this.whereFrom,
      this.showLoading = false,
      this.showLoadingBottomSheet = false,
      this.selectedIndex = -1,
      this.loadingdata=false});

  SellerState copyWith(
      {final List<ClientInfo?>? clientInfoList,
      final bool? isPaused,
      final bool? isReported,
      final String? whereFrom,
      final bool? showLoading,
      final int? selectedIndex,
      final bool? showLoadingBottomSheet,
      final List<Sellers?>? sellerList,
      final Sellers? selectedSeller,
      List<HelpClientInfo?>? helpClients,
      final bool? isShared,
      final bool? loadingdata}) {
    // debugPrint('Error ------------- $error');
    return SellerState(
      loadingdata: loadingdata??this.loadingdata,
        helpClients: helpClients ?? this.helpClients,
        isReported: isReported ?? this.isReported,
        isPaused: isPaused ?? this.isPaused,
        clientInfoList: clientInfoList ?? this.clientInfoList,
        whereFrom: whereFrom ?? this.whereFrom,
        showLoading: showLoading ?? this.showLoading,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        showLoadingBottomSheet:
            showLoadingBottomSheet ?? this.showLoadingBottomSheet,
        sellerList: sellerList ?? this.sellerList,
        selectedSeller: selectedSeller ?? this.selectedSeller,
        isShared: isShared ?? this.isShared);
  }
}

