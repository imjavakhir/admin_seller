part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class EyeIconPressed extends AuthEvent {}

class LoginButtonPressed extends AuthEvent {


}

class DeleteToken extends AuthEvent {}

class ChangePriority extends AuthEvent {
  final bool priority;

  const ChangePriority({required this.priority});
}
