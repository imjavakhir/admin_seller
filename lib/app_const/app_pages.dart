import 'package:admin_seller/features/seller/presentation/pages/receipt_page.dart';
import 'package:admin_seller/features/seller/presentation/pages/update_payment.dart';

import 'app_exports.dart';

abstract class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.main:
        return PageAnimation.animatedPageRoute(settings, const MainPage());
      case AppRoutes.auth:
        return PageAnimation.animatedPageRoute(settings, AuthPage());
      case AppRoutes.addClient:
        return PageAnimation.animatedPageRoute(settings, AddClientpage());
      case AppRoutes.updateOrder:
        return PageAnimation.animatedPageRoute(
            settings, const UpdateOrderPage());

      // case AppRoutes.share:
      //   return PageAnimation.animatedPageRoute(settings, const SharePage());
      case AppRoutes.notification:
        return PageAnimation.animatedPageRoute(
            settings, const NotificationPage());
      case AppRoutes.adminclients:
        return PageAnimation.animatedPageRoute(
            settings, const AdminClientsPage());
      case AppRoutes.orders:
        return PageAnimation.animatedPageRoute(settings, const OrdersPage());
      case AppRoutes.acceptOrder:
        return PageAnimation.animatedPageRoute(
            settings, const AcceptOrderPage());
      case AppRoutes.addOrder:
        return PageAnimation.animatedPageRoute(settings, const AddOrderPage());
      case AppRoutes.checkOrder:
        return PageAnimation.animatedPageRoute(
            settings,  CheckOrderPage());
      // case AppRoutes.paymentOrder:
      //   return PageAnimation.animatedPageRoute(
      //       settings, const PaymentOrderPage());
      case AppRoutes.sellingWarehouse:
        return PageAnimation.animatedPageRoute(
            settings, const SellingWareHouse());
      case AppRoutes.addPayment:
        return PageAnimation.animatedPageRoute(
            settings, const AddPaymentPage());
      case AppRoutes.updatePayment:
        return PageAnimation.animatedPageRoute(
            settings, const UpdatePaymentPage());
      case AppRoutes.receipt:
        return PageAnimation.animatedPageRoute(settings, const ReceiptPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: Text(
                        'Пожалуйста, перезапустите приложение',
                        textAlign: TextAlign.center,
                        style: Styles.headline1,
                      ),
                    ),
                  ),
                ));
    }
  }
}
