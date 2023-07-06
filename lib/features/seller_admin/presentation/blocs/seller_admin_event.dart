// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seller_admin_bloc.dart';

abstract class SellerAdminEvent {
  const SellerAdminEvent();
}

class GetSellerListEvent extends SellerAdminEvent {}

class GetSellerEvent extends SellerAdminEvent {}

class OnSellerChangeEvent extends SellerAdminEvent {
  final Seller seller;

  const OnSellerChangeEvent(this.seller);
}

class SelectedSellerEvent extends SellerAdminEvent {
  Sellers selectedSeller;
  SelectedSellerEvent({
    required this.selectedSeller,
  });
}

class SendClient extends SellerAdminEvent {}


