import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/models/selling/empty_selling.dart';
import 'package:admin_seller/features/main_feature/data/models/selling/not_sold_selling.dart';
import 'package:admin_seller/features/main_feature/data/models/selling/sold_selling.dart';
import 'package:admin_seller/features/profile/data/models/user_online_model.dart';
import 'package:admin_seller/features/seller/data/client_info_model.dart';
import 'package:admin_seller/services/dio_exceptions.dart';
import 'package:admin_seller/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerRepository {
  Dio? _dio;

  SellerRepository() {
    final options = BaseOptions(
        contentType: 'application/json',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000));
    _dio = Dio(options);
  }

  Future<List<ClientInfo?>> getAllUserVisits() async {
    final token = await AuthLocalDataSource().getLogToken();
    List<ClientInfo?> clientInfoList = [];

    try {
      Response response = await _dio!.get(AppEndPoints.userVisitsApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        clientInfoList = clientsInfoFromJson(response.data);

        return clientInfoList;
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
    return clientInfoList;
  }

  Future<UserOnlineModel?> changePause({required bool isPaused}) async {
    final token = await AuthLocalDataSource().getLogToken();
    UserOnlineModel? userOnlineModel;
    final data = {
      "is_online": true,
      "is_paused": isPaused,
    };
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
        print(
            'after put-----------------success-----${userOnlineModel.isPaused}');
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

  Future<EmptySelling?> sendEmptySelling({required String id, required bool report}) async {
    final data = {"notification": id, "is_empty": true, "report": report};
    final token = await AuthLocalDataSource().getLogToken();
    EmptySelling? emptySelling;
    try {
      Response response = await _dio!.post(AppEndPoints.visitApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        emptySelling = EmptySelling.fromJson(response.data);
        Fluttertoast.showToast(
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.CENTER,
            msg: 'Успешно',
            textColor: AppColors.white,
            fontSize: 16,
            backgroundColor: AppColors.grey);
        print('-----------------success-----${emptySelling.branch}');
        return emptySelling;
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
    return emptySelling;
  }

  Future<NotSoldSelling?> sendNotSoldSelling(
      {required String details,
      required String fullName,
      required String phoneNumber,
      required String id,
      required String? whereFrom,
      required bool? report}) async {
    final data = {
      "notification": id,
      "where_come_from": whereFrom,
      "details": details,
      "phone_number": phoneNumber,
      "fullname": fullName,
      "is_empty": false,
      "is_sold": false,
      "selling_price": 0,
      "report": report
    };
    final token = await AuthLocalDataSource().getLogToken();
    NotSoldSelling? notSoldSelling;
    try {
      Response response = await _dio!.post(AppEndPoints.visitApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        notSoldSelling = NotSoldSelling.fromJson(response.data);
        Fluttertoast.showToast(
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.CENTER,
            msg: 'Успешно',
            textColor: AppColors.white,
            fontSize: 16,
            backgroundColor: AppColors.grey);
        print('-----------------success-----${notSoldSelling.isSold}');
        return notSoldSelling;
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
    return notSoldSelling;
  }

  Future<SoldSelling?> sendSoldSelling(
      {required String details,
      required String fullName,
      required String phoneNumber,
      required double price,
      required String id,
      required String? whereFrom,
      required bool? report}) async {
    final data = {
      "notification": id,
      "where_come_from": whereFrom,
      "details": details,
      "phone_number": phoneNumber,
      "fullname": fullName,
      "is_empty": false,
      "is_sold": true,
      "selling_price": price,
      "report": report
    };
    final token = await AuthLocalDataSource().getLogToken();
    SoldSelling? soldSelling;
    try {
      Response response = await _dio!.post(AppEndPoints.visitApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        soldSelling = SoldSelling.fromJson(response.data);
        Fluttertoast.showToast(
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.CENTER,
            msg: 'Успешно',
            textColor: AppColors.white,
            fontSize: 16,
            backgroundColor: AppColors.grey);
        print('-----------------success-----${soldSelling.sellingPrice}');
        return soldSelling;
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
    return soldSelling;
  }
}
