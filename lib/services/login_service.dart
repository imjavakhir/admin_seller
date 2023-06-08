import 'package:admin_seller/features/auth_feature/data/models/user_model.dart';
import 'package:dio/dio.dart';

class LoginService {
  final dio = Dio(BaseOptions(
    contentType: 'application/json',
    connectTimeout: const Duration(milliseconds: 10000),
    receiveTimeout: const Duration(milliseconds: 10000),
  ));
  final loginApi = 'http://64.226.90.160:3000/auth/login';

  Future<UserModel?> login(
      {required String phoneNumber,
      required String password,
      required String role,
      required String fireBaseToken}) async {
    final data = {
      "phone_number": phoneNumber,
      "password": password,
      "role": role,
      "firebase": fireBaseToken
    };
    UserModel? userModel;
    try {
      Response response = await dio.post(loginApi, data: data);
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(response.data);
        print('-----------------success');
        return userModel;
      }
    } catch (error) {
      print('848484 ---------------------------------------$error');
    }
    return userModel;
  }
}

abstract class AppApis {
  static const String baseUrl = 'http://64.226.90.160:3000/';
  static const String authUrl = 'http://64.226.90.160:3000/auth/login';
}
