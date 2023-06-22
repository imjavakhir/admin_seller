import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/accept_online/data/models/user_unverified_model.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/profile/data/models/user_online_model.dart';
import 'package:admin_seller/services/dio_exceptions.dart';
import 'package:admin_seller/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AcceptOnlineRepository {
  Dio? _dio;

  AcceptOnlineRepository() {
    final options = BaseOptions(
        contentType: 'application/json',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000));
    _dio = Dio(options);
  }

  Future<UserOnlineModel?> verifyUser({required String seller}) async {
    final token = await AuthLocalDataSource().getLogToken();
    UserOnlineModel? userOnlineModel;
    final data = {"is_online": true, "is_verified": true, "seller": seller};
    try {
      Response response = await _dio!.put(AppEndPoints.userOnlineStatusApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        userOnlineModel = UserOnlineModel.fromJson(response.data);
        Fluttertoast.showToast(
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.TOP,
            msg: 'Успешно',
            textColor: AppColors.white,
            fontSize: 16,
            backgroundColor: AppColors.grey);
        print(
            'verified-----------------success-----${userOnlineModel.isVerified}---${userOnlineModel.id}');
        return userOnlineModel;
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
      print('---------------------------------------$error-------');
    }
    return userOnlineModel;
  }

  Future<List<UserUnverified?>> getAllUnverified() async {
    final token = await AuthLocalDataSource().getLogToken();
    List<UserUnverified?> userUnverified = [];

    try {
      Response response = await _dio!.get(AppEndPoints.userOnlineUnverifiedApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        userUnverified = userUnverifiedFromJson(response.data);
        print('unverified-----------------success-----}');
        return userUnverified;
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
      print('---------------------------------------$error-------');
    }
    return userUnverified;
  }
}
