import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/user_model.dart';
import 'data.dart';

class UserRepository {
  const UserRepository(this._userData);
  final UserData _userData;



  Future<UserModel> fetchUser() async {
    try {
      return await _userData.fetchUser();
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
