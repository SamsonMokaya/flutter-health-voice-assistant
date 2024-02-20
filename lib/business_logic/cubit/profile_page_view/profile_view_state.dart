part of 'profile_view_cubit.dart';

class ProfileViewState extends Equatable {
  final int profileIndex;
  const ProfileViewState({required this.profileIndex});

  @override
  List<Object> get props => [profileIndex];
}
