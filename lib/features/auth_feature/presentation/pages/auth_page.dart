// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:admin_seller/app_const/app_colors.dart';
import 'package:admin_seller/app_const/app_routes.dart';
import 'package:admin_seller/features/auth_feature/data/models/user_model.dart';
import 'package:admin_seller/features/auth_feature/presentation/blocs/auth_bloc.dart';
import 'package:admin_seller/features/main_feature/data/data_src/hive_local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/services/login_service.dart';
import 'package:admin_seller/src/widgets/longbutton.dart';
import 'package:admin_seller/src/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:admin_seller/src/theme/text_styles.dart';

late bool isAdmin;
bool isLoading = false;

class AuthPage extends StatelessWidget {
  final LoginService _loginService = LoginService();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Логин',
                      style: Styles.headline1,
                    ),
                    ScreenUtil().setVerticalSpacing(45.h),
                    TextfieldWidget(
                      textEditingController: _phoneController,
                      textInputType: TextInputType.phone,
                      hintext: 'Phone number',
                    ),
                    ScreenUtil().setVerticalSpacing(28.h),
                    TextfieldWidget(
                      hintext: 'Password',
                      obsecure: state.obscureText,
                      textEditingController: _passwordController,
                      isPasswordField: true,
                      eyeTap: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(EyeIconPressed());
                      },
                    ),
                    ScreenUtil().setVerticalSpacing(10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      child: Row(
                        children: [
                          CupertinoSwitch(
                              activeColor: AppColors.primaryColor,
                              value: state.isAdmin,
                              onChanged: (value) {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(ChangePriority(priority: value));
                              }),
                          ScreenUtil().setHorizontalSpacing(10.w),
                          Text(
                            state.isAdmin ? 'Admin' : 'Seller',
                            style: Styles.headline3M,
                          )
                        ],
                      ),
                    )
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
                  isAdmin = state.isAdmin;
                  final role = isAdmin ? 'seller_admin' : 'seller';
                  setState(() {
                    isLoading = true;
                  });
                  final fcmLocal = await AuthLocalDataSource().getFcmToken();
                  UserModel? userModel;
                  if (isLoading) {
                    userModel = await _loginService.login(
                      phoneNumber: _phoneController.text,
                      password: _passwordController.text,
                      role: role,
                      fireBaseToken: fcmLocal!,
                    );
                    if (userModel != null) {
                      print('TOKEN--------${userModel.token}');
                      await AuthLocalDataSource().saveLogToken(userModel.token);
                      HiveDataSource().saveUserDetails(
                          branch: userModel.branch,
                          fullName: userModel.fullname,
                          type: userModel.type);
                   

                      Navigator.of(context).pushNamed(AppRoutes.main);
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      (showDialog(
                          context: context,
                          builder: (_) => const Dialog(
                                child: Text('error'),
                              )));
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
                buttonName: 'Войти',
              );
            }),
          );
        },
      ),
    );
  }
}