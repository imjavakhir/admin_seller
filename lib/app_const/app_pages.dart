import 'package:admin_seller/app_const/app_page_animation.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/auth_feature/presentation/pages/auth_page.dart';
import 'package:admin_seller/features/seller/presentation/pages/add_client_page.dart';
import 'package:admin_seller/features/main_feature/presentation/pages/main_page.dart';
import 'package:admin_seller/features/seller/presentation/pages/notification_page.dart';

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
