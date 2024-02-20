// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:diseases/constants/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'base_users_repository.dart';

class UsersRepository extends BaseUsersRepository {
  @override
  Future<UserModel> updateProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String userId,
      required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.put(Uri.parse(Environment.UPDATE_USER_URL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password,
            "userId": userId
          },
        ));

  print(jsonEncode({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "userId": userId
    }));

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(responseData['data']);
      preferences.setString('user', jsonEncode(user));
      return user;
    } else {
      throw Exception(responseData['message'] ??
          responseData['error'] ??
          'Failed to update user profile');
    }
  }

  @override
  Future<UserModel> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String userId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.put(Uri.parse(Environment.UPDATE_PASSWORD_URL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "oldPassword": oldPassword,
            "newPassword": newPassword,
            "userId": userId
          },
        ));

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(responseData['data']);
      preferences.setString('user', jsonEncode(user));
      return user;
    } else {
      throw Exception(responseData['message'] ??
          responseData['error'] ??
          'Failed to update user password');
    }
  }

  @override
  Future<UserModel> getUser({required String userId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse(Environment.GET_USER_URL + userId), headers: {
      'Content-Type': 'application/json',
    });

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(responseData['data']);
      preferences.setString('user', jsonEncode(user));
      return user;
    } else {
      throw Exception(responseData['message'] ??
          responseData['error'] ??
          'Failed to get user');
    }
  }
}
