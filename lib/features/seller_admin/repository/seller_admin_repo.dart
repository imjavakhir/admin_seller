import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/models/seller_model/sellers_model.dart';
import 'package:admin_seller/services/dio_exceptions.dart';
import 'package:admin_seller/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerAdminRepository {
  Dio? _dio;

  SellerAdminRepository() {
    final options = BaseOptions(
        contentType: 'application/json',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000));
    _dio = Dio(options);
  }

  Future<List<Sellers?>> getSellers() async {
    final token = await AuthLocalDataSource().getLogToken();
    List<Sellers?> sellersModel = [];
    try {
      Response response = await _dio!.get(AppEndPoints.sellersApi,
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
    return sellersModel;
  }

  Future<Sellers?> getSeller() async {
    final token = await AuthLocalDataSource().getLogToken();
    Sellers? sellerModel;
    try {
      Response response = await _dio!.get(AppEndPoints.sellerApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        sellerModel = Sellers.fromJson(response.data);
        print('-----------------success-------${sellerModel.fullname}');
        return sellerModel;
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
    return sellerModel;
  }
}
