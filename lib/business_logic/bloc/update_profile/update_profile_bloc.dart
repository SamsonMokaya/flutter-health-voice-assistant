// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:diseases/constants/constants.dart';
import 'package:diseases/repositories/models/user.dart';
import 'package:diseases/repositories/user_repository/users_repository.dart';
import 'package:equatable/equatable.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UsersRepository repo;
  UpdateProfileBloc({required UsersRepository repository})
      : repo = repository,
        super(UpdateProfileInitial()) {
    on<UpdateClientProfile>(_onUpdateClientProfile);
  }
  Future<void> _onUpdateClientProfile(
      UpdateClientProfile event, Emitter<UpdateProfileState> emit) async {
    try {
      emit(UpdateProfileLoading());
      print(currentUser.token);

      UserModel user = await repo.updateProfile(
          email: event.email,
          firstName: event.firstName,
          lastName: event.lastName,
          userId: currentUser.userId.toString(),
          password: event.password);
      currentUser = user;

      emit(UpdateProfileLoaded());
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(UpdateProfileLoadError(message: message));
    }
  }
}
