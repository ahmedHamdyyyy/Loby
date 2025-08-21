import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../config/constants/constance.dart';
import '../../../models/user_model.dart';
import 'data.dart';

class ProfileRepository {
  const ProfileRepository(this._userData);
  final ProfileData _userData;

  Future<({UserModel user, VendorRole role})> fetchUserData() async {
    try {
      return await _userData.fetchUserData();
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) throw Exception(e.response?.data['error'].toString());
      throw Exception('فشل الاتصال بالخادم');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  Future<void> setVendorRole(VendorRole role) async {
    try {
      await _userData.setVendorRole(role);
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
