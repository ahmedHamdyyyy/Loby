import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/error/dio_error.dart';
import '../../../models/user.dart';
import 'auth_data.dart';

class AuthRepo {
  const AuthRepo(this._authData);
  final AuthData _authData;

  Future<UserModel> signup({required UserModel user}) async {
    try {
      return await _authData.signup(user: user);
    } on DioException catch (e, s) {
      debugPrint('$e \n${e.response?.data} \n${e.response?.statusCode} \n${e.response?.statusMessage} ${s.toString()}');
      rethrow;
    } catch (e, s) {
      debugPrint('$e \n${s.toString()}');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<UserModel> signin({required String email, required String password}) async {
    try {
      return await _authData.signin(email: email, password: password);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again later.');
    }
  }

  Future<String> signout() async {
    try {
      return await _authData.signout();
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      throw ApiExceptionHandler.handle(e);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> verifyEmail({required String email}) async {
    try {
      await _authData.verifyEmail(email: email);
    } on DioException catch (e, s) {
      debugPrintStack(label: e.message, stackTrace: s);
      debugPrint(e.response?.data.toString());
      debugPrint(e.response?.statusMessage.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> confirmOtp(String email, String otp, bool willSignup) async {
    try {
      await _authData.confirmOtpSignUp(email, otp, willSignup);
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      throw ApiExceptionHandler.handle(e);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> verifyUserData(UserModel user) async {
    try {
      await _authData.verifyUserData(user);
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      throw ApiExceptionHandler.handle(e);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }

  Future<String> resetPassword(String email, String newPassword) async {
    try {
      return await _authData.resetPassword(email, newPassword);
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      throw ApiExceptionHandler.handle(e);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('An unexpected error occurred');
    }
  }
}
