import 'package:admin_seller/app_const/app_exports.dart';

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
  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJiZGEyYzMzLWVkZGUtNDkxMy1hYzVlLWRlYTcwMjVhNGViZSIsImlhdCI6MTY5MjEwMjMwOX0.HG9UShebI69tCZ4wGAsx7lc7XMHtRi5hxwRfu8Q8zy8';
  Future<SellingWarehouseModel?> getWarehouseProducts(
      String size, String page, String searchItem) async {
    SellingWarehouseModel? sellingWarehouseModel;

    try {
      Response response = await _dio!.get(
          "${ApiSelling.warehouseProducts}?page=$page&limit=$size&search=$searchItem",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        sellingWarehouseModel = SellingWarehouseModel.fromJson(response.data);
        debugPrint(sellingWarehouseModel.products!.length.toString());
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

  Future<List<SellingMyOrders?>> getSellingMyOrders() async {
    List<SellingMyOrders?> sellingMyOrders = [];

    try {
      Response response = await _dio!.get(ApiSelling.sellingMyOrders,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        sellingMyOrders = sellingMyOrdersFromJson(response.data);
        debugPrint(sellingMyOrders.first!.client!.name!);
        // debugPrint("${clientInfoList.first!.sentAt!}-------------");
        return sellingMyOrders;
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
    return sellingMyOrders;
  }

  Future<BookedSeller?> getBookedSeller(String sellerId) async {
    BookedSeller? bookedSeller;

    try {
      debugPrint(sellerId);
      Response response =
          await _dio!.get('${ApiSelling.bookedSeller}/$sellerId',
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        bookedSeller = BookedSeller.fromJson(response.data);
        debugPrint(bookedSeller.name!);
        // debugPrint("${clientInfoList.first!.sentAt!}-------------");
        return bookedSeller;
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
    return bookedSeller;
  }

  Future<void> bookWareHouseProduct(DateTime dateTime, String id) async {
    final data = {'end_date': dateTime.toIso8601String()};
    try {
      Response response = await _dio!.put("${ApiSelling.bookOrder}/$id",
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.data);
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
  }

  Future<void> unbookWareHouseProduct(String id) async {
    try {
      Response response = await _dio!.put("${ApiSelling.unbookOrder}/$id",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.data);
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
  }

  Future<List<FurnitureModelTypeModel?>> searchFurnitureModel(
      String searchText) async {
    List<FurnitureModelTypeModel?> furnitureModelList = [];

    try {
      Response response =
          await _dio!.get("${ApiSelling.searchFurnitureModel}?name=$searchText",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        furnitureModelList = furnitureModelTypeModelFromJson(response.data);
        if (furnitureModelList.isNotEmpty) {
          debugPrint(furnitureModelList.first!.name!);
        }
        return furnitureModelList;
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
      return furnitureModelList;
    }
    return furnitureModelList;
  }

  Future<String> sellingGetId() async {
    String id = '';

    try {
      Response response = await _dio!.get(ApiSelling.sellingGetId,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        id = (response.data);
        debugPrint(id);
        return id;
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
      return id;
    }
    return id;
  }
}

class ApiSelling {
  static const baseUrl = 'http://64.226.90.160:3005';
  static const warehouseProducts =
      '$baseUrl/warehouse-products-search-with-seller';
  static const searchFurnitureModel = '$baseUrl/search-model';
  static const bookOrder = '$baseUrl/booked-order';
  static const unbookOrder = '$baseUrl/unbooked-order';
  static const sellingMyOrders = '$baseUrl/seller-orders';
  static const sellingGetId = "$baseUrl/getId";
  static const bookedSeller = '$baseUrl/get-seller';
}

BookedSeller bookedSellerFromJson(String str) =>
    BookedSeller.fromJson(json.decode(str));

String bookedSellerToJson(BookedSeller data) => json.encode(data.toJson());

class BookedSeller {
  final String? name;
  final String? phone;

  BookedSeller({
    this.name,
    this.phone,
  });

  factory BookedSeller.fromJson(Map<String, dynamic> json) => BookedSeller(
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
      };
}
