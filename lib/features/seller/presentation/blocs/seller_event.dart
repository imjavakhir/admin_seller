// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seller_bloc.dart';

abstract class SellerEvent extends Equatable {
  const SellerEvent();

  @override
  List<Object> get props => [];
}

class SellerPauseEvent extends SellerEvent {}
class ConnectSocket extends SellerEvent {}

class ClientInfoListEvent extends SellerEvent {
  final List<ClientInfo?> clientInfosList;

  const ClientInfoListEvent(this.clientInfosList);
}
