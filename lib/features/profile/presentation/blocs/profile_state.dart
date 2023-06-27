part of 'profile_bloc.dart';

class ProfileState {
  final String rating;
  final bool switchValue;
  final bool isVerified;
  final bool? isAdmin;
  const ProfileState(
      {this.switchValue = false, this.isVerified = false, this.isAdmin, this.rating='0'});

  ProfileState copyWith({final bool? switchValue, final bool? isVerified,final String? rating}) {
    return ProfileState(
        switchValue: switchValue ?? this.switchValue,
        isVerified: isVerified ?? this.isVerified,
        rating: rating??this.rating);
  }
}
