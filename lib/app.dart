import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_pages.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppPages.generateRoute,
        initialRoute: AppRoutes.auth,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
        ),
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!),
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
    );
  }
}
