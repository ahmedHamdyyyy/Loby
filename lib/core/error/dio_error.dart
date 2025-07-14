import 'package:dio/dio.dart';

class ApiExceptionHandler {
  static String handle(DioException exception) {
    try {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return 'Connection timed out. Please check your internet connection.';
        case DioExceptionType.badCertificate:
          return 'Invalid security certificate. Please try again later.';
        case DioExceptionType.badResponse:
          return _handleBadResponse(exception.response);
        case DioExceptionType.cancel:
          return 'Request was cancelled';
        case DioExceptionType.connectionError:
          return 'Unable to connect to server. Please check your internet connection.';
        case DioExceptionType.unknown:
          if (exception.error != null) {
            return exception.error.toString();
          }
          return 'An unexpected error occurred';
      }
    } catch (e) {
      return 'An error occurred while processing your request';
    }
  }

  static String _handleBadResponse(Response? response) {
    if (response == null || response.statusCode == null) {
      return 'No response received from server';
    }

    switch (response.statusCode) {
      case 400:
        return _parseErrorMessage(response.data) ?? 'Invalid request';
      case 401:
        return 'Please login to continue';
      case 402:
        return 'Payment is required to access this resource';
      case 403:
        return 'You do not have permission to access this resource';
      case 404:
        return 'The requested resource was not found';
      case 422:
        return _parseErrorMessage(response.data) ?? 'Invalid input data';
      case 500:
        return 'Server error occurred. Please try again later.';
      case 503:
        return 'Service temporarily unavailable. Please try again later.';
      default:
        return 'Error ${response.statusCode}: ${response.statusMessage ?? "Unknown error"}';
    }
  }

  static String? _parseErrorMessage(dynamic data) {
    if (data == null) return null;
    try {
      if (data is Map<String, dynamic>) {
        return data['message'] ?? data['error'];
      } else if (data is String) {
        return data;
      }
    } catch (_) {
      return null;
    }
    return null;
  }
  }
