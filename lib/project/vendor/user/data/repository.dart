import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/user_model.dart';
import 'data.dart';

class UserRepository {
  const UserRepository(this._userData);
  final UserData _userData;

  UserModel getCachedUser() {
    try {
      return _userData.getCachedUser();
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع يرجي اعادة تسجيل الدخول');
    }
  }

  Future<UserModel> fetchUser() async {
    try {
      return _userData.fetchUser();
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) throw Exception(e.response?.data['error'].toString());
      throw Exception('فشل الاتصال بالخادم');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }
}
