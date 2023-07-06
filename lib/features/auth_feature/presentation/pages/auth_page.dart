// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/auth_feature/data/models/user_model.dart';
import 'package:admin_seller/features/auth_feature/presentation/blocs/auth_bloc.dart';
import 'package:admin_seller/features/auth_feature/repository/auth_repo.dart';
import 'package:admin_seller/features/main_feature/data/data_src/hive_local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/src/decoration/input_text_mask.dart';
import 'package:admin_seller/src/validators/validators.dart';
import 'package:admin_seller/src/widgets/appbar_widget.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/src/theme/text_styles.dart';

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
        return GestureDetector(
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
            floatingActionButton: StatefulBuilder(builder: (context, setState) {
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
                    final fcmLocal = await AuthLocalDataSource().getFcmToken();
                    UserModel? userModel;
                    if (isLoading) {
                      userModel = await _authRepository.login(
                        phoneNumber: MaskFormat.mask.getUnmaskedText(),
                        password: _passwordController.text,
                        role: role,
                        fireBaseToken: fcmLocal!,
                      );
                      print(MaskFormat.mask.getMaskedText());
                      if (userModel != null) {
                        print('TOKEN--------${userModel.token}');
                        await AuthLocalDataSource()
                            .saveLogToken(userModel.token);
                        await HiveDataSource().saveUserDetails(
                            branch: userModel.branch,
                            fullName: userModel.fullname,
                            type: userModel.type);

                        final user = HiveDataSource().box.values.toList().first;

                        print(user.type);
                        Navigator.of(context).pushNamed(AppRoutes.main);

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
        );
      },
    );
  }
}
