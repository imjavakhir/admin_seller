import 'package:admin_seller/features/accept_online/data/models/user_unverified_model.dart';
import 'package:admin_seller/features/auth_feature/data/models/user_model.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/models/search_customer/search_customer.dart';
import 'package:admin_seller/features/main_feature/data/models/seller_model/sellers_model.dart';
import 'package:admin_seller/features/main_feature/data/models/selling/empty_selling.dart';
import 'package:admin_seller/features/main_feature/data/models/selling/not_sold_selling.dart';
import 'package:admin_seller/features/main_feature/data/models/selling/sold_selling.dart';
import 'package:admin_seller/features/profile/data/models/user_online_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio(BaseOptions(
    contentType: 'application/json',
    connectTimeout: const Duration(milliseconds: 25000),
    receiveTimeout: const Duration(milliseconds: 25000),
  ));
  final loginApi = 'http://64.226.90.160:3000/auth/login';
  final sellerApi = 'http://64.226.90.160:3000/user/pick/?type=one';
  final sellersApi = 'http://64.226.90.160:3000/user/pick/?type=all';
  final visitApi = 'http://64.226.90.160:3000/visit';
  final userOnlineStatusApi = 'http://64.226.90.160:3000/user/status';
  final userOnlineUnverifiedApi =
      'http://64.226.90.160:3000/user/seller/online';

  final searchCustomerApi =
      'http://64.226.90.160:3000/customer/search/?phone_number=';

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
        print('-----------------success');
        return userModel;
      }
    } catch (error) {
      print('848484 ---------------------------------------$error');
    }
    return userModel;
  }

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
        print('-----------------success');
        return sellerModel;
      }
    } catch (error) {
      print('seller ---------------------------------------$error');
    }
    return sellerModel;
  }

  Future<List<SearchedCustomer?>> getSearchedCustomer(
      {required String searchNumber}) async {
    final token = await AuthLocalDataSource().getLogToken();
    List<SearchedCustomer?> searchedCustomer = [];
    try {
      Response response = await dio.get(searchCustomerApi + searchNumber,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        searchedCustomer = searchedCustomerFromJson(response.data);
        print('-----------------success $searchedCustomer');
        return searchedCustomer;
      }
    } catch (error) {
      print('searchedCustomer ---------------------------------------$error');
    }
    return searchedCustomer;
  }

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
        print('-----------------success ------ ${response.data}');
        return sellersModel;
      }
    } catch (error) {
      print('sellers ---------------------------------------$error');
    }
    return sellersModel;
  }

//emopty selling

  Future<EmptySelling?> sendEmptySelling() async {
    final data = {
      "details": "",
      "phone_number": "",
      "fullname": "",
      "is_empty": true,
      "is_sold": false,
      "selling_price": 0
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
        print('-----------------success-----${emptySelling.branch}');
        return emptySelling;
      }
    } catch (error) {
      print('848484 ---------------------------------------$error-------');
    }
    return emptySelling;
  }

  Future<SoldSelling?> sendSoldSelling({
    required String details,
    required String fullName,
    required String phoneNumber,
    required double price,
  }) async {
    final data = {
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
        print('-----------------success-----${soldSelling.sellingPrice}');
        return soldSelling;
      }
    } catch (error) {
      print('848484 ---------------------------------------$error-------');
    }
    return soldSelling;
  }

  Future<NotSoldSelling?> sendNotSoldSelling(
      {required String details,
      required String fullName,
      required String phoneNumber}) async {
    final data = {
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
        print('-----------------success-----${notSoldSelling.isSold}');
        return notSoldSelling;
      }
    } catch (error) {
      print('848484 ---------------------------------------$error-------');
    }
    return notSoldSelling;
  }

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
        print('-----------------success-----${userOnlineModel.isOnline}');
        return userOnlineModel;
      }
    } catch (error) {
      print('---------------------------------------$error-------');
    }
    return userOnlineModel;
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
      Response response = await dio.put(userOnlineStatusApi,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        userOnlineModel = UserOnlineModel.fromJson(response.data);
        print(
            'after put-----------------success-----${userOnlineModel.isOnline}');
        return userOnlineModel;
      }
    } catch (error) {
      print('---------------------------------------$error-------');
    }
    return userOnlineModel;
  }

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
        print(
            'verified-----------------success-----${userOnlineModel.isVerified}---${userOnlineModel.id}');
        return userOnlineModel;
      }
    } catch (error) {
      print('---------------------------------------$error-------');
    }
    return userOnlineModel;
  }

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
        print(
            'unverified-----------------success-----${userUnverified.first!.id}');
        return userUnverified;
      }
    } catch (error) {
      print('---------------------------------------$error-------');
    }
    return userUnverified;
  }
}

abstract class AppApis {
  static const String baseUrl = 'http://64.226.90.160:3000/';
  static const String authUrl = 'http://64.226.90.160:3000/auth/login';
}
