import 'package:admin_seller/app_const/app_exports.dart';

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
        // debugPrint("${clientInfoList.first!.sentAt!}-------------");
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
        debugPrint(
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
      debugPrint('---------------------------------------$error-------');
    }
    return userOnlineModel;
  }

  Future<EmptySelling?> sendEmptySelling(
      {required String id,
      required bool report,
      required String sharedId}) async {
    final data = {
      "notification": id,
      "is_empty": true,
      "report": report,
      "shared_seller": sharedId
    };
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
        debugPrint('-----------------success-----${emptySelling.branch}');
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
      debugPrint('---------------------------------------$error-------');
    }
    return emptySelling;
  }

  Future<NotSoldSelling?> sendNotSoldSelling(
      {required String details,
      required String fullName,
      required String phoneNumber,
      required String id,
      required String? whereFrom,
      required String? sharedid,
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
      "report": report,
      "shared_seller": sharedid
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
        debugPrint('-----------------success-----${notSoldSelling.isSold}');
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
      debugPrint('---------------------------------------$error-------');
    }
    return notSoldSelling;
  }

  Future<SoldSelling?> sendSoldSelling(
      {required String details,
      required String fullName,
      required String? sharedid,
      required String phoneNumber,
      required double price,
      required String id,
      required String? whereFrom,
      required bool? report}) async {
    final data = {
      "report": report,
      "shared_seller": sharedid,
      "notification": id,
      "where_come_from": whereFrom,
      "details": details,
      "phone_number": phoneNumber,
      "fullname": fullName,
      "is_empty": false,
      "is_sold": true,
      "selling_price": price,
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
        debugPrint('-----------------success-----${soldSelling.sellingPrice}');
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
      debugPrint('---------------------------------------$error-------');
    }
    return soldSelling;
  }

  Future<List<SearchedCustomers?>> getSearchedCustomer(
      {required String searchNumber}) async {
    final token = await AuthLocalDataSource().getLogToken();
    List<SearchedCustomers?> searchedCustomers = [];
    try {
      Response response =
          await _dio!.get(AppEndPoints.searchCustomerApi + searchNumber,
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              }));
      if (response.statusCode == 200) {
        searchedCustomers = searchedCustomersFromJson(response.data);
        debugPrint('-----------------success $searchedCustomers');
        return searchedCustomers;
      }
    } catch (error) {
      debugPrint('searchedCustomer ---------------------------------------$error');
    }
    return searchedCustomers;
  }
}
