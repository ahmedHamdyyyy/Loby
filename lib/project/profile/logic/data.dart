import 'package:flutter/material.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../config/constants/constance.dart';
import '../../../models/user.dart';
import 'package:dio/dio.dart';


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
      if (![200, 201, 202, 203].contains(response.statusCode)) throw Exception('فشل تعيين دور البائع');
    } catch (e) {
      throw Exception('Failed to set vendor role: ${e.toString()}');
    }
  }


    Future<UserModel> updateUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String imagePath,
  }) async {
    final response = await _apiServices.dio.put(
      '/auth/update',
      data: FormData.fromMap(<String, dynamic>{
        AppConst.firstName: firstName,
        AppConst.lastName: lastName,
        AppConst.phone: phone,
        if (imagePath.isNotEmpty && !imagePath.startsWith('http'))
          AppConst.profilePicture: await MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split('/').last.split('.').first,
            contentType: DioMediaType('image', imagePath.split('.').last),
          ),
      }),
    );
    _checkIfSuccess(response);
    return UserModel.fromJson(response.data['data']);
  }


    void _checkIfSuccess(Response<dynamic> response) {
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }
}
