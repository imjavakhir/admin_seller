import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

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

  Future<void> initNotifications() async {
    final fcmToken = (await _firebaseMessaging.getToken())!;
    await AuthLocalDataSource().saveFcmToken(fcmToken);
    print('FCMTOKEN -------------------------- $fcmToken');
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _firebaseMessaging.getInitialMessage().then((message) {
      print('app is terminated');
      if (message != null) {
        print('New Notification');
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      print('app is on foreground');
      if (message.notification != null) {
        print('New Notification');
        print(message.notification!.title);
        print(message.notification!.body);

        LocalNotificationService().createNotification(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('app is on foreground');
      if (message.notification != null) {
        print('New Notification');
        print(message.notification!.title);
        print(message.notification!.body);

        LocalNotificationService().createNotification(message);
      }
    });
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print('New Notification');
    print(message.notification!.title);
    print(message.notification!.body);

    LocalNotificationService().createNotification(message);
  }
}
