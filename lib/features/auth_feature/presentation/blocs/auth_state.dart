part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool showLoginButtonLoading;

  final String password;
  final bool obscureText;
  final String error;
  final bool isAdmin;

  const AuthState(
      {this.showLoginButtonLoading = false,
      this.password = '',
      this.obscureText = true,
      this.error = '',
      this.isAdmin = false});

  AuthState copyWith(
      {final bool? showLoginButtonLoading,
      final String? phone,
      final String? password,
      final bool? obscureText,
      final String? error,
      final bool? isAdmin}) {
    // debugPrint('Error ------------- $error');
    return AuthState(
        showLoginButtonLoading:
            showLoginButtonLoading ?? this.showLoginButtonLoading,
        password: password ?? this.password,
        obscureText: obscureText ?? this.obscureText,
        error: error ?? this.error,
        isAdmin: isAdmin ?? this.isAdmin);
  }

  @override
  List<Object> get props =>
      [showLoginButtonLoading, password, obscureText, error, isAdmin];
}
