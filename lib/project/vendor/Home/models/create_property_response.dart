// import 'package:equatable/equatable.dart';
// import 'property_model.dart';

// class CreatePropertyResponse extends Equatable {
//   final bool success;
//   final PropertyModel data;

//   const CreatePropertyResponse({
//     required this.success,
//     required this.data,
//   });

//   factory CreatePropertyResponse.fromJson(Map<String, dynamic> json) {
//     return CreatePropertyResponse(
//       success: json['success'] ?? false,
//       data: PropertyModel.fromJson(json['data'] ?? {}),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'success': success,
//       'data': data.toJson(),
//     };
//   }

//   @override
//   List<Object?> get props => [success, data];
// }
