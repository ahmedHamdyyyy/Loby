import 'package:flutter/material.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../config/constants/constance.dart';
import '../../../models/user.dart';

class ProfileData {
  const ProfileData(this._apiServices);
  final ApiService _apiServices;

  Future<UserModel> fetchUserData() async {
    final response = await _apiServices.dio.get(ApiConstance.userProfile);
    debugPrint(response.data.toString());
    if (!(response.data['success'] ?? false) || response.data['data'] == null) throw Exception('فشل تحميل الملف الشخصي');
    return UserModel.fromJson(response.data['data']);
  }

  Future<void> setVendorRole(VendorRole role) async {
    try {
      final response = await _apiServices.dio.post(ApiConstance.setVendorRole, data: {'vendorRole': role.name});
      if (response.data['success'] != true) throw Exception('فشل تعيين دور البائع');
    } catch (e) {
      throw Exception('Failed to set vendor role: ${e.toString()}');
    }
  }
}
