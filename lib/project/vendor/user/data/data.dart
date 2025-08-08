import 'package:flutter/material.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../config/constants/constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/cach_services.dart';
import '../../models/user_model.dart';

class UserData {
  const UserData(this._apiServices);
  final ApiService _apiServices;



  Future<UserModel> fetchUser() async {
    final response = await _apiServices.dio.get(ApiConstance.userProfile);
    debugPrint(response.data.toString());
    if (!(response.data['success'] ?? false) || response.data['data'] == null) throw Exception('فشل تحميل الملف الشخصي');
    final userResponse = UserModel.fromJson(response.data['data']);
    return userResponse;
  }
}
