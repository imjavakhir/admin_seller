import 'package:admin_seller/features/auth_feature/data/models/user_model.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/models/seller_model/sellers_model.dart';
import 'package:dio/dio.dart';

class LoginService {
  final dio = Dio(BaseOptions(
    contentType: 'application/json',
    connectTimeout: const Duration(milliseconds: 10000),
    receiveTimeout: const Duration(milliseconds: 10000),
  ));
  final loginApi = 'http://64.226.90.160:3000/auth/login';
  final sellerApi = 'http://64.226.90.160:3000/user/pick/?type=one';
  final sellersApi = 'http://64.226.90.160:3000/user/pick/?type=all';

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

  Future<Sellers?> getSeller() async {
    final token = await AuthLocalDataSource().getLogToken();
    Sellers? sellerModel;
    try {
      Response response = await dio.get(sellerApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        sellerModel = Sellers.fromJson(response.data);
        print('-----------------success');
        return sellerModel;
      }
    } catch (error) {
      print('seller ---------------------------------------$error');
    }
    return sellerModel;
  }

  Future<List<Sellers?>> getSellers() async {
    final token = await AuthLocalDataSource().getLogToken();
    List<Sellers?> sellersModel = [];
    try {
      Response response = await dio.get(sellersApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        sellersModel = sellerFromJson(response.data);
        print('-----------------success ------ ${response.data}');
        return sellersModel;
      }
    } catch (error) {
      print('sellers ---------------------------------------$error');
    }
    return sellersModel;
  }
}

abstract class AppApis {
  static const String baseUrl = 'http://64.226.90.160:3000/';
  static const String authUrl = 'http://64.226.90.160:3000/auth/login';
}
