part of 'accept_online_bloc.dart';

abstract class AcceptOnlineEvent extends Equatable {
  const AcceptOnlineEvent();

  @override
  List<Object> get props => [];
}

class GetUsersUnverifiedEvent extends AcceptOnlineEvent {}

class AcceptUserEvent extends AcceptOnlineEvent {
  final int index;

  const AcceptUserEvent(this.index);
}
