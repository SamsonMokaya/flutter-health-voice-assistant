// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_status_bloc.dart';

abstract class AuthStatusEvent extends Equatable {
  const AuthStatusEvent();

  @override
  List<Object> get props => [];
}

class CheckUserStatus extends AuthStatusEvent {}

class LoggedIn extends AuthStatusEvent {
  final UserModel user;
  const LoggedIn({required this.user});
}

class LoggedOut extends AuthStatusEvent {}
