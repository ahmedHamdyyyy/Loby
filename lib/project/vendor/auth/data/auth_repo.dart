import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import 'auth_data.dart';

class AuthRepo {
  const AuthRepo(this._authData);
  final AuthData _authData;

  Future<UserModel> signup({required UserModel user}) async {
    try {
      return await _authData.signup(user: user);
    } on DioException catch (e) {
      debugPrint('Unexpected error: $e');
      if (e.response?.data['error'] != null) {
        final errors = e.response?.data['error'] as List;
        if (errors.isNotEmpty && errors[0] is List) throw Exception((errors[0] as List).join(', '));
      }
      throw Exception('Failed to sign up');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<UserModel> signin({required String email, required String password}) async {
    try {
      return await _authData.signin(email: email, password: password);
    } on DioException catch (e) {
      final error = e.response?.data['error'] ;
      if (error == null ) {
        throw Exception(error);
      }
      if (error is String)throw Exception(error) ;
      if (error is List) {
        throw Exception(error.join(', '));
      }

      if (e.response?.data['error'] != null && e.response?.data['error'] is Map) {
        final errors = e.response?.data['error'] ;
        if (errors.isNotEmpty && errors ) throw Exception(errors);
      }
      throw Exception(e.response?.data['error']);
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<String> signout() async {
    try {
      return await _authData.signout();
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}
