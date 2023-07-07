// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seller_bloc.dart';

abstract class SellerEvent {
  const SellerEvent();
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
  final bool report;
  final String id;
  final int index;
  final String sharedId;

  const ClearVisits(this.index, this.id, this.report, this.sharedId);
}

class SavePauseInfo extends SellerEvent {}

class ShareClient extends SellerEvent {
  final String? notificationId;
  final String? sellerId;

  const ShareClient(
    this.notificationId,
    this.sellerId,
  );
}

class GetSellersEvent extends SellerEvent {}

class ShareSelectedSeller extends SellerEvent {
  Sellers selectedSeller;
  ShareSelectedSeller({
    required this.selectedSeller,
  });
}

class DisconnectSocket extends SellerEvent {}

class ConnectSocket extends SellerEvent {}

class ShareClientBUtton extends SellerEvent {
  final int shareIndex;

  const ShareClientBUtton(this.shareIndex);
}

class HelpShareClient extends SellerEvent {
  final String notificationId;
  final String sellerId;

  const HelpShareClient(this.notificationId, this.sellerId);
}

class HelpNotifications extends SellerEvent {
  final List<HelpClientInfo?> helpClients;

  const HelpNotifications(this.helpClients);
}

class ChangeReportStatus extends SellerEvent {}

class GetNewSellerVisits extends SellerEvent {}
