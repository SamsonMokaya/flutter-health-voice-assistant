part of 'authentication_bloc.dart';

abstract class AuthState extends Equatable {
  final String action;
  const AuthState({required this.action});
  @override
  List<Object> get props => [action];
}

class AuthenticationLoding extends AuthState {
  const AuthenticationLoding({required String action}) : super(action: action);
}

class AuthenticationInitial extends AuthState {
  const AuthenticationInitial({required String action}) : super(action: action);
}

class LoginInProgress extends AuthState {
  const LoginInProgress() : super(action: 'login');
}

class RegistrationInProgress extends AuthState {
  const RegistrationInProgress() : super(action: 'register');
}

class AuthenticationSuccess extends AuthState {
  final UserModel user;
  final String message;

  const AuthenticationSuccess(
      {required this.user, required String action, this.message = ''})
      : super(action: action);
  @override
  List<Object> get props => [user, message, action];
}

class AuthenticationError extends AuthState {
  final String errorMessage;

  const AuthenticationError(
      {required String action, required this.errorMessage})
      : super(action: action);
  @override
  List<Object> get props => [errorMessage, action];
}
