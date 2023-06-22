part of 'profile_bloc.dart';

class ProfileState {
  final bool switchValue;
  final bool isVerified;
  final bool? isAdmin;
  const ProfileState(
      {this.switchValue = false, this.isVerified = false, this.isAdmin});

  ProfileState copyWith({final bool? switchValue, final bool? isVerified}) {
    return ProfileState(
        switchValue: switchValue ?? this.switchValue,
        isVerified: isVerified ?? this.isVerified);
  }
}
