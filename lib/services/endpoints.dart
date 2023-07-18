abstract class AppEndPoints {
  static const String testBaseUrl = 'http://64.226.90.160:9999';

  static const String baseUrl = testBaseUrl;

  // // real baseurl
  // static const String baseUrl = 'https://callcenter.backend4devs.uz';

  static const String loginApi = '$baseUrl/auth/login';

  static const String sellerApi = '$baseUrl/user/pick/?type=one';

  static const String sellersApi = '$baseUrl/user/pick/?type=all';

  static const String visitApi = '$baseUrl/visit';

  static const String userVisitsApi = '$baseUrl/user/visits';

  static const String userOnlineStatusApi = '$baseUrl/user/status';

  static const String userOnlineUnverifiedApi = '$baseUrl/user/seller/online';
  static const String userRatingApi = '$baseUrl/user/rating';
  static const String searchCustomerApi =
      '$baseUrl/customer/srch/?phone_number=';
}
