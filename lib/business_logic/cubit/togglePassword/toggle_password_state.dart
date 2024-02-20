// ignore_for_file: non_constant_identifier_names

part of 'toggle_password_cubit.dart';

class TogglePasswordState {
  final bool loading;
  final bool passwordLoginVisible;
  final bool passwordSignUpVisible;
  final bool rememberMe;
  final int selectedTabIndex;
  final bool signUp;

  TogglePasswordState({
    required this.loading,
    required this.passwordLoginVisible,
    required this.passwordSignUpVisible,
    required this.rememberMe,
    required this.selectedTabIndex,
    required this.signUp,
  });

  factory TogglePasswordState.initial() {
    return TogglePasswordState(
      loading: false,
      passwordSignUpVisible: true,
      passwordLoginVisible: true,
      rememberMe: false,
      selectedTabIndex: 0,
      signUp: false,
    );
  }

  TogglePasswordState copyWith({
    bool? loading,
    bool? passwordLoginVisible,
    bool? passwordSignUpVisible,
    bool? rememberMe,
    int? selectedTabIndex,
    bool? signUp,
  }) {
    return TogglePasswordState(
      loading: loading ?? this.loading,
      passwordLoginVisible: passwordLoginVisible ?? this.passwordLoginVisible,
      passwordSignUpVisible:
          passwordSignUpVisible ?? this.passwordSignUpVisible,
      rememberMe: rememberMe ?? this.rememberMe,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      signUp: signUp ?? this.signUp,
    );
  }
}
