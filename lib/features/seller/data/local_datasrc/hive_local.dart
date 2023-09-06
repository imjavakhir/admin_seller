import 'package:admin_seller/app_const/app_exports.dart';
import 'package:admin_seller/features/seller/data/hive_client_model.dart/hive_client_model.dart';

class HiveDataSourceCLient {
  var box = Hive.box<HiveClientModel>('Client');
  late HiveClientModel client;
  Future<void> saveClientDetails(
      {required String phoneNumber,
      required String fullName,
      required String whereFrom,
      required String id,
      required String details}) async {
    final hiveClientModel = HiveClientModel()
      ..fullName = fullName
      ..phoneNumber = phoneNumber
      ..whereFrom = whereFrom
      ..id = id
      ..details = details;
    box.put('client', hiveClientModel);

    debugPrint(hiveClientModel.fullName);
    debugPrint('savedhive---------------');
  }

  // Future<UserModelHive> getEmployees() async {
  //   var box = await Hive.openBox<UserModelHive>('User');
  //   employee = box.values.toList().first;
  //   return employee;
  // }

  // UserModelHive getUserInfo() {
  //   final UserModelHive userModelHive = employee;
  //   return userModelHive;
  // }

  Future<void> clearUserDetails() async {
    box.clear();
    debugPrint('----------clientDetails--------------revmoved');
  }
}
