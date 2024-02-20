part of 'auth_status_bloc.dart';

abstract class AuthStatusState extends Equatable {
  const AuthStatusState();

  @override
  List<Object> get props => [];
}

class AuthStatusLoding extends AuthStatusState {}

class UserUnauthenticated extends AuthStatusState {
  @override
  List<Object> get props => [];
}

class AccountDeleted extends AuthStatusState {
  @override
  List<Object> get props => [];
}

class UserAuthenticated extends AuthStatusState {
  final UserModel user;
  const UserAuthenticated({required this.user});
  @override
  List<Object> get props => [user];
}
