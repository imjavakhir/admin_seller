import 'package:admin_seller/app_const/app_exports.dart';

class ProfileRepository {
  Dio? _dio;

  ProfileRepository() {
    final options = BaseOptions(
        contentType: 'application/json',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000));
    _dio = Dio(options);
  }

  Future<UserOnlineModel?> changeUserOnlineInfo(
      {required bool isOnline}) async {
    final token = await AuthLocalDataSource().getLogToken();
    UserOnlineModel? userOnlineModel;
    final data = {
      "is_online": isOnline,
      "is_paused": false,
    };
    try {
      Response response =
          await _dio!.put(AppEndPoints.userOnlineStatusUpdateApi,
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
            msg: 'Запрос на подтверждение отправлено',
            textColor: AppColors.white,
            fontSize: 16,
            backgroundColor: AppColors.grey);
        debugPrint(
            'after put-----------------success-----${userOnlineModel.isVerified}===========');
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
      debugPrint('---------------------------------------$error-------');
    }
    return userOnlineModel;
  }

  Future<UserProfileModel?> getUserOnlineInfo() async {
    final token = await AuthLocalDataSource().getLogToken();
    UserProfileModel? userOnlineModel;
    try {
      Response response = await _dio!.get(AppEndPoints.userOnlineStatusApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        userOnlineModel = UserProfileModel.fromJson(response.data);
        debugPrint(
            '-----------------success-----${userOnlineModel.user!.phoneNumber!}=============');
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

      debugPrint('hahah------------------------------------$error-------');
    }
    return userOnlineModel;
  }
}
