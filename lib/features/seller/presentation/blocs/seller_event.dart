// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seller_bloc.dart';

abstract class SellerEvent extends Equatable {
  const SellerEvent();

  @override
  List<Object> get props => [];
}

class SellerPauseEvent extends SellerEvent {}

class DisconnectSocketEvent extends SellerEvent {}

class GetClientsFromApi extends SellerEvent {}

class WhereFromEvent extends SellerEvent {
  final String whereFrom;

  const WhereFromEvent(this.whereFrom);
}

class ClientInfoListEvent extends SellerEvent {
  final List<ClientInfo?> clientInfosList;

  const ClientInfoListEvent(this.clientInfosList);
}

class ClearVisits extends SellerEvent {
  final String id;
  final int index;

  const ClearVisits(this.index, this.id);
}
