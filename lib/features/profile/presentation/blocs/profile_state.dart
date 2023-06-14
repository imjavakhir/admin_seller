part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool switchValue;
  final UserOnlineModel? userOnlineModel;
  final bool? isAdmin;
  const ProfileState(
      {this.switchValue = false, this.userOnlineModel, this.isAdmin});

  ProfileState copyWith({final bool? switchValue}) {
    return ProfileState(switchValue: switchValue ?? this.switchValue);
  }

  @override
  List<Object> get props => [switchValue];
}
