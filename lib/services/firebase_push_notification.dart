import 'package:admin_seller/app_const/app_exports.dart';

class FirebaseNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();


    String? fcmToken = await _firebaseMessaging.getToken();
    await AuthLocalDataSource().saveFcmToken(fcmToken!);


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
