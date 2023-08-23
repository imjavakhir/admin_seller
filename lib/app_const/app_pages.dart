import 'package:admin_seller/app_const/app_page_animation.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/auth_feature/presentation/pages/auth_page.dart';
import 'package:admin_seller/features/main_feature/presentation/pages/main_page.dart';
import 'package:admin_seller/features/seller/presentation/pages/accept_order.dart';
import 'package:admin_seller/features/seller/presentation/pages/add_client_page.dart';
import 'package:admin_seller/features/seller/presentation/pages/add_order.dart';
import 'package:admin_seller/features/seller/presentation/pages/add_payment.dart';
import 'package:admin_seller/features/seller/presentation/pages/check_order.dart';
import 'package:admin_seller/features/seller/presentation/pages/notification_page.dart';
import 'package:admin_seller/features/seller/presentation/pages/orders_page.dart';
import 'package:admin_seller/features/seller/presentation/pages/payment_order.dart';
import 'package:admin_seller/features/seller/presentation/pages/selling_warehouse.dart';
import 'package:admin_seller/features/seller_admin/presentation/pages/admin_clients.dart';
import 'package:admin_seller/src/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.main:
        return PageAnimation.animatedPageRoute(settings, const MainPage());
      case AppRoutes.auth:
        return PageAnimation.animatedPageRoute(settings, AuthPage());
      case AppRoutes.addClient:
        return PageAnimation.animatedPageRoute(settings, AddClientpage());
     
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
            settings, const CheckOrderPage());
      case AppRoutes.paymentOrder:
        return PageAnimation.animatedPageRoute(
            settings, const PaymentOrderPage());
      case AppRoutes.sellingWarehouse:
        return PageAnimation.animatedPageRoute(
            settings, const SellingWareHouse());
      case AppRoutes.addPayment:
        return PageAnimation.animatedPageRoute(
            settings, const AddPaymentPage());

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
