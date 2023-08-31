import 'package:admin_seller/app_const/app_exports.dart';



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
            create: (context) => SellingBloc(),
          ),
          BlocProvider(
            create: (context) => MainFeatureBloc(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(TextEditingController(),
                TextEditingController(), GlobalKey<FormState>()),
          ),
          BlocProvider(
            create: (context) =>
                AcceptOnlineBloc()..add(GetUsersUnverifiedEvent()),
          ),
          BlocProvider(
            create: (context) => SellerBloc(SocketServiceImpl()),
          ),
          BlocProvider(
            create: (context) => SellerAdminBloc(),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('ru', 'RU'),
          supportedLocales: const [
            Locale('ru', 'RU'),
            Locale('en', 'US'),
            Locale('uz', 'UZ')
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppPages.generateRoute,
          initialRoute: savedToken == null ? AppRoutes.auth : AppRoutes.main,
          theme: ThemeData(
              timePickerTheme: TimePickerThemeData(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r))),
              scaffoldBackgroundColor: AppColors.white,
              colorScheme: ColorScheme.fromSwatch(accentColor: Colors.white)),
          builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: 1.0, alwaysUse24HourFormat: true),
              child: child!),
        ),
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
    );
  }
}


