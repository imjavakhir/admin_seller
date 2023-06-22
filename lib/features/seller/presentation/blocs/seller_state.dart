part of 'seller_bloc.dart';

class SellerState {
  final bool isPaused;
  final String whereFrom;
  final bool showLoading;
  final int selectedIndex;
  List<ClientInfo?> clientInfoList;
  SellerState(
      {required this.clientInfoList,
      this.isPaused = true,
      this.whereFrom = 'instagram',
      this.showLoading = false,
      this.selectedIndex=-1});

  SellerState copyWith(
      {final List<ClientInfo?>? clientInfoList,
      final bool? isPaused,
      final String? whereFrom,
      final bool? showLoading,
      final int? selectedIndex}) {
    // debugPrint('Error ------------- $error');
    return SellerState(
        isPaused: isPaused ?? this.isPaused,
        clientInfoList: clientInfoList ?? this.clientInfoList,
        whereFrom: whereFrom ?? this.whereFrom,
        showLoading: showLoading ?? this.showLoading,
        selectedIndex: selectedIndex??this.selectedIndex);
  }
}
