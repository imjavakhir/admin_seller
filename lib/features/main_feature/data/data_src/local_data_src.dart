import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveLogToken(String logToken) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('logToken', logToken);
    print('logtoken-----------------------------$logToken ---- saved');
  }

  Future<void> saveFcmToken(String fcmToken) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('fcmToken', fcmToken);
    print('fcmtoken-----------------------------$fcmToken------ saved');
  }

  Future<String?> getFcmToken() async {
    final SharedPreferences prefs = await _prefs;
    final tokenFcm = prefs.getString('fcmToken');
    print('fcmtoken-----------------------------$tokenFcm------ fromlocal');
    return tokenFcm;
  }

  Future<String?> getLogToken() async {
    final SharedPreferences prefs = await _prefs;
    final tokenLog = prefs.getString('logToken');
    print('logtoken-----------------------------$tokenLog ---- fromlocal');
    return tokenLog;
  }

  Future<bool> removeFcmToken() async {
    final SharedPreferences prefs = await _prefs;
    final removedFcm = prefs.remove('fcmToken');
    return removedFcm;
  }

  Future<bool> removeLogToken() async {
    final SharedPreferences prefs = await _prefs;
    final removedLog = prefs.remove('logToken');
    return removedLog;
  }
}
