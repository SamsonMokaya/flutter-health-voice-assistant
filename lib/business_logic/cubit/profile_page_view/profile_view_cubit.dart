import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_view_state.dart';

class ProfileViewCubit extends Cubit<ProfileViewState> {
  ProfileViewCubit() : super(const ProfileViewState(profileIndex: 0));

  void switchToNextSession({required int profileIndex}) {
    emit(ProfileViewState(profileIndex: profileIndex));
  }

  // ProfileView getProfileView() {
  //   return state.ProfileView;
  // }
}
