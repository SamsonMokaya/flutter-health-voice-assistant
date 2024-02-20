// ignore_for_file: body_might_complete_normally_nullable

import '../models/user.dart';

abstract class BaseUsersRepository {
  Future<UserModel?> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String userId,
  }) async {}
  Future<UserModel?> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String userId,
    required String password
  }) async {}
 
  Future<UserModel?> getUser({required String userId}) async {}
}
