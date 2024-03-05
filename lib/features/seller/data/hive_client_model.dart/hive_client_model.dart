import 'package:admin_seller/app_const/app_exports.dart';

part 'hive_client_model.g.dart';

@HiveType(typeId: 1)
class HiveClientModel extends HiveObject {
  @HiveField(0)
  late String fullName;
  @HiveField(1)
  late String phoneNumber;
  @HiveField(2)
  late String whereFrom;
  @HiveField(3)
  late String details;
  @HiveField(4)
  late String id;
}
