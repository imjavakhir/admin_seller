abstract class AppEndPoints {
  static const String baseUrl = 'http://64.226.90.160:3000';

  static const String loginApi = '$baseUrl/auth/login';
  
  static const String sellerApi = '$baseUrl/user/pick/?type=one';
  
  static const String sellersApi = '$baseUrl/user/pick/?type=all';
  
  static const String visitApi = '$baseUrl/visit';
  
  static const String userVisitsApi = '$baseUrl/user/visits';
  
  static const String userOnlineStatusApi = '$baseUrl/user/status';
  
  static const String userOnlineUnverifiedApi = '$baseUrl/user/seller/online';
  
  static const String searchCustomerApi =
      '$baseUrl/customer/search/?phone_number=';
}
