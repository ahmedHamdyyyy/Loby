import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../config/constants/constance.dart';

class UserModel {
  final String firstName, lastName, email, phone, password, role, id, profilePicture;

  const UserModel({
    required this.id,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.profilePicture,
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
  }) {
    return UserModel(
      id: id ?? this.id,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    password: json[AppConst.password] ?? '',
    firstName: json[AppConst.firstName] ?? '',
    lastName: json[AppConst.lastName] ?? '',
    email: json[AppConst.email] ?? '',
    phone: json[AppConst.phone] ?? '',
    role: json[AppConst.role] ?? '',
    id: json[AppConst.id] ?? '',
    profilePicture: json[AppConst.profilePicture] ?? '',
  );

  Future<FormData> signUp() async => FormData.fromMap({
    AppConst.firstName: firstName,
    AppConst.lastName: lastName,
    AppConst.password: password,
    AppConst.email: email,
    AppConst.phone: phone,
    AppConst.role: role,
    if (profilePicture.isNotEmpty)
      AppConst.profilePicture: await MultipartFile.fromFile(
        profilePicture,
        filename: profilePicture.split('/').last,
        contentType: MediaType('image', 'jpg'),
      ),
  });

  String toCache() => jsonEncode({
    AppConst.id: id,
    AppConst.firstName: firstName,
    AppConst.lastName: lastName,
    AppConst.password: password,
    AppConst.email: email,
    AppConst.phone: phone,
    AppConst.role: role,
    AppConst.profilePicture: profilePicture,
  });

  factory UserModel.fromCache(String user) => UserModel.fromJson(jsonDecode(user) as Map<String, dynamic>);
}
