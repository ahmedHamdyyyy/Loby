import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../models/property.dart';

class PropertiesData {
  const PropertiesData(this._apiService);
  final ApiService _apiService;

  Future<PropertyModel> createProperty(PropertyModel property) async {
    Response? response;
    try {
      print('Creating FormData...');
      final formData = await property.toJson();
      print('FormData created successfully');

      // Let's try a simple test first without files
      print('Testing simple request without files...');
      try {
        final testFormData = FormData();
        testFormData.fields.addAll([
          MapEntry('type', property.type.name),
          MapEntry('available', property.available.toString()),
          MapEntry('guestNumber', property.guestNumber.toString()),
        ]);

        final testResponse = await _apiService.dio.post(
          ApiConstance.createProperty,
          data: testFormData,
          options: Options(receiveTimeout: const Duration(seconds: 30), sendTimeout: const Duration(seconds: 30)),
        );
        print('Simple test request successful: ${testResponse.statusCode}');
      } catch (testError) {
        print('Simple test request failed: $testError');
        if (testError is DioException) {
          print('Test error type: ${testError.type}');
          print('Test error response: ${testError.response}');
        }
      }

      print('About to make POST request to: ${ApiConstance.createProperty}');
      print('Base URL: ${_apiService.dio.options.baseUrl}');
      print('Full URL: ${_apiService.dio.options.baseUrl}${ApiConstance.createProperty}');

      response = await _apiService.dio.post(
        ApiConstance.createProperty,
        data: formData,
        options: Options(
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          responseType: ResponseType.json,
        ),
      );

      print('Response received successfully');
      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response data type: ${response.data.runtimeType}');

      final data = response.data;

      // Check if response is a string (likely HTML error page)
      if (data is String) {
        print('Raw string response: ${data.length > 500 ? data.substring(0, 500) + "..." : data}');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error:
              'Server returned HTML instead of JSON. Status: ${response.statusCode}. This usually indicates a server error or wrong endpoint.',
        );
      }

      // Check if response is a JSON map
      if (data is! Map<String, dynamic>) {
        print('Unexpected response type: ${data.runtimeType}');
        print('Response content: $data');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Unexpected response format (not JSON map). Received: ${data.runtimeType}',
        );
      }

      print('Parsed JSON response: $data');

      if (!(data['success'] ?? false) || data['data'] == null) {
        print('API returned success=false or no data');
        throw _dioError(response);
      }

      return PropertyModel.fromJson(data['data']);
    } catch (e) {
      print('Exception in createProperty: $e');
      print('Exception type: ${e.runtimeType}');
      if (e is DioException) {
        print('DioException details:');
        print('  Type: ${e.type}');
        print('  Message: ${e.message}');
        print('  Error: ${e.error}');
        print('  Response: ${e.response}');
        print('  RequestOptions: ${e.requestOptions.uri}');
        rethrow;
      }

      // Create a proper DioException for other errors
      throw DioException(
        requestOptions: response?.requestOptions ?? RequestOptions(path: ApiConstance.createProperty),
        response: response,
        error: 'Failed to parse response: $e',
      );
    }
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
    print(response.data);

    if (!(response.data['success'] ?? false) || response.data['data'] == null) throw _dioError(response);
    return PropertyModel.fromJson(response.data['data']['property']);
  }

  DioException _dioError(Response<dynamic> response) {
    final dynamic raw = response.data;
    dynamic errorMsg;
    if (raw is Map<String, dynamic>) {
      errorMsg = raw['error'] ?? raw['message'] ?? raw.toString();
    } else {
      errorMsg = raw?.toString() ?? 'Unknown error';
    }
    return DioException(requestOptions: response.requestOptions, response: response, error: errorMsg);
  }
}
