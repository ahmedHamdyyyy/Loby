import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

import '../config/constants/constance.dart';

enum UserStatus { approved, pending, rejected }

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String id;
  final String profilePicture;
  final String nationalId;
  final String iban;
  final String certificateNumber;
  final String nationalIdDocument;
  final String ibanDocument;
  final String certificateNumberDocument;
  final UserStatus status;

  const UserModel({
    required this.id,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.profilePicture,
    required this.nationalId,
    required this.iban,
    required this.certificateNumber,
    required this.nationalIdDocument,
    required this.ibanDocument,
    required this.certificateNumberDocument,
    required this.status,
  });

  static const non = UserModel(
    password: '',
    firstName: '',
    lastName: '',
    id: '',
    email: '',
    phone: '',
    role: '',
    profilePicture: '',
    nationalId: '',
    iban: '',
    certificateNumber: '',
    nationalIdDocument: '',
    ibanDocument: '',
    certificateNumberDocument: '',
    status: UserStatus.pending,
  );

  UserModel copyWith({
    String? password,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    String? id,
    String? profilePicture,
    UserStatus? status,
    String? nationalId,
    String? iban,
    String? certificateNumber,
    String? nationalIdDocument,
    String? ibanDocument,
    String? certificateNumberDocument,
  }) => UserModel(
    id: id ?? this.id,
    password: password ?? this.password,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    role: role ?? this.role,
    profilePicture: profilePicture ?? this.profilePicture,
    nationalId: nationalId ?? this.nationalId,
    iban: iban ?? this.iban,
    certificateNumber: certificateNumber ?? this.certificateNumber,
    nationalIdDocument: nationalIdDocument ?? this.nationalIdDocument,
    ibanDocument: ibanDocument ?? this.ibanDocument,
    certificateNumberDocument: certificateNumberDocument ?? this.certificateNumberDocument,
    status: status ?? this.status,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json[AppConst.id] ?? '',
    email: json[AppConst.email] ?? '',
    phone: json[AppConst.phone] ?? '',
    role: json[AppConst.vendorRole] ?? json[AppConst.role] ?? '',
    password: json[AppConst.password] ?? '',
    lastName: json[AppConst.lastName] ?? '',
    firstName: json[AppConst.firstName] ?? '',
    profilePicture: json[AppConst.profilePicture] ?? '',
    nationalId: json[AppConst.nationalId] ?? '',
    iban: json[AppConst.iban] ?? '',
    certificateNumber: json[AppConst.certificateNumber] ?? '',
    nationalIdDocument: json[AppConst.nationalIdDocument] ?? '',
    ibanDocument: json[AppConst.ibanDocument] ?? '',
    certificateNumberDocument: json[AppConst.certificateNumberDocument] ?? '',
    status: UserStatus.values.firstWhere((e) => e.name == json['verified'], orElse: () => UserStatus.pending),
  );

  Future<FormData> signUp() async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry(AppConst.firstName, firstName),
      MapEntry(AppConst.lastName, lastName),
      MapEntry(AppConst.password, password),
      MapEntry(AppConst.email, email),
      MapEntry(AppConst.role, role),
      MapEntry(AppConst.phone, phone),
      MapEntry(AppConst.nationalId, nationalId),
      MapEntry(AppConst.iban, iban),
      MapEntry(AppConst.certificateNumber, certificateNumber),
    ]);

    try {
      if (nationalIdDocument.isNotEmpty && !nationalIdDocument.startsWith('http')) {
        final extension = nationalIdDocument.split('.').last.toLowerCase();
        if ('pdf' == extension && await File(nationalIdDocument).exists()) {
          final contentType = MediaType('application', 'pdf');
          final filename = nationalIdDocument.split(Platform.pathSeparator).last;
          formData.files.add(
            MapEntry(
              AppConst.nationalIdDocument,
              await MultipartFile.fromFile(nationalIdDocument, filename: filename, contentType: contentType),
            ),
          );
        }
      }
      if (ibanDocument.isNotEmpty && !ibanDocument.startsWith('http')) {
        final extension = ibanDocument.split('.').last.toLowerCase();
        if ('pdf' == extension && await File(ibanDocument).exists()) {
          final contentType = MediaType('application', 'pdf');
          final filename = ibanDocument.split(Platform.pathSeparator).last;
          formData.files.add(
            MapEntry(
              AppConst.ibanDocument,
              await MultipartFile.fromFile(ibanDocument, filename: filename, contentType: contentType),
            ),
          );
        }
      }
      if (certificateNumberDocument.isNotEmpty && !certificateNumberDocument.startsWith('http')) {
        final extension = certificateNumberDocument.split('.').last.toLowerCase();
        if ('pdf' == extension && await File(certificateNumberDocument).exists()) {
          final contentType = MediaType('application', 'pdf');
          final filename = certificateNumberDocument.split(Platform.pathSeparator).last;
          formData.files.add(
            MapEntry(
              AppConst.certificateNumberDocument,
              await MultipartFile.fromFile(certificateNumberDocument, filename: filename, contentType: contentType),
            ),
          );
        }
      }
      if (profilePicture.isNotEmpty && !profilePicture.startsWith('http')) {
        final extension = profilePicture.split('.').last.toLowerCase();
        if (['jpg', 'jpeg', 'png'].contains(extension) && await File(profilePicture).exists()) {
          final contentType = MediaType('image', extension);
          final filename = profilePicture.split(Platform.pathSeparator).last;
          formData.files.add(
            MapEntry(
              AppConst.profilePicture,
              await MultipartFile.fromFile(profilePicture, filename: filename, contentType: contentType),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error preparing files: $e');
      rethrow;
    }
    return formData;
  }

  String toCache() => jsonEncode({
    AppConst.id: id,
    AppConst.firstName: firstName,
    AppConst.lastName: lastName,
    AppConst.password: password,
    AppConst.email: email,
    AppConst.phone: phone,
    AppConst.role: role,
    AppConst.profilePicture: profilePicture,
    AppConst.nationalId: nationalId,
    AppConst.iban: iban,
    AppConst.certificateNumber: certificateNumber,
    AppConst.nationalIdDocument: nationalIdDocument,
    AppConst.ibanDocument: ibanDocument,
    AppConst.certificateNumberDocument: certificateNumberDocument,
    'verified': status,
  });

  factory UserModel.fromCache(String user) => UserModel.fromJson(jsonDecode(user) as Map<String, dynamic>);
}
