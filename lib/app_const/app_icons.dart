abstract class AppIcons {
  static const String home = 'assets/icons/home.svg';
  static const String profile = 'assets/icons/user_profile.svg';
  static const String clock = 'assets/icons/clock.svg';
  static const String tick = 'assets/icons/tick-circle.svg';

  static const Map<String, dynamic> bottomNavigationItems = {
    'Home': {'inactive': home, 'active': home},
    'Profile': {'inactive': profile, 'active': profile},
  };
}
