import 'package:admin_seller/app_const/app_exports.dart';

bool isLoading = false;

class AuthPage extends StatelessWidget {
  // final ApiService _loginService = ApiService();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKeyPhone = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();
  final AuthRepository _authRepository = AuthRepository();

  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return false;
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: const AppBarWidget(title: ''),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 36.w),
                        child: Text(
                          state.isAdmin
                              ? 'Вы авторизуетесь как администратор'
                              : 'Вы авторизуетесь как продавец',
                          style: Styles.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(45.h),
                      Form(
                        key: formKeyPhone,
                        child: TextfieldWidget(
                          valueChanged: (value) {
                            formKeyPhone.currentState!.validate();
                          },
                          validator: Validators.phoneNumber,
                          listFormater: [MaskFormat.mask],
                          isPhoneNumber: true,
                          textEditingController: _phoneController,
                          textInputType: TextInputType.phone,
                          hintext: 'Phone number',
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(28.h),
                      Form(
                        key: formKeyPassword,
                        child: TextfieldWidget(
                          valueChanged: (value) {
                            formKeyPassword.currentState!.validate();
                          },
                          validator: Validators.password,
                          hintext: 'Password',
                          obsecure: state.obscureText,
                          textEditingController: _passwordController,
                          isPasswordField: true,
                          eyeTap: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(EyeIconPressed());
                          },
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(10.h),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 24.h),
                      //   child: Row(
                      //     children: [
                      //       CupertinoSwitch(
                      //           activeColor: AppColors.primaryColor,
                      //           value: state.isAdmin,
                      //           onChanged: (value) {
                      //             BlocProvider.of<AuthBloc>(context)
                      //                 .add(ChangePriority(priority: value));
                      //           }),
                      //       ScreenUtil().setHorizontalSpacing(10.w),
                      //       Text(
                      //         state.isAdmin ? 'Admin' : 'Seller',
                      //         style: Styles.headline3M,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      TextButton(
                          style: TextButton.styleFrom(
                              enableFeedback: false,
                              foregroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.r))),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(ChangePriority(priority: !state.isAdmin));
                          },
                          child: Text(
                            state.isAdmin ? 'Вы не админ?' : 'Вы админ?',
                            style: Styles.headline4,
                          )),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton:
                  StatefulBuilder(builder: (context, setState) {
                return LongButton(
                  isloading: isLoading,
                  onTap: () async {
                    final isValidatedPhone =
                        formKeyPhone.currentState!.validate();
                    final isValidatedPassword =
                        formKeyPassword.currentState!.validate();
                    if (isValidatedPhone && isValidatedPassword) {
                      final role = state.isAdmin ? 'seller_admin' : 'seller';
                      setState(() {
                        isLoading = true;
                      });
                      final fcmLocal =
                          await AuthLocalDataSource().getFcmToken();
                      UserModel? userModel;
                      if (isLoading) {
                        userModel = await _authRepository.login(
                          phoneNumber: MaskFormat.mask.getUnmaskedText(),
                          password: _passwordController.text,
                          role: role,
                          fireBaseToken: fcmLocal!,
                        );
                        debugPrint(MaskFormat.mask.getMaskedText());
                        if (userModel != null) {
                          debugPrint('TOKEN--------${userModel.token}');
                          await AuthLocalDataSource()
                              .saveLogToken(userModel.token);
                          await HiveDataSource().saveUserDetails(
                              branch: userModel.branch,
                              fullName: userModel.fullname,
                              type: userModel.type);

                          final user =
                              HiveDataSource().box.values.toList().first;

                          debugPrint(user.type);
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.main);

                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    }
                  },
                  buttonName: 'Войти',
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
