import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../config/constants/constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/cach_services.dart';
import '../../models/user_model.dart';

class HomeRepository {
  const HomeRepository(this._apiServices, this._cacheServices);
  final ApiService _apiServices;
  final CacheService _cacheServices;

  UserModel getCachedUser() {
    try {
      final userData = _cacheServices.storage.getString(AppConst.user);
      if (userData == null) throw Exception('فشل العثور علي الملف الشخصي يرجي اعادة تسجيل الدخول');
      return UserModel.fromCache(userData);
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  Future<UserModel> getUserProfile(String id) async {
    try {
      final response = await _apiServices.dio.get(ApiConstance.userProfile(id));
      if (!(response.data['success'] ?? false) || response.data['data'] == null) {
        throw Exception('فشل تحميل الملف الشخصي');
      }
      final userResponse = UserModel.fromJson(response.data['data']['user']);
      return userResponse;
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) {
        throw Exception(e.response?.data['error'].toString());
      }
      throw Exception('فشل الاتصال بالخادم');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('حدث خطأ غير متوقع');
    }
  }

  // Future<PropertyModel> createProperty(PropertyModel property) async {
  //   try {
  //     final response = await _apiServices.dio.post(
  //       ApiConstance.createProperty,
  //       data: FormData.fromMap(await property.create()),
  //     );

  //     if (!(response.data['success'] ?? false)) {
  //       throw Exception(response.data['error']?.toString() ?? 'Unknown error occurred');
  //     }
  //     return property.copyWith(id: response.data['data']['id']);
  //   } on DioException catch (e) {
  //     debugPrint('API Error Response: ${e.response?.data}');
  //     if (e.response?.data['error'] != null) {
  //       final errorMessage = e.response?.data['error'];
  //       if (errorMessage is List) {
  //         throw Exception(errorMessage.join(', '));
  //       } else {
  //         throw Exception(errorMessage.toString());
  //       }
  //     }
  //     throw Exception('Failed to create property: ${e.message}');
  //   } catch (e) {
  //     debugPrint('Unexpected error: $e');
  //     throw Exception('An unexpected error occurred');
  //   }
  // }
}
