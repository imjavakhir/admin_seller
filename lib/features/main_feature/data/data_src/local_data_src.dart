import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//logtoken save

  Future<void> saveLogToken(String logToken) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('logToken', logToken);
    debugPrint('logtoken-----------------------------$logToken ---- saved');
  }

//fcmtoken save
  Future<void> saveFcmToken(String fcmToken) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('fcmToken', fcmToken);
    debugPrint('fcmtoken-----------------------------$fcmToken------ saved');
  }

//fcmtoken get
  Future<String?> getFcmToken() async {
    final SharedPreferences prefs = await _prefs;
    final tokenFcm = prefs.getString('fcmToken');
    debugPrint('fcmtoken-----------------------------$tokenFcm------ fromlocal');
    return tokenFcm;
  }

//logtoken get
  Future<String?> getLogToken() async {
    final SharedPreferences prefs = await _prefs;
    final tokenLog = prefs.getString('logToken');
    debugPrint('logtoken-----------------------------$tokenLog ---- fromlocal');
    return tokenLog;
  }

//fcmtoken get
  Future<bool> removeFcmToken() async {
    final SharedPreferences prefs = await _prefs;
    final removedFcm = prefs.remove('fcmToken');
    debugPrint('-----------------------removeFcm----$removedFcm');
    return removedFcm;
  }

//logtoken remove
  Future<bool> removeLogToken() async {
    final SharedPreferences prefs = await _prefs;

    final removedLog = prefs.remove('logToken');
    
    final tokenStatus = await removedLog;
    debugPrint('-----------------------removeLog----$tokenStatus');
    return removedLog;
  }

  //savee userstatus
  Future<void> saveUserStatus(bool isVerified) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setBool(
      'isverified',
      isVerified,
    );
    debugPrint('isverified-----------------------------$isVerified ---- saved');
  }

  //get userstatus
  Future<bool?> getUserStatus() async {
    final SharedPreferences prefs = await _prefs;
    final isverified = prefs.getBool('isverified');
    debugPrint('isverified-----------------------------$isverified ---- fromlocal');
    return isverified;
  }

  //remove userstatus
  Future<bool> removeUserStatus() async {
    final SharedPreferences prefs = await _prefs;
    final removedveri = prefs.remove('isverified');
    debugPrint('-----------------------removedveri----$removedveri');
    return removedveri;
  }

  //save statusswitch
  Future<void> saveUserStatusSwitch(bool switchValue) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setBool(
      'switchValue',
      switchValue,
    );
    debugPrint('switchvalue-----------------------------$switchValue ---- saved');
  }

  //get statusswitch
  Future<bool?> getUserStatusSwitch() async {
    final SharedPreferences prefs = await _prefs;
    final tokenLog = prefs.getBool('switchValue');
    debugPrint('switchvalue-----------------------------$tokenLog ---- fromlocal');
    return tokenLog;
  }

  //remove statuswitch
  Future<bool> removeUserStatusSwitch() async {
    final SharedPreferences prefs = await _prefs;
    final removedswitch = prefs.remove('switchValue');
    debugPrint('-----------------------removeLog----$removedswitch');
    return removedswitch;
  }

  Future<void> saveUserPause(bool pauseValue) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setBool(
      'pauseValue',
      pauseValue,
    );
    debugPrint('pauseValue-----------------------------$pauseValue ---- saved');
  }

  //get statusswitch
  Future<bool?> getUserPause() async {
    final SharedPreferences prefs = await _prefs;
    final pauseValue = prefs.getBool('pauseValue');
    debugPrint('pausevalue-----------------------------$pauseValue ---- fromlocal');
    return pauseValue;
  }

  //remove statuswitch
  Future<bool> removeUserPause() async {
    final SharedPreferences prefs = await _prefs;
    final removePause = prefs.remove('pauseValue');
    debugPrint('-----------------------pauseremove----$removePause');
    return removePause;
  }
}
