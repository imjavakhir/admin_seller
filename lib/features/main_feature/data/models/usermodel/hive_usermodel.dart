import 'package:hive/hive.dart';
part 'hive_usermodel.g.dart';

@HiveType(typeId: 0)
class UserModelHive extends HiveObject {
  @HiveField(0)
   late String fullName;
  @HiveField(1)
   late String type;
  @HiveField(2)
  late String branch;
}
