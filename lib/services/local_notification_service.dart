import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initialize() {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    notificationsPlugin.initialize(initializationSettings);
  }

  void createNotification(RemoteMessage message) async {
    final id = DateTime.now().millisecond ~/ 1000;
    NotificationDetails notificationDetails = const NotificationDetails(
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
