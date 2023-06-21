abstract class AppIcons {
  static const String home = 'assets/icons/home.svg';
  static const String profile = 'assets/icons/user_profile.svg';
  static const String clock = 'assets/icons/clock.svg';
  static const String tick = 'assets/icons/tick-circle.svg';
  static const String userTick = 'assets/icons/user-tick.svg';
  static const String userRemove = 'assets/icons/user-remove.svg';
  static const String tickMenu = 'assets/icons/location-tick.svg';
  static const String closeCircle = 'assets/icons/close-circle.svg';

  static const String other = 'assets/icons/other.svg';
  static const String telegram = 'assets/icons/telegram.svg';
  static const String instagram = 'assets/icons/instagram.svg';
  static const String baner = 'assets/icons/baner.svg';
  static const String facebook = 'assets/icons/facebook.svg';
  static const String recommended = 'assets/icons/recommended.svg';

  static const Map<String, dynamic> bottomNavigationItems = {
    'Home': {'inactive': home, 'active': home},
    'Profile': {'inactive': profile, 'active': profile},
  };
  static const Map<String, dynamic> bottomNavigationItemsAdmin = {
    'Home': {'inactive': home, 'active': home},
    'Accept': {'inactive': tickMenu, 'active': tickMenu},
    'Profile': {'inactive': profile, 'active': profile},
  };
}
