import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginButtonPressed>(_onLoginPressed);
    on<EyeIconPressed>(_onEyeIconPressed);
    on<ChangePriority>(_onChangePriority);
    // on<DeleteToken>(_onDeleteToken);
  }
  // final LoginService _loginService = LoginService();
  // final TextEditingController _phoneController;
  // final TextEditingController _passwordController;

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
    // UserModel? userModel = await _loginService.login(
    //   phoneNumber: _phoneController.text,
    //   password: _passwordController.text,
    //   role: event.role,
    //   fireBaseToken: 'string',
    // );
    // emit(state.copyWith(showLoginButtonLoading: !state.showLoginButtonLoading));
    // if (userModel != null) {
    //   print('TOKEN--------${userModel.token}');

    //   emit(state.copyWith(
    //       showLoginButtonLoading: !state.showLoginButtonLoading));
    // } else {
    //   emit(state.copyWith(
    //       showLoginButtonLoading: !state.showLoginButtonLoading));
    // }
    // if (_formKey.currentState!.validate()) {
    //   emit(state.copyWith(showLoginButtonLoading: true));
    // }
  }

  void _onChangePriority(ChangePriority event, Emitter<AuthState> emit) {
    emit(state.copyWith(isAdmin: event.priority));
  }
}
