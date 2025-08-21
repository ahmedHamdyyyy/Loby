import 'package:flutter/material.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../config/constants/constance.dart';
import '../../../core/services/cach_services.dart';
import '../../../models/user_model.dart';

class ProfileData {
  const ProfileData(this._apiServices, this._cacheService);
  final ApiService _apiServices;
  final CacheService _cacheService;

  Future<({UserModel user, VendorRole role})> fetchUserData() async {
    final response = await _apiServices.dio.get(ApiConstance.userProfile);
    debugPrint(response.data.toString());
    if (!(response.data['success'] ?? false) || response.data['data'] == null) throw Exception('فشل تحميل الملف الشخصي');
    return (
      user: UserModel.fromJson(response.data['data']),
      role: VendorRole.values.firstWhere((e) => e.name == response.data['data']['vendorRole'], orElse: () => VendorRole.non),
    );
  }

  Future<void> setVendorRole(VendorRole role) async {
    try {
      final response = await _apiServices.dio.post(ApiConstance.setVendorRole, data: {'vendorRole': role.name});
      print(response.data);
      if (response.data['success'] != true) throw Exception('فشل تعيين دور البائع');
      await _cacheService.storage.setString(AppConst.vendorRole, role.name);
    } catch (e) {
      throw Exception('Failed to set vendor role: ${e.toString()}');
    }
  }
}
