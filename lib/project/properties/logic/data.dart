import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../models/property_model.dart';

class PropertiesData {
  const PropertiesData(this._apiService);
  final ApiService _apiService;

  Future<PropertyModel> createProperty(PropertyModel property) async {
    final response = await _apiService.dio.post(ApiConstance.createProperty, data: await property.toJson());
    if (!(response.data['success'] ?? false) || response.data['data'] == null) throw _dioError(response);
    return PropertyModel.fromJson(response.data['data']);
  }

  Future<PropertyModel> updateProperty(PropertyModel property) async {
    final response = await _apiService.dio.put(ApiConstance.updateProperty(property.id), data: await property.toJson());
    if (!(response.data['success'] ?? false)) throw _dioError(response);
    return PropertyModel.fromJson(response.data['data']);
  }

  Future<void> deleteProperty(String id) async {
    final response = await _apiService.dio.delete(ApiConstance.deleteProperty(id));
    if (!(response.data['success'] ?? false)) throw _dioError(response);
  }

  Future<List<CustomPropertyModel>> getProperties() async {
    final response = await _apiService.dio.get(ApiConstance.getProperties);
    if (!(response.data['success'] ?? false) || response.data['data']['data'] == null) throw _dioError(response);
    return (response.data['data']['data'] as List).map((e) => CustomPropertyModel.fromJson(e)).toList();
  }

  Future<PropertyModel> getProperty(String id) async {
    final response = await _apiService.dio.get(ApiConstance.getProperty(id));
    if (!(response.data['success'] ?? false) || response.data['data'] == null) throw _dioError(response);
    return PropertyModel.fromJson(response.data['data']);
  }

  DioException _dioError(Response<dynamic> response) {
    return DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
  }
}
