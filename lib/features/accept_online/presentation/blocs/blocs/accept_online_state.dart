part of 'accept_online_bloc.dart';

class AcceptOnlineState {
  final List<UserUnverified?> userOnlineModelList;
  final int selectedItem;
  final bool loading;

  const AcceptOnlineState(
      {required this.userOnlineModelList,
      this.loading = false,
      this.selectedItem = -1});
  AcceptOnlineState copyWith({final bool? loading, final int? selectedItem}) {
    return AcceptOnlineState(
        loading: loading ?? this.loading,
        selectedItem: selectedItem ?? this.selectedItem,
        userOnlineModelList: []);
  }
}
