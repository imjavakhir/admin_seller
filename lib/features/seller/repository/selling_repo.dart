import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/features/seller/data/selling_data/selling_warehouse_model.dart';
import 'package:admin_seller/services/dio_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';

class SellingRepository {
  Dio? _dio;

  SellingRepository() {
    final options = BaseOptions(
        contentType: 'application/json',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000));
    _dio = Dio(options);
  }

  Future<SellingWarehouseModel?> getWarehouseProducts(
      String size, String page, String searchItem) async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJiZGEyYzMzLWVkZGUtNDkxMy1hYzVlLWRlYTcwMjVhNGViZSIsImlhdCI6MTY5MjEwMjMwOX0.HG9UShebI69tCZ4wGAsx7lc7XMHtRi5hxwRfu8Q8zy8';
    SellingWarehouseModel? sellingWarehouseModel;

    try {
      Response response = await _dio!.get(
          "${ApiSelling.warehouseProducts}?page=$page&limit=$size&search=$searchItem",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        sellingWarehouseModel = SellingWarehouseModel.fromJson(response.data);
        debugPrint(response.data.toString());
        // debugPrint("${clientInfoList.first!.sentAt!}-------------");
        return sellingWarehouseModel;
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
    return sellingWarehouseModel;
  }
}

class ApiSelling {
  static const warehouseProducts =
      'http://64.226.90.160:3005/warehouse-products-search-with-seller';
}
