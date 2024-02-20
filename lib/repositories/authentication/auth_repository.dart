// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:diseases/constants/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  @override
  Future<UserModel?> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(Environment.REGISTER_URL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password
        }));
    final responseData = jsonDecode(response.body);
    print(responseData);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      UserModel user = UserModel.fromJson(responseData);
      preferences.setString('user', jsonEncode(user));
      return user;
    } else {
      throw Exception(responseData['message'] ??
          responseData['error'] ??
          'Failed to sign up user');
    }
  }

  @override
  Future<UserModel> login(
      {required String email,
      required String password,
      required String otp}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(Environment.LOGIN_URL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {"email": email, "password": password, "otp": otp},
        ));
    print(response.body);
    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      responseData['data']['otpVerified'] = true;
      UserModel user = UserModel.fromJson(responseData['data']);
      print(user.toJson());
      preferences.setString('user', jsonEncode(user));
      return user;
    } else {
      throw Exception(responseData['message'] ??
          responseData['error'] ??
          'Failed to login user');
    }
  }

  @override
  Future<bool> sendOtp({required String email}) async {
    final response = await http.post(Uri.parse(Environment.OTP_URL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {"email": email},
        ));

    print(response.body);

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // bool sent = responseData['data'];
      return true;
    } else {
      throw Exception(responseData['message'] ??
          responseData['error'] ??
          'Failed to send otp');
    }
  }

  @override
  Future<bool> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool loggedOut = await preferences.remove('user');
    return loggedOut;
  }

  @override
  Future<bool> deleteUser({required String userId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(Environment.DELETE_USER_URL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"userId": userId}));
    print(response.body);
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if ((responseData).containsKey('message')) {
        return true;
      }
      return true;
    } else {
      throw Exception(responseData['message'] ??
          responseData['error'] ??
          'Failed to delete user');
    }
  }

  @override
  Future<UserModel> checkUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userFromPrefs = preferences.getString('user');
    try {
      if (userFromPrefs != null) {
        final userString = jsonDecode(userFromPrefs);
        UserModel user = UserModel.fromJson(userString);
        return user;
      } else {
        throw ('User not authenticated');
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}
