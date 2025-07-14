// import 'dart:convert';

// import '../../../../config/constants/constance.dart';

// class UserProfileResponse {
//   final bool success;
//   final UserProfileModel data;

//   UserProfileResponse({
//     required this.success,
//     required this.data,
//   });

//   factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
//     return UserProfileResponse(
//       success: json['success'] ?? false,
//       data: UserProfileModel.fromMap(json['data']),
//     );
//   }
// }

// class UserProfileModel {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phone;
//   final String password;
//   final String role;
//   final String? profilePicture;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   UserProfileModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.password,
//     required this.role,
//     this.profilePicture,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory UserProfileModel.fromMap(Map<String, dynamic> map) {
//     return UserProfileModel(
//       id: map[AppConst.id] ?? '',
//       firstName: map[AppConst.firstName] ?? '',
//       lastName: map[AppConst.lastName] ?? '',
//       email: map[AppConst.email] ?? '',
//       phone: map[AppConst.phone] ?? '',
//       password: map[AppConst.password] ?? '',
//       role: map[AppConst.role] ?? '',
//       profilePicture: map[AppConst.profilePicture],
//       createdAt: DateTime.parse(map[AppConst.createdAt]),
//       updatedAt: DateTime.parse(map[AppConst.updatedAt]),
//     );
//   }
// }
