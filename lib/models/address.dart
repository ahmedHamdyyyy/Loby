import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String formattedAddress;
  final String city;
  final String state;
  final String country;
  final double latitude;
  final double longitude;

  const Address({
    required this.formattedAddress,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  static const initial = Address(formattedAddress: '', city: '', state: '', country: '', latitude: 0, longitude: 0);

  Map<String, dynamic> toJson() {
    return {
      'formattedAddress': formattedAddress,
      'city': city,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      formattedAddress: json['formattedAddress'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [formattedAddress, city, state, country, latitude, longitude];
}
