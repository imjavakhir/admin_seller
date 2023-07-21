import 'dart:io';

import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FirebaseNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    await AuthLocalDataSource().saveFcmToken(fcmToken!);

    // final apnToken = await _firebaseMessaging.getAPNSToken();
    // // await AuthLocalDataSource().saveFcmToken(apnToken!);
    // debugPrint("{$apnToken}----------");

    await _firebaseMessaging.requestPermission();

    if (Platform.isIOS) {
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _firebaseMessaging.getInitialMessage().then((message) {
      print('app is terminated');
      if (message != null) {
        print('New Notification');
      }
    });

    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen((message) {
        print('app is on onMessage');
        if (message.notification != null) {
          print('New Notification');
          print(message.notification!.title);
          print(message.notification!.body);

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

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print('New Notification');
    print(message.notification!.title);
    print(message.notification!.body);

    // LocalNotificationService().createNotification(message);
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