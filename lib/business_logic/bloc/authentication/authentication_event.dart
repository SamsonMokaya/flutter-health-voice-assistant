part of 'authentication_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartApp extends AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;
  final String otp;

  Login({required this.email, required this.password, required this.otp});
  @override
  List<Object> get props => [email, password, otp];
}

class Register extends AuthEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  Register({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });
  @override
  List<Object> get props => [email, firstName, lastName, password];
}

class LogOut extends AuthEvent {}

class UpdateUserProfile extends AuthEvent {}
