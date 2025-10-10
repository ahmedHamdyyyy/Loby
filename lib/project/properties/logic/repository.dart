import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../models/property.dart';
import 'data.dart';

class PropertiesRepository {
  const PropertiesRepository(this._propertiesData);
  final PropertiesData _propertiesData;

  Future<PropertyModel> createProperty(PropertyModel property) async {
    try {
      return await _propertiesData.createProperty(property);
    } on DioException catch (e, s) {
      debugPrint('DioException: $e');
      debugPrint('DioException message: ${e.message}');
      debugPrint('DioException error: ${e.error}');
      debugPrint('DioException response: ${e.response}');
      debugPrint('DioException response data: ${e.response?.data}');
      debugPrint('DioException response status: ${e.response?.statusCode}');
      debugPrint('DioException stack trace: $s');

      // Handle different error scenarios
      if (e.response?.data is String) {
        final htmlContent = e.response?.data as String;
        if (htmlContent.contains('<html>') || htmlContent.contains('<!DOCTYPE')) {
          throw Exception(
            'Server error: The server returned an HTML page instead of JSON. This usually indicates a server-side error or incorrect endpoint. Status: ${e.response?.statusCode}',
          );
        }
        throw Exception(
          'Server returned unexpected text response: ${htmlContent.length > 100 ? htmlContent.substring(0, 100) + "..." : htmlContent}',
        );
      }

      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response?.data as Map<String, dynamic>;
        final errorMessage = responseData['error'] ?? responseData['message'];
        if (errorMessage != null) {
          if (errorMessage is List) {
            throw Exception(errorMessage.join(', '));
          } else {
            throw Exception(errorMessage.toString());
          }
        }
      }

      if (e.response?.statusCode != null) {
        switch (e.response!.statusCode) {
          case 400:
            throw Exception('Bad request: Please check the property data and try again.');
          case 401:
            throw Exception('Unauthorized: Please login again.');
          case 403:
            throw Exception('Forbidden: You don\'t have permission to create properties.');
          case 404:
            throw Exception('Not found: The API endpoint was not found.');
          case 413:
            throw Exception('File too large: One or more files exceed the size limit.');
          case 422:
            throw Exception('Validation error: Please check all required fields.');
          case 500:
            throw Exception('Server error: Please try again later.');
          default:
            throw Exception('Server error with status code: ${e.response?.statusCode}');
        }
      } else if (e.message?.contains('connection timeout') ?? false) {
        throw Exception('Connection timeout. Please check your internet connection and try again.');
      } else if (e.message?.contains('SocketException') ?? false) {
        throw Exception('Network error. Please check your internet connection.');
      }

      throw Exception('Failed to create property: ${e.error ?? e.message ?? 'Unknown error'}');
    } catch (e, s) {
      debugPrint('Unexpected error: $e');
      debugPrint('Stack trace: $s');
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<PropertyModel> updateProperty(PropertyModel property) async {
    try {
      return await _propertiesData.updateProperty(property);
    } on DioException catch (e, s) {
      debugPrint('DioException: ${e.response?.data}');
      debugPrint('Stack trace: $s');
      if (e.response?.data['error'] != null) {
        final errorMessage = e.response?.data['error'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else {
          throw Exception(errorMessage.toString());
        }
      } else if (e.response?.statusCode != null) {
        throw Exception('Server error with status code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to update property: ${e.message}');
    } catch (e, s) {
      debugPrint('Unexpected error: $e');
      debugPrint('Stack trace: $s');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> deleteProperty(String id) async {
    try {
      return await _propertiesData.deleteProperty(id);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) {
        final errorMessage = e.response?.data['error'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else {
          throw Exception(errorMessage.toString());
        }
      } else if (e.response?.statusCode != null) {
        throw Exception('Server error with status code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to delete property: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<List<CustomPropertyModel>> getProperties() async {
    try {
      return await _propertiesData.getProperties();
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) {
        final errorMessage = e.response?.data['error'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else {
          throw Exception(errorMessage.toString());
        }
      } else if (e.response?.statusCode != null) {
        throw Exception('Server error with status code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to get properties: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<PropertyModel> getProperty(String id) async {
    try {
      return await _propertiesData.getProperty(id);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) {
        final errorMessage = e.response?.data['error'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else {
          throw Exception(errorMessage.toString());
        }
      } else if (e.response?.statusCode != null) {
        throw Exception('Server error with status code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to get properties: ${e.message}');
    } catch (e, s) {
      debugPrint('Unexpected error: $e');
      debugPrint('Stack trace: $s');
      throw Exception('An unexpected error occurred');
    }
  }
}
