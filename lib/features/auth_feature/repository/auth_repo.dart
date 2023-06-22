import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/auth_feature/data/models/user_model.dart';
import 'package:admin_seller/services/dio_exceptions.dart';
import 'package:admin_seller/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthRepository {
  Dio? _dio;

  AuthRepository() {
    final options = BaseOptions(
        contentType: 'application/json',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000));
    _dio = Dio(options);
  }

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
      Response response = await _dio!.post(AppEndPoints.loginApi, data: data);
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(response.data);
        print('-----------------success');
        return userModel;
      }
    } on DioError catch (error) {
      final errorMessage = DioExceptions.fromDioError(error);
      Fluttertoast.showToast(
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.TOP,
          msg: errorMessage.toString(),
          textColor: AppColors.white,
          fontSize: 16,
          backgroundColor: AppColors.grey);
      print('---------------------------------------$errorMessage');
    }
    return userModel;
  }
}
