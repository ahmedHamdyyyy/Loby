import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart'; // Added for debugPrint
import 'dart:io'; // Added for File
import '../../../../config/constants/api_constance.dart';

class CustomPropertyModel extends Equatable {
  final String id, type, image;
  final bool available;
  final String vendorId;

  const CustomPropertyModel({required this.id,
  required this.vendorId,
   required this.type, required this.image, required this.available});

  CustomPropertyModel copyWith({
    String? vendorId,
    String? id, String? type, String? image, bool? available}) => CustomPropertyModel(
    id: id ?? this.id,
    type: type ?? this.type,
    vendorId: vendorId ?? this.vendorId,
    image: image ?? this.image,
    available: available ?? this.available,
  );

  factory CustomPropertyModel.fromJson(Map<String, dynamic> json) {
    String getFirstMedia(dynamic medias) {
      if (medias == null) return '';
      if (medias is List && medias.isNotEmpty) {
        String mediaUrl = medias[0].toString();
        // Only prepend base URL if it's not already a full URL
        return mediaUrl.startsWith('http') ? mediaUrl : ApiConstance.baseUrl + mediaUrl;
      }
      if (medias is String) {
        // Only prepend base URL if it's not already a full URL
        return medias.startsWith('http') ? medias : ApiConstance.baseUrl + medias;
      }
      return '';
    }

    return CustomPropertyModel(
    id: json['_id'] ?? '',
    vendorId: json['vendorId'] ?? '',
    type: json['type'] ?? '',
      image: getFirstMedia(json['medias']),
    available: json['available'] ?? false,
  );
  }

  factory CustomPropertyModel.fromProperty(PropertyModel property) => CustomPropertyModel(
    id: property.id,
    type: property.type,
    image: property.medias.isNotEmpty ? 
      (property.medias.first.startsWith('http') ? property.medias.first : ApiConstance.baseUrl + property.medias.first) : '',
    available: property.available,
    vendorId: property.id,
  );

  @override
  List<Object> get props => [id, type, image, available];
}

class PropertyModel extends Equatable {
  final String id, type, address, details;
  final int guestNumber, bedrooms, bathrooms, beds, pricePerNight, maxDays;
  final List<String> tags, availableDates, medias, ownershipContract, facilityLicense;
  final bool available;

  const PropertyModel({
    required this.id,
    required this.type,
    required this.available,
    required this.guestNumber,
    required this.bedrooms,
    required this.bathrooms,
    required this.beds,
    required this.address,
    required this.details,
    required this.tags,
    required this.pricePerNight,
    required this.availableDates,
    required this.maxDays,
    required this.ownershipContract,
    required this.medias,
    required this.facilityLicense,
  });

  static const non = PropertyModel(
    id: '',
    type: '',
    available: true,
    guestNumber: 0,
    bedrooms: 0,
    bathrooms: 0,
    beds: 0,
    address: '',
    details: '',
    tags: [],
    pricePerNight: 0,
    availableDates: [],
    maxDays: 0,
    ownershipContract: [],
    facilityLicense: [],
    medias: [],
  );

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    List<String> parseStringOrList(dynamic value) {
      if (value == null) return [];
      if (value is List) return List<String>.from(value);
      if (value is String) return [value];
      return [];
    }

    return PropertyModel(
    id: json['_id'] ?? '',
    type: json['type'] ?? '',
    available: json['available'] ?? false,
    guestNumber: json['guestNumber'] ?? 0,
    bedrooms: json['bedrooms'] ?? 0,
    bathrooms: json['bathrooms'] ?? 0,
    beds: json['beds'] ?? 0,
    address: json['address'] ?? '',
    details: json['details'] ?? '',
      tags: parseStringOrList(json['tags']),
    pricePerNight: json['pricePerNight'] ?? 0,
      availableDates: parseStringOrList(json['availableDates']),
    maxDays: json['maxDays'] ?? 0,
      ownershipContract: parseStringOrList(json['ownershipContract']),
      facilityLicense: parseStringOrList(json['facilityLicense']),
      medias: parseStringOrList(json['medias']),
  );
  }

  Future<FormData> create() async {
    final formData = FormData();
    
    // Add basic fields
    formData.fields.addAll([
      MapEntry('type', type),
      MapEntry('available', available.toString()),
      MapEntry('guestNumber', guestNumber.toString()),
      MapEntry('bedrooms', bedrooms.toString()),
      MapEntry('bathrooms', bathrooms.toString()),
      MapEntry('beds', beds.toString()),
      MapEntry('address', address),
      MapEntry('details', details),
      MapEntry('pricePerNight', pricePerNight.toString()),
      MapEntry('maxDays', maxDays.toString()),
    ]);

    // Add arrays
    for (final tag in tags) {
      formData.fields.add(MapEntry('tags[]', tag));
    }
    for (final date in availableDates) {
      formData.fields.add(MapEntry('availableDates[]', date));
    }

    // Add files with proper content types
    try {
      // Add ownership contract files
      for (final filePath in ownershipContract) {
        if (filePath.isNotEmpty) {
          final file = File(filePath);
          if (await file.exists()) {
            formData.files.add(MapEntry(
              'ownershipContract',
              await MultipartFile.fromFile(
                filePath,
                filename: filePath.split('/').last,
                contentType: MediaType('application', 'pdf'),
              ),
            ));
          }
        }
      }

      // Add facility license files
      for (final filePath in facilityLicense) {
        if (filePath.isNotEmpty) {
          final file = File(filePath);
          if (await file.exists()) {
            formData.files.add(MapEntry(
              'facilityLicense',
              await MultipartFile.fromFile(
                filePath,
                filename: filePath.split('/').last,
                contentType: MediaType('application', 'pdf'),
              ),
            ));
          }
        }
      }

      // Add media files
      for (final filePath in medias) {
        if (filePath.isNotEmpty) {
          final file = File(filePath);
          if (await file.exists()) {
            final extension = filePath.split('.').last.toLowerCase();
            final contentType = extension == 'png' ? 'png' : 'jpeg';
            formData.files.add(MapEntry(
              'medias',
              await MultipartFile.fromFile(
                filePath,
                filename: filePath.split('/').last,
                contentType: MediaType('image', contentType),
              ),
            ));
          }
        }
      }
    } catch (e) {
      debugPrint('Error preparing files: $e');
      rethrow;
    }

    return formData;
  }

  PropertyModel copyWith({
    String? id,
    String? type,
    bool? available,
    int? guestNumber,
    int? bedrooms,
    int? bathrooms,
    int? beds,
    String? address,
    String? details,
    List<String>? tags,
    int? pricePerNight,
    List<String>? availableDates,
    int? maxDays,
    List<String>? ownershipContract,
    List<String>? facilityLicense,
    List<String>? medias,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      type: type ?? this.type,
      facilityLicense: facilityLicense ?? this.facilityLicense,
      available: available ?? this.available,
      guestNumber: guestNumber ?? this.guestNumber,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      beds: beds ?? this.beds,
      address: address ?? this.address,
      details: details ?? this.details,
      tags: tags ?? this.tags,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      availableDates: availableDates ?? this.availableDates,
      maxDays: maxDays ?? this.maxDays,
      ownershipContract: ownershipContract ?? this.ownershipContract,
      medias: medias ?? this.medias,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    available,
    guestNumber,
    bedrooms,
    bathrooms,
    beds,
    address,
    details,
    tags,
    pricePerNight,
    availableDates,
    maxDays,
    ownershipContract,
    medias,
    facilityLicense,
  ];
}
