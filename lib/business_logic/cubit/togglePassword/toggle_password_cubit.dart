import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'toggle_password_state.dart';

class TogglePasswordCubit extends Cubit<TogglePasswordState> {
  TogglePasswordCubit() : super(TogglePasswordState.initial()) {
    initializeRememberMe();
  }

  void initializeRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool("remember_me") ?? false;
    emit(state.copyWith(rememberMe: rememberMe));
  }

  void toggleLoginPassword() {
    emit(state.copyWith(passwordLoginVisible: !state.passwordLoginVisible));
  }

  void toggleSignUpPassword() {
    emit(state.copyWith(passwordSignUpVisible: !state.passwordSignUpVisible));
  }

  void changePage(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  void toggleSignUp() {
    emit(state.copyWith(signUp: !state.signUp));
  }

  void toggleRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool newRememberMe = !state.rememberMe;
    prefs.setBool("remember_me", newRememberMe);
    emit(state.copyWith(rememberMe: newRememberMe));
  }

  void toggleLoading() {
    emit(state.copyWith(loading: !state.loading));
  }
}
