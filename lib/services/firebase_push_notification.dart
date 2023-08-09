import 'dart:io';

import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FirebaseNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    String? fcmToken = await _firebaseMessaging.getToken();
    await AuthLocalDataSource().saveFcmToken(fcmToken!);

    // final apnToken = await _firebaseMessaging.getAPNSToken();
    // // await AuthLocalDataSource().saveFcmToken(apnToken!);
    // debugPrint("{$apnToken}----------");

    if (Platform.isIOS) {
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _firebaseMessaging.getInitialMessage().then((message) {
      debugPrint('app is terminated');
      if (message != null) {
        debugPrint('New Notification');
      }
    });

    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen((message) {
        debugPrint('app is on onMessage');
        if (message.notification != null) {
          debugPrint('New Notification');
          debugPrint(message.notification!.title);
          debugPrint(message.notification!.body);

          LocalNotificationService().createNotification(message);
        }
      });
    }

    // if (Platform.isIOS) {
    //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //     print('app is on onMessageOpenedApp');
    //     if (message.notification != null) {
    //       print('New Notification opened app');
    //       print(message.notification!.title);
    //       print(message.notification!.body);

    //       LocalNotificationService().createNotification(message);
    //     }
    //   });
    // }
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    debugPrint('New Notification');
    debugPrint(message.notification!.title);
    debugPrint(message.notification!.body);

    LocalNotificationService().createNotification(message);
  }
}


  // void handleMessage(RemoteMessage? remoteMessage) {
  //   if (remoteMessage == null) {
  //     return;
  //   }
  // }

  // Future initPushNotification() async {
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //           alert: true, badge: true, sound: true);
  //   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  //   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // }