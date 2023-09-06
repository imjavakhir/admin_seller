import 'package:admin_seller/features/seller/data/hive_client_model.dart/hive_client_model.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'app_const/app_exports.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserModelHiveAdapter());
  Hive.registerAdapter(HiveClientModelAdapter());
  await Hive.openBox<UserModelHive>('User');
  await Hive.openBox<HiveClientModel>('Client');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseNotificationService().initNotifications();
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // await AuthLocalDataSource().saveFcmToken(fcmToken!);
  LocalNotificationService().initialize();
  String? localToken = await AuthLocalDataSource().getLogToken();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Future.delayed(const Duration(seconds: 2))
      .then((value) => {FlutterNativeSplash.remove()});

  runApp(MyApp(
    savedToken: localToken,
  ));
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