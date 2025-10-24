import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<UserModel> uploadDocuments({
    required String nationalId,
    required String iban,
    required String certificateNumber,
    required String nationalIdFile,
    required String ibanFile,
    required String certificateFile,
  }) async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry(AppConst.nationalId, nationalId),
      MapEntry(AppConst.iban, iban),
      MapEntry(AppConst.certificateNumber, certificateNumber),
    ]);
    try {
      if (nationalIdFile.isNotEmpty && !nationalIdFile.startsWith('http')) {
        final extension = nationalIdFile.split('.').last.toLowerCase();
        if ('pdf' == extension && await File(nationalIdFile).exists()) {
          final contentType = MediaType('application', 'pdf');
          final filename = nationalIdFile.split(Platform.pathSeparator).last;
          formData.files.add(
            MapEntry(
              AppConst.nationalIdDocument,
              await MultipartFile.fromFile(nationalIdFile, filename: filename, contentType: contentType),
            ),
          );
        }
      }
      if (ibanFile.isNotEmpty && !ibanFile.startsWith('http')) {
        final extension = ibanFile.split('.').last.toLowerCase();
        if ('pdf' == extension && await File(ibanFile).exists()) {
          final contentType = MediaType('application', 'pdf');
          final filename = ibanFile.split(Platform.pathSeparator).last;
          formData.files.add(
            MapEntry(
              AppConst.ibanDocument,
              await MultipartFile.fromFile(ibanFile, filename: filename, contentType: contentType),
            ),
          );
        }
      }
      if (certificateFile.isNotEmpty && !certificateFile.startsWith('http')) {
        final extension = certificateFile.split('.').last.toLowerCase();
        if ('pdf' == extension && await File(certificateFile).exists()) {
          final contentType = MediaType('application', 'pdf');
          final filename = certificateFile.split(Platform.pathSeparator).last;
          formData.files.add(
            MapEntry(
              AppConst.certificateNumberDocument,
              await MultipartFile.fromFile(certificateFile, filename: filename, contentType: contentType),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error preparing files: $e');
      rethrow;
    }
    final response = await _apiServices.dio.post(ApiConstance.updateVendorDocuments, data: formData);
    _checkIfSuccess(response);
    log(response.data.toString());
    return UserModel.fromJson(response.data['data']['user']);
  }

  void _checkIfSuccess(Response<dynamic> response) {
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }
}
