import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_pages.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/accept_online/presentation/blocs/blocs/accept_online_bloc.dart';
import 'package:admin_seller/features/auth_feature/presentation/blocs/auth_bloc.dart';
import 'package:admin_seller/features/main_feature/presentation/blocs/main_feature_bloc.dart';
import 'package:admin_seller/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final String? savedToken;
  const MyApp({super.key, required this.savedToken});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider(
            create: (context) => MainFeatureBloc(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
           BlocProvider(
            create: (context) => AcceptOnlineBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppPages.generateRoute,
          initialRoute: savedToken == null ? AppRoutes.auth : AppRoutes.main,
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              colorScheme: ColorScheme.fromSwatch(accentColor: Colors.white)),
          builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!),
        ),
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
    );
  }
}
