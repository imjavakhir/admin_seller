part of 'accept_online_bloc.dart';

class AcceptOnlineState {
  // final List<UserUnverified?> userOnlineModelList;
  // final int selectedItem;
  // final bool loading;

  // const AcceptOnlineState(
  //     {
  //     this.loading = false,
  //     this.selectedItem = -1});
  // AcceptOnlineState copyWith({final bool? loading, final int? selectedItem}) {
  //   return AcceptOnlineState(
  //       loading: loading ?? this.loading,
  //       selectedItem: selectedItem ?? this.selectedItem,
  //      );
  // }
}

class AcceptOnlineStateLoading extends AcceptOnlineState {}

class AcceptOnlineStateLoaded extends AcceptOnlineState {
  final List<UserUnverified?> userUnverifiedList;

  AcceptOnlineStateLoaded({required this.userUnverifiedList});
}
