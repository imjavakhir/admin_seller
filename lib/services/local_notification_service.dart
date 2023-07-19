// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void initialize() {
//     InitializationSettings initializationSettings =
//         const InitializationSettings(
//             android: AndroidInitializationSettings('@mipmap/ic_launcher'));
//     notificationsPlugin.initialize(initializationSettings);
//     notificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestPermission();
//   }

//   void createNotification(RemoteMessage message) async {
//     final id = DateTime.now().millisecond ~/ 1000;
//     NotificationDetails notificationDetails = const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'pushnotificationapp', 'pushnotificationappchanel',
//             importance: Importance.high, priority: Priority.high));
//     await notificationsPlugin.show(id, message.notification!.title,
//         message.notification!.body, notificationDetails);
//     try {} catch (e) {
//       print('-----------------localnotif $e');
//     }
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //   InitializationSettings initializationSettings =
    //       const InitializationSettings(
    //           iOS: DarwinInitializationSettings(),
    //           android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    //   notificationsPlugin.initialize(initializationSettings);
    //   notificationsPlugin
    //       .resolvePlatformSpecificImplementation<
    //           AndroidFlutterLocalNotificationsPlugin>()!
    //       .requestPermission();

    var initializationSettingIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingIOS);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  void createNotification(RemoteMessage message) async {
    final id = DateTime.now().millisecond ~/ 1000;
    NotificationDetails notificationDetails = const NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
            'pushnotificationapp', 'pushnotificationappchanel',
            importance: Importance.high, priority: Priority.high));
    await notificationsPlugin.show(id, message.notification!.title,
        message.notification!.body, notificationDetails);
    try {} catch (e) {
      print('-----------------localnotif $e');
    }
  }
}
