part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();
  @override
  List<Object> get props => [];
}

class UpdateClientProfile extends UpdateProfileEvent {
  final String userId, firstName, email, lastName, password;
  final File? profilePicture;
  const UpdateClientProfile(
      {required this.userId,
      required this.firstName,
      required this.email,
      required this.lastName,
      this.profilePicture,
      required this.password});
  @override
  List<Object> get props => [userId, firstName, email, lastName, password];
}

class UpdateDoctorProfile extends UpdateProfileEvent {
  final String userId, firstName, email, gender, lastName;
  final File profilePicture;
  const UpdateDoctorProfile(
      {required this.userId,
      required this.firstName,
      required this.email,
      required this.lastName,
      required this.gender,
      required this.profilePicture});
  @override
  List<Object> get props =>
      [userId, firstName, email, gender, lastName, profilePicture];
}
