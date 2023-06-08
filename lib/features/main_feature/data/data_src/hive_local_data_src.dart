import 'package:admin_seller/features/main_feature/data/models/usermodel/hive_usermodel.dart';
import 'package:hive/hive.dart';

class HiveDataSource {
  late UserModelHive user;
  var box = Hive.box<UserModelHive>('User');
  late UserModelHive employee;
  Future<void> saveUserDetails(
      {required String branch,
      required String fullName,
      required String type}) async {
    final userModelHive = UserModelHive()
      ..fullName = fullName
      ..branch = branch
      ..type = type;
    box.add(userModelHive);

    print(userModelHive.fullName);
    print('savedhive---------------');
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
  }
}
