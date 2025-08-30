import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location_package;
import 'package:geocoding/geocoding.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final location_package.Location _location = location_package.Location();

  /// Get current user location
  Future<LatLng?> getCurrentLocation() async {
    try {
      // Check if location service is enabled
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      // Check location permission
      location_package.PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == location_package.PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != location_package.PermissionStatus.granted) {
          return null;
        }
      }

      // Get current location
      location_package.LocationData locationData = await _location.getLocation();
      return LatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  /// Calculate distance between two points in kilometers
  double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    double lat1 = point1.latitude * (pi / 180);
    double lat2 = point2.latitude * (pi / 180);
    double deltaLat = (point2.latitude - point1.latitude) * (pi / 180);
    double deltaLng = (point2.longitude - point1.longitude) * (pi / 180);
    
    double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  /// Format coordinates to readable string
  String formatCoordinates(LatLng position) {
    String lat = position.latitude >= 0 ? 'N' : 'S';
    String lng = position.longitude >= 0 ? 'E' : 'W';
    
    return '${position.latitude.abs().toStringAsFixed(6)}° $lat, '
           '${position.longitude.abs().toStringAsFixed(6)}° $lng';
  }

  /// Get address from coordinates (Reverse Geocoding)
  Future<String> getAddressFromCoordinates(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        
        // Build a comprehensive address string
        List<String> addressParts = [];
        
        if (place.street != null && place.street!.isNotEmpty) {
          addressParts.add(place.street!);
        }
        
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          addressParts.add(place.subLocality!);
        }
        
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressParts.add(place.locality!);
        }
        
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          addressParts.add(place.administrativeArea!);
        }
        
        if (place.country != null && place.country!.isNotEmpty) {
          addressParts.add(place.country!);
        }
        
        if (addressParts.isNotEmpty) {
          return addressParts.join(', ');
        }
      }
      
      // Fallback to coordinates if no address found
      return formatCoordinates(position);
    } catch (e) {
      print('Error getting address from coordinates: $e');
      // Fallback to coordinates if geocoding fails
      return formatCoordinates(position);
    }
  }

  /// Get detailed place information
  Future<Map<String, String>> getPlaceDetails(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        
        return {
          'street': place.street ?? '',
          'subLocality': place.subLocality ?? '',
          'locality': place.locality ?? '',
          'administrativeArea': place.administrativeArea ?? '',
          'postalCode': place.postalCode ?? '',
          'country': place.country ?? '',
          'coordinates': formatCoordinates(position),
        };
      }
      
      return {'coordinates': formatCoordinates(position)};
    } catch (e) {
      print('Error getting place details: $e');
      return {'coordinates': formatCoordinates(position)};
    }
  }

  /// Get default camera position (Riyadh, Saudi Arabia)
  CameraPosition getDefaultCameraPosition() {
    return const CameraPosition(
      target: LatLng(24.7136, 46.6753), // Riyadh coordinates
      zoom: 15.0,
    );
  }

  /// Create a custom marker
  Marker createMarker({
    required String markerId,
    required LatLng position,
    bool draggable = false,
    Function(LatLng)? onDragEnd,
  }) {
    return Marker(
      markerId: MarkerId(markerId),
      position: position,
      draggable: draggable,
      onDragEnd: onDragEnd,
    );
  }
} 