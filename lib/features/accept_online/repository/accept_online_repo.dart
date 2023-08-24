import 'package:admin_seller/app_const/app_exports.dart';

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

  Future<UserUnverified?> verifyUser({required String seller}) async {
    final token = await AuthLocalDataSource().getLogToken();
    UserUnverified? userUnverified;
    final data = {"user": seller, "is_verified": true};
    try {
      Response response = await _dio!.put(AppEndPoints.userOnlineVerify,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        userUnverified = UserUnverified.fromJson(response.data);
        Fluttertoast.showToast(
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.CENTER,
            msg: 'Успешно',
            textColor: AppColors.white,
            fontSize: 16,
            backgroundColor: AppColors.grey);
        debugPrint(
            'verified-----------------success-----${userUnverified.isVerified}---${userUnverified.user}');
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
      debugPrint('---------------------------------------$error-------');
    }
    return userUnverified;
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
        debugPrint(
            'unverified-----------------success-----${userUnverified.length} }');
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
      debugPrint('---------------------------------------$error-------');
    }
    return userUnverified;
  }
}
