abstract class AppEndPoints {
  // static const String testBaseUrl = 'http://64.226.90.160:9999';
  //  static const String baseUrl = testBaseUrl;
  // static const String localTestUrl = 'http://192.168.1.140:9999';
  static const String mongoUrl = 'http://64.226.90.160:5555';
  static const String baseUrl = mongoUrl;

  // real baseurl
  // static const String baseUrl = 'https://callcenter.backend4devs.uz';
  static const String adminSellerVisits = '$baseUrl/new-notification';
  static const String adminSellerVisitsStored = '$baseUrl/stored-notification';
  static const String adminSellerVisitSellers = '$baseUrl/notification-sellers';
  static const String loginApi = '$baseUrl/auth/login';

  static const String sellerApi = '$baseUrl/user/pick/?type=one';
  static const String sellersApi = '$baseUrl/v2/free-sellers';
  // static const String sellersApi = '$baseUrl/user/pick/?type=all';

  static const String visitApi = '$baseUrl/visit';

  static const String userVisitsApi = '$baseUrl/new-notifications';

  // static const String userVisitsApi = '$baseUrl/user/visits';
  static const String userOnlineStatusApi = '$baseUrl/v2/get-profile';
  static const String userOnlineStatusUpdateApi = '$baseUrl/v2/update-status';
  static const String userOnlineVerify = '$baseUrl/v2/verify-user';
  // static const String userOnlineStatusApi = '$baseUrl/user/status';

  static const String userOnlineUnverifiedApi =
      '$baseUrl/v2/get-sellers-status';
  // static const String userOnlineUnverifiedApi = '$baseUrl/user/seller/online';
  static const String userRatingApi = '$baseUrl/user/rating';
  static const String searchCustomerApi =
      '$baseUrl/customer/srch/?phone_number=';
}
