import 'package:diseases/business_logic/bloc/authentication/authentication_bloc.dart';
import 'package:diseases/constants/constants.dart';
import 'package:diseases/repositories/authentication/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/models/user.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final AuthRepository _authRepository;
  AuthStatusBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthStatusLoding()) {
    on<CheckUserStatus>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(
      CheckUserStatus event, Emitter<AuthStatusState> emit) async {
    try {
      final user = await _authRepository.checkUser();
      if ((user.userId ?? '').isNotEmpty) {
        currentUser = user;
        emit(UserAuthenticated(user: user));
      } else {
        emit(UserUnauthenticated());
      }
    } catch (e) {
      emit(UserUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(
      LoggedIn event, Emitter<AuthStatusState> emit) async {
    try {
      final user = await _authRepository.checkUser();
      if ((user.userId ?? '').isNotEmpty) {
        currentUser = user;
        emit(UserAuthenticated(user: user));
      } else {
        emit(UserUnauthenticated());
      }
    } catch (e) {
      emit(UserUnauthenticated());
    }
  }


  Future<void> _onLoggedOut(
      LoggedOut event, Emitter<AuthStatusState> emit) async {
    try {
      await _authRepository.logOut();
      emit(UserUnauthenticated());
    } catch (e) {
      emit(UserUnauthenticated());
    }
  }
}
