import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/property_model.dart';
import 'data.dart';

class PropertiesRespository {
  const PropertiesRespository(this._propertiesData);
  final PropertiesData _propertiesData;

  Future<PropertyModel> createProperty(PropertyModel property) async {
    try {
      return await _propertiesData.createProperty(property);
    } on DioException catch (e) {
      debugPrint('DioException: ${e}');
      debugPrint('DioException: ${e.response?.data}');
      debugPrint('DioException: ${e.response}');
      debugPrint('DioException: ${e.stackTrace}');
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
      throw Exception('Failed to create property: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> updateProperty(PropertyModel property) async {
    try {
      return await _propertiesData.updateProperty(property);
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
      throw Exception('Failed to update property: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
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
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}
