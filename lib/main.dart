import 'package:admin_seller/features/seller/data/hive_client_model.dart/hive_client_model.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;

import 'app_const/app_exports.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Directory directory = await pathprovider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserModelHiveAdapter());
  Hive.registerAdapter(HiveClientModelAdapter());
  await Hive.openBox<UserModelHive>('User');
  await Hive.openBox<HiveClientModel>('Client');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotificationService().initNotifications();
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
