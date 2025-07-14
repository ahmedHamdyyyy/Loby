import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../config/constants/constance.dart';
import '../../../../core/services/api_services.dart';
import '../../models/property_model.dart';

class PropertiesData {
  const PropertiesData(this._apiService);
  final ApiService _apiService;

  Future<PropertyModel> createProperty(PropertyModel property) async {
    final response = await _apiService.dio.post(ApiConstance.createProperty, data: 
    await property.create());
    if (!(response.data['success'] ?? false) || response.data['data'] == null) {
      throw DioException(requestOptions: response.requestOptions, response: response,
       error: response.data['error']);
    }
    return property.copyWith(id: response.data['data'][AppConst.id].toString());
  }

  Future<void> updateProperty(PropertyModel property) async {
    final response = await _apiService.dio.put(ApiConstance.updateProperty(property.id), data: property.create());
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }

  Future<void> deleteProperty(String id) async {
    final response = await _apiService.dio.delete(ApiConstance.updateProperty(id));
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }

  Future<List<CustomPropertyModel>> getProperties() async {
    final response = await _apiService.dio.get(ApiConstance.createProperty);
    if (!(response.data['success'] ?? false) || response.data['data']['data'] == null) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
    return (response.data['data']['data'] as List).map((e) => CustomPropertyModel.fromJson(e)).toList();
  }

  Future<PropertyModel> getProperty(String id) async {
    final response = await _apiService.dio.get(ApiConstance.getProperty(id));
    if (!(response.data['success'] ?? false) || response.data['data'] == null) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
    return PropertyModel.fromJson(response.data['data']);
  }
}
