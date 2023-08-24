import 'package:admin_seller/app_const/app_exports.dart';

class ApiService {
  final dio = Dio(BaseOptions(
      contentType: 'application/json',
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 10000)));
  final loginApi = 'http://64.226.90.160:3000/auth/login';
  final sellerApi = 'http://64.226.90.160:3000/user/pick/?type=one';
  final sellersApi = 'http://64.226.90.160:3000/user/pick/?type=all';
  final visitApi = 'http://64.226.90.160:3000/visit';
  final userVisitsApi = 'http://64.226.90.160:3000/user/visits';
  final userOnlineStatusApi = 'http://64.226.90.160:3000/user/status';
  final userOnlineUnverifiedApi =
      'http://64.226.90.160:3000/user/seller/online';

  final searchCustomerApi =
      'http://64.226.90.160:3000/customer/srch/?phone_number=';

//auth repo
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
        debugPrint('-----------------success');
        return userModel;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);

      debugPrint('---------------------------------------$errorMessage');
    }
    return userModel;
  }

//seller admin repo
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
        debugPrint('-----------------success');
        return sellerModel;
      }
    } catch (error) {
      debugPrint('seller ---------------------------------------$error');
    }
    return sellerModel;
  }

//seller repo
  Future<List<SearchedCustomers?>> getSearchedCustomer(
      {required String searchNumber}) async {
    final token = await AuthLocalDataSource().getLogToken();
    List<SearchedCustomers?> searchedCustomers = [];
    try {
      Response response = await dio.get(searchCustomerApi + searchNumber,
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

//seller admin repo
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
        debugPrint('-----------------success ------ ${response.data}');
        return sellersModel;
      }
    } catch (error) {
      debugPrint('sellers ---------------------------------------$error');
    }
    return sellersModel;
  }

//seller repo

  Future<EmptySelling?> sendEmptySelling({required String id}) async {
    final data = {
      "notification": id,
      "is_empty": true,
    };
    final token = await AuthLocalDataSource().getLogToken();
    EmptySelling? emptySelling;
    try {
      Response response = await dio.post(visitApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        emptySelling = EmptySelling.fromJson(response.data);
        debugPrint('-----------------success-----${emptySelling.branch}');
        return emptySelling;
      }
    } catch (error) {
      debugPrint('848484 ---------------------------------------$error-------');
    }
    return emptySelling;
  }

//seller repo
  Future<SoldSelling?> sendSoldSelling(
      {required String details,
      required String fullName,
      required String phoneNumber,
      required double price,
      required String id,
      required String whereFrom}) async {
    final data = {
      "notification": id,
      "where_come_from": whereFrom,
      "details": details,
      "phone_number": phoneNumber,
      "fullname": fullName,
      "is_empty": false,
      "is_sold": true,
      "selling_price": price
    };
    final token = await AuthLocalDataSource().getLogToken();
    SoldSelling? soldSelling;
    try {
      Response response = await dio.post(visitApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        soldSelling = SoldSelling.fromJson(response.data);
        debugPrint('-----------------success-----${soldSelling.sellingPrice}');
        return soldSelling;
      }
    } catch (error) {
      debugPrint(
          '${data['phone_number']} ---------------------------------------$error-------');
    }
    return soldSelling;
  }

//seller repo
  Future<NotSoldSelling?> sendNotSoldSelling(
      {required String details,
      required String fullName,
      required String phoneNumber,
      required String id,
      required String whereFrom}) async {
    final data = {
      "notification": id,
      "where_come_from": whereFrom,
      "details": details,
      "phone_number": phoneNumber,
      "fullname": fullName,
      "is_empty": false,
      "is_sold": false,
      "selling_price": 0
    };
    final token = await AuthLocalDataSource().getLogToken();
    NotSoldSelling? notSoldSelling;
    try {
      Response response = await dio.post(visitApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        notSoldSelling = NotSoldSelling.fromJson(response.data);
        debugPrint('-----------------success-----${notSoldSelling.isSold}');
        return notSoldSelling;
      }
    } catch (error) {
      debugPrint('848484 ---------------------------------------$error-------');
    }
    return notSoldSelling;
  }

//profile repo
  Future<UserOnlineModel?> getUserOnlineInfo() async {
    final token = await AuthLocalDataSource().getLogToken();
    UserOnlineModel? userOnlineModel;
    try {
      Response response = await dio.get(userOnlineStatusApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        userOnlineModel = UserOnlineModel.fromJson(response.data);
        debugPrint('-----------------success-----${userOnlineModel.isOnline}');
        return userOnlineModel;
      }
    } catch (error) {
      debugPrint('hahah------------------------------------$error-------');
    }
    return userOnlineModel;
  }

  //profile repo

  Future<UserOnlineModel?> changeUserOnlineInfo(
      {required bool isOnline}) async {
    final token = await AuthLocalDataSource().getLogToken();
    UserOnlineModel? userOnlineModel;
    final data = {
      "is_online": isOnline,
      "is_paused": false,
    };
    try {
      Response response = await dio.put(userOnlineStatusApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        userOnlineModel = UserOnlineModel.fromJson(response.data);
        debugPrint(
            'after put-----------------success-----${userOnlineModel.isOnline}');
        return userOnlineModel;
      }
    } catch (error) {
      debugPrint('---------------------------------------$error-------');
    }
    return userOnlineModel;
  }

//accept user online
  Future<UserOnlineModel?> verifyUser({required String seller}) async {
    final token = await AuthLocalDataSource().getLogToken();
    UserOnlineModel? userOnlineModel;
    final data = {"is_online": true, "is_verified": true, "seller": seller};
    try {
      Response response = await dio.put(userOnlineStatusApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        userOnlineModel = UserOnlineModel.fromJson(response.data);
        debugPrint(
            'verified-----------------success-----${userOnlineModel.isVerified}---${userOnlineModel.user}');
        return userOnlineModel;
      }
    } catch (error) {
      debugPrint('---------------------------------------$error-------');
    }
    return userOnlineModel;
  }

//accept user online
  Future<List<UserUnverified?>> getAllUnverified() async {
    final token = await AuthLocalDataSource().getLogToken();
    List<UserUnverified?> userUnverified = [];

    try {
      Response response = await dio.get(userOnlineUnverifiedApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        userUnverified = userUnverifiedFromJson(response.data);
        debugPrint(
            'unverified-----------------success-----${userUnverified.first!.user}');
        return userUnverified;
      }
    } catch (error) {
      debugPrint('---------------------------------------$error-------');
    }
    return userUnverified;
  }

//seller repo
  Future<UserOnlineModel?> changePause({required bool isPaused}) async {
    final token = await AuthLocalDataSource().getLogToken();
    UserOnlineModel? userOnlineModel;
    final data = {
      "is_online": true,
      "is_paused": isPaused,
    };
    try {
      Response response = await dio.put(userOnlineStatusApi,
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
    } catch (error) {
      debugPrint('---------------------------------------$error-------');
    }
    return userOnlineModel;
  }

//seller repo
  Future<List<ClientInfo?>> getAllUserVisits() async {
    final token = await AuthLocalDataSource().getLogToken();
    List<ClientInfo?> clientInfoList = [];

    try {
      Response response = await dio.get(userVisitsApi,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        clientInfoList = clientsInfoFromJson(response.data);
        debugPrint('visits-----------------success-----${clientInfoList.first!.id}');
        return clientInfoList;
      }
    } catch (error) {
      debugPrint('---------------------------------------$error-------');
    }
    return clientInfoList;
  }
}

abstract class AppApis {
  static const String baseUrl = 'http://64.226.90.160:3000/';
  static const String authUrl = 'http://64.226.90.160:3000/auth/login';
}
