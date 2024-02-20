part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileLoaded extends UpdateProfileState {}

class UpdateProfileLoadError extends UpdateProfileState {
  final String message;
  const UpdateProfileLoadError({required this.message});
  @override
  List<Object> get props => [message];
}
