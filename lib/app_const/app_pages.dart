import 'package:admin_seller/app_const/app_page_animation.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/auth_feature/presentation/pages/auth_page.dart';
import 'package:admin_seller/features/seller/presentation/pages/add_client_page.dart';
import 'package:admin_seller/features/main_feature/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';

abstract class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.main:
        return PageAnimation.animatedPageRoute(settings, const MainPage());
      case AppRoutes.auth:
        return PageAnimation.animatedPageRoute(settings, AuthPage());
      case AppRoutes.addClient:
        return PageAnimation.animatedPageRoute(settings, AddClientpage());

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
