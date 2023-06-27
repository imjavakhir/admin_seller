part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class OnlineChangedEvent extends ProfileEvent {
  final bool switchValue;

  const OnlineChangedEvent(this.switchValue);
}
class GetUserRating extends ProfileEvent {}
class GetUserOnlineModelEvent extends ProfileEvent {}
class CheckUserEvent extends ProfileEvent {}

