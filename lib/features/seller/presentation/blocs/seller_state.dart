part of 'seller_bloc.dart';

class SellerState extends Equatable {
  final bool isPaused;
  List<ClientInfo?> clientInfoList;
  SellerState({required this.clientInfoList, this.isPaused = true});

  SellerState copyWith(
      {final List<ClientInfo?>? clientInfoList, final bool? isPaused}) {
    // debugPrint('Error ------------- $error');
    return SellerState(
        isPaused: isPaused ?? this.isPaused,
        clientInfoList: clientInfoList ?? this.clientInfoList);
  }

  @override
  List<Object> get props => [isPaused, clientInfoList];
}
