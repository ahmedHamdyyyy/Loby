import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../config/constants/api_constance.dart';
import '../../config/constants/constance.dart';
import 'cach_services.dart';

class ApiService {
  ApiService(this._cacheServices);
  final CacheService _cacheServices;
  late Dio dio;

  Future<bool> init() async {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: ApiConstance.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          validateStatus: (status) => status! < 500,
          headers: {'Accept': '*/*', 'Connection': 'keep-alive'}, //'Content-Type': 'application/json',
        ),
      );

      dio.interceptors.add(_ApiInterceptor(_cacheServices, dio));
      return true;
    } on DioException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

class _ApiInterceptor extends InterceptorsWrapper {
  _ApiInterceptor(this._cacheService, this.dio);
  final CacheService _cacheService;
  final Dio dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    final isMultipart = options.data is FormData;
    options.headers['Content-Type'] = isMultipart ? 'multipart/form-data' : 'application/json';
    // if (isMultipart) options.headers['Accept-Encoding'] = 'gzip, deflate, br';

    final token = _cacheService.storage.getString(AppConst.token);
    if (token != null && token.isNotEmpty) options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    if (response.data is Map && response.data['data'] is Map && response.data['data']['token'] != null) {
      final token = response.data['data']['token'];
      await _cacheService.storage.setString(AppConst.token, token);
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 401) {
      final token = _cacheService.storage.getString(AppConst.token);
      if (token != null) {
        final response = await dio.get(
          ApiConstance.refreshToken,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        if (response.data['data']['token'] != null) {
          await _cacheService.storage.setString(AppConst.token, response.data['data']['token']);
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer ${response.data['data']['token']}';
          final retryResponse = await dio.request(
            options.path,
            data: options.data,
            queryParameters: options.queryParameters,
            options: Options(method: options.method, headers: options.headers, responseType: options.responseType),
          );
          return handler.resolve(retryResponse);
        }
      }
    }
    return handler.next(err);
  }
}
