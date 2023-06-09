import 'dart:io';
import 'package:admin_seller/app.dart';
import 'package:admin_seller/features/main_feature/data/models/usermodel/hive_usermodel.dart';
import 'package:admin_seller/firebase_options.dart';
import 'package:admin_seller/services/firebase_push_notification.dart';
import 'package:admin_seller/services/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserModelHiveAdapter());
  await Hive.openBox<UserModelHive>('User');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseNotificationService().initNotifications();
  LocalNotificationService().initialize();
  runApp(const MyApp());
}







  // final fcmToken = (await FirebaseMessaging.instance.getToken())!;
  // await AuthLocalDataSource().saveFcmToken(fcmToken);
  // print('FCMTOKEN -------------------------- $fcmToken');
  // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground: ${message.messageId}');
  //   // Handle the received message here
  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print('A new onMessageOpenedApp event was published!');
  //   // Handle the received message here
  // });
  // NotificationSettings notificationSettings =
  //     await firebaseMessaging.requestPermission(
  //         alert: true,
  //         announcement: false,
  //         badge: true,
  //         carPlay: false,
  //         sound: true,
  //         criticalAlert: false,
  //         provisional: false);
  // print(
  //     'User granted permission: ${notificationSettings.authorizationStatus}');
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.top]);