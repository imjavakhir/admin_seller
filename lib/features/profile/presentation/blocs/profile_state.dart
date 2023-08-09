part of 'profile_bloc.dart';

class ProfileState {
  final String rating;
  final bool switchValue;
  final bool isVerified;
  final bool? isAdmin;
  final String balance;
  final String phoneNumber;
  const ProfileState(
      {this.switchValue = false,
      this.isVerified = false,
      this.balance = '0',
      this.isAdmin,
      this.phoneNumber = '0000000',
      this.rating = '0'});

  ProfileState copyWith(
      {final bool? switchValue,
      final bool? isVerified,
      final String? rating,
      final String? balance,
      final String? phoneNumber}) {
    return ProfileState(
        balance: balance ?? this.balance,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        switchValue: switchValue ?? this.switchValue,
        isVerified: isVerified ?? this.isVerified,
        rating: rating ?? this.rating);
  }
}
