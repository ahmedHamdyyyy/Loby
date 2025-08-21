import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

class CustomActivityModel extends Equatable {
  final String id, name, image;

  const CustomActivityModel({required this.id, required this.name, required this.image});

  CustomActivityModel copyWith({String? id, String? name, String? image}) =>
      CustomActivityModel(id: id ?? this.id, name: name ?? this.name, image: image ?? this.image);

  factory CustomActivityModel.fromJson(Map<String, dynamic> json) => CustomActivityModel(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    image: (json['medias'] ?? []).isNotEmpty ? json['medias'][0] : '',
  );

  factory CustomActivityModel.fromProperty(ActivityModel property) => CustomActivityModel(
    id: property.id,
    name: property.name,
    image: property.medias.isNotEmpty ? property.medias.first : '',
  );

  @override
  List<Object> get props => [id, name, image];
}

class ActivityModel extends Equatable {
  final String id, vendorId, name, address, details, date, time, activityTime;
  final double price;
  final int maximumGuestNumber;
  final List<String> tags, medias;
  final bool verified;

  const ActivityModel({
    required this.id,
    required this.vendorId,
    required this.date,
    required this.time,
    required this.activityTime,
    required this.name,
    required this.address,
    required this.details,
    required this.tags,
    required this.price,
    required this.medias,
    required this.verified,
    required this.maximumGuestNumber,
  });

  static const non = ActivityModel(
    id: '',
    vendorId: '',
    date: '',
    time: '',
    activityTime: '',
    name: '',
    address: '',
    details: '',
    tags: [],
    price: 0,
    maximumGuestNumber: 0,
    medias: [],
    verified: false,
  );

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    List<String> parseStringOrList(dynamic value) {
      if (value == null) return [];
      if (value is List) return List<String>.from(value);
      if (value is String) return [value];
      return [];
    }

    return ActivityModel(
      id: json['_id'] ?? '',
      vendorId: json['vendorId'] ?? '',
      address: json['address'] ?? '',
      details: json['details'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      price: (json['price'] is String) ? double.tryParse(json['price']) ?? 0.0 : (json['price'] ?? 0).toDouble(),
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      activityTime: json['activityTime'] ?? '',
      name: json['name'] ?? '',
      maximumGuestNumber: json['maximumGuestNumber'] ?? 0,
      verified:
          (json['verified'] is String) ? json['verified'].toString().toLowerCase() == 'true' : json['verified'] ?? false,
      medias: parseStringOrList(json['medias']),
    );
  }

  Future<FormData> create() async {
    final formData = FormData();

    // Add basic fields
    List<MapEntry<String, String>> fields = [
      MapEntry('vendorId', vendorId),
      MapEntry('date', date),
      MapEntry('time', time),
      MapEntry('activityTime', activityTime),
      MapEntry('name', name),
      MapEntry('address', address),
      MapEntry('details', details),
      MapEntry('maximumGuestNumber', maximumGuestNumber.toString()),
      MapEntry('price', price.toString()),
      // لا نرسل verified للأنشطة الجديدة - الخادم يتولى ذلك
    ];

    // إضافة ID فقط إذا لم يكن فارغ (للتحديث)
    if (id.isNotEmpty) {
      fields.add(MapEntry('_id', id));
      // إضافة verified فقط عند التحديث
      fields.add(MapEntry('verified', verified.toString()));
    }

    formData.fields.addAll(fields);

    // Add arrays
    for (final tag in tags) {
      formData.fields.add(MapEntry('tags', tag));
    }

    // Add files with proper content types
    try {
      // Add media files
      for (final filePath in medias) {
        if (filePath.isEmpty) continue;
        if (filePath.startsWith('https://') || filePath.startsWith('http://')) {
          formData.fields.add(MapEntry('existingMedias', filePath));
          continue;
        }
        final extension = filePath.split('.').last.toLowerCase();
        if (!['jpg', 'jpeg', 'png', 'mp4'].contains(extension)) continue;
        if (!await File(filePath).exists()) continue;
        formData.files.add(
          MapEntry(
            'medias',
            await MultipartFile.fromFile(
              filePath,
              filename: filePath.split('/').last,
              contentType: MediaType('image', extension),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error preparing files: $e');
      rethrow;
    }

    return formData;
  }

  ActivityModel copyWith({
    String? id,
    String? address,
    String? details,
    List<String>? tags,
    double? price,
    List<String>? medias,
    String? name,
    String? date,
    String? time,
    String? activityTime,
    String? vendorId,
    bool? verified,
    int? maximumGuestNumber,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      address: address ?? this.address,
      details: details ?? this.details,
      tags: tags ?? this.tags,
      price: price ?? this.price,
      medias: medias ?? this.medias,
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
      activityTime: activityTime ?? this.activityTime,
      vendorId: vendorId ?? this.vendorId,
      verified: verified ?? this.verified,
      maximumGuestNumber: maximumGuestNumber ?? this.maximumGuestNumber,
    );
  }

  @override
  List<Object?> get props => [
    id,
    address,
    details,
    maximumGuestNumber,
    tags,
    price,
    medias,
    name,
    date,
    time,
    activityTime,
    vendorId,
    verified,
  ];
}
