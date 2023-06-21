part of 'seller_bloc.dart';

class SellerState {
  final bool isPaused;
  final String whereFrom;
  List<ClientInfo?> clientInfoList;
  SellerState({required this.clientInfoList, this.isPaused = true,this.whereFrom='instagram'});

  SellerState copyWith(
      {final List<ClientInfo?>? clientInfoList, final bool? isPaused,final String? whereFrom}) {
    // debugPrint('Error ------------- $error');
    return SellerState(
        isPaused: isPaused ?? this.isPaused,
        clientInfoList: clientInfoList ?? this.clientInfoList,whereFrom: whereFrom??this.whereFrom);
  }
}
