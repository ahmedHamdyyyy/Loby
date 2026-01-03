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
          final serverMessage = _parseErrorMessage(exception.response?.data);
          if (serverMessage != null && serverMessage.trim().isNotEmpty) {
            return serverMessage.trim();
          }
          if (exception.error != null) return exception.error.toString();
          return 'An unexpected error occurred';
      }
    } catch (e) {
      return 'An error occurred while processing your request';
    }
  }

  static String _handleBadResponse(Response? response) {
    final serverMessage = _parseErrorMessage(response?.data);
    if (serverMessage != null && serverMessage.trim().isNotEmpty) {
      return serverMessage.trim();
    }

    if (response == null || response.statusCode == null) {
      return 'No response received from server';
    }

    switch (response.statusCode) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Please login to continue';
      case 402:
        return 'Payment is required to access this resource';
      case 403:
        return 'You do not have permission to access this resource';
      case 404:
        return 'The requested resource was not found';
      case 409:
        return 'Conflict detected. The resource state changed.';
      case 410:
        return 'The requested resource is no longer available.';
      case 415:
        return 'Unsupported media type in the request.';
      case 422:
        return 'Invalid input data. Please review and try again.';
      case 429:
        return 'Too many requests. Please wait and try again.';
      case 500:
        return 'Server error occurred. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service temporarily unavailable. Please try again later.';
      case 504:
        return 'Server timeout. Please try again later.';
      default:
        return 'Error ${response.statusCode}: ${response.statusMessage ?? "Unknown error"}';
    }
  }

  static String? _parseErrorMessage(dynamic data) {
    if (data == null) return null;
    try {
      if (data is Map) {
        final keys = ['message', 'error', 'detail', 'description', 'title'];
        for (final key in keys) {
          final value = data[key];
          final msg = _valueToString(value);
          if (msg != null && msg.trim().isNotEmpty) {
            return msg.trim();
          }
        }

        final errors = data['errors'];
        if (errors is Map) {
          final messages = <String>[];
          errors.forEach((_, v) {
            final msg = _valueToString(v);
            if (msg != null && msg.trim().isNotEmpty) {
              messages.add(msg.trim());
            }
          });
          if (messages.isNotEmpty) {
            return messages.join('. ');
          }
        }

        for (final containerKey in ['data', 'error']) {
          final nested = data[containerKey];
          final msg = _parseErrorMessage(nested);
          if (msg != null && msg.trim().isNotEmpty) {
            return msg.trim();
          }
        }
      } else if (data is List) {
        final messages = <String>[];
        for (final item in data) {
          final msg = _valueToString(item);
          if (msg != null && msg.trim().isNotEmpty) {
            messages.add(msg.trim());
          }
        }
        if (messages.isNotEmpty) {
          return messages.join('. ');
        }
      } else if (data is String) {
        return data;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  static String? _valueToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is List) {
      final parts =
          value.map((e) => _valueToString(e)).whereType<String>().map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
      if (parts.isNotEmpty) return parts.join('. ');
      return null;
    }
    if (value is Map) {
      return _parseErrorMessage(value);
    }
    return value.toString();
  }
}
