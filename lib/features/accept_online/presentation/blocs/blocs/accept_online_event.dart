part of 'accept_online_bloc.dart';

abstract class AcceptOnlineEvent {
  const AcceptOnlineEvent();
}

class GetUsersUnverifiedEvent extends AcceptOnlineEvent {}

class AcceptUserEvent extends AcceptOnlineEvent {
  final int index;
  final String id;

  const AcceptUserEvent(this.id, this.index);
}
