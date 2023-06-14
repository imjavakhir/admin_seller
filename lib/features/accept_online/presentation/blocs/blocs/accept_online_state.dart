part of 'accept_online_bloc.dart';

class AcceptOnlineState extends Equatable {
  final List<UserUnverified?> userOnlineModelList;

  const AcceptOnlineState({ required this.userOnlineModelList});

  @override
  List<Object> get props => [userOnlineModelList];
}
