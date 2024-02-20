// ignore_for_file: body_might_complete_normally_nullable

import '../models/user.dart';

abstract class BaseAuthRepository {
  Future<UserModel?> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {}
  Future<UserModel?> login(
      {required String email,
      required String password,
      required String otp}) async {}
  Future<bool?> sendOtp({required String email}) async {}
  Future<UserModel?> checkUser() async {}
  Future<bool?> deleteUser({required String userId}) async {}
  Future<bool?> logOut() async {}
}
