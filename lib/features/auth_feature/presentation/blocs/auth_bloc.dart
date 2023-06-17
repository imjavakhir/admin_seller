import 'package:admin_seller/features/auth_feature/data/models/user_model.dart';
import 'package:admin_seller/features/main_feature/data/data_src/hive_local_data_src.dart';
import 'package:admin_seller/features/main_feature/data/data_src/local_data_src.dart';
import 'package:admin_seller/services/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._phoneController, this._passwordController, this._formKey)
      : super(const AuthState()) {
    on<LoginButtonPressed>(_onLoginPressed);
    on<EyeIconPressed>(_onEyeIconPressed);
    on<ChangePriority>(_onChangePriority);
    // on<DeleteToken>(_onDeleteToken);
  }
  final GlobalKey<FormState> _formKey;
  final ApiService _apiService = ApiService();
  final TextEditingController _phoneController;
  final TextEditingController _passwordController;
  GlobalKey get formKey => _formKey;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get passwordController => _passwordController;

  void _onEyeIconPressed(EyeIconPressed event, Emitter<AuthState> emit) {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  // _onDeleteToken(DeleteToken event, Emitter<AuthState> emit) async {
  //   final result = _repository.localDataSource.clearToken();
  //   print('-------------------$result');
  //   return result;
  // }
  Future<void> _onLoginPressed(
      LoginButtonPressed event, Emitter<AuthState> emit) async {
    final role = state.isAdmin ? 'seller_admin' : 'seller';
    final fcmLocal = await AuthLocalDataSource().getFcmToken();

    emit(state.copyWith(showLoginButtonLoading: true));
    UserModel? userModel;
    if (state.showLoginButtonLoading) {
      userModel = await _apiService.login(
        phoneNumber: _phoneController.text,
        password: _passwordController.text,
        role: role,
        fireBaseToken: fcmLocal!,
      );
    }
    if (userModel != null) {
      print('TOKEN--------${userModel.token}');
      await AuthLocalDataSource().saveLogToken(userModel.token);
      await HiveDataSource().saveUserDetails(
          branch: userModel.branch,
          fullName: userModel.fullname,
          type: userModel.type);

      final user = HiveDataSource().box.values.toList().first;

      print(user.type);

      emit(state.copyWith(showLoginButtonLoading: false, error: 'No'));
    } else {
      emit(state.copyWith(showLoginButtonLoading: false, error: 'Yes'));
    }
  }

  void _onChangePriority(ChangePriority event, Emitter<AuthState> emit) {
    emit(state.copyWith(isAdmin: event.priority));
  }
}
