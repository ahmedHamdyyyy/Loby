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
          headers: {'Accept': '*/*', 'Content-Type': 'application/json', 'Connection': 'keep-alive'},
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
  int _counter = 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    final isMultipart = options.data is FormData;
    final accessToken = _cacheService.storage.getString(AppConst.accessToken);
    options.headers['Content-Type'] = isMultipart ? 'multipart/form-data' : 'application/json';
    if (isMultipart) options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    if (accessToken != null && accessToken.isNotEmpty) options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    if ([ApiConstance.signin, ApiConstance.signup, ApiConstance.resetpassword].contains(response.requestOptions.path)) {
      if (response.data != null && response.data['success']) {
        final accessToken = (response.data['data'] ?? {})['accessToken'];
        final refreshToken = (response.data['data'] ?? {})['refreshToken'];
        if (accessToken != null) await _cacheService.storage.setString(AppConst.accessToken, accessToken);
        if (refreshToken != null) await _cacheService.storage.setString(AppConst.refreshToken, refreshToken);
      }
    }
    if (response.statusCode == 401) {
      if (_counter > 5) return handler.next(response);
      _counter++;
      final refreshToken = _cacheService.storage.getString(AppConst.refreshToken);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        final response = await dio.post(ApiConstance.refreshToken, data: {AppConst.refreshToken: refreshToken});
        if (response.statusCode == 200) {
          final accessToken = (response.data['data'] ?? {})['accessToken'];
          if (accessToken != null) {
            await _cacheService.storage.setString(AppConst.accessToken, accessToken);
            await dio.request(
              response.requestOptions.path,
              data: response.requestOptions.data,
              options: Options(headers: response.requestOptions.headers..addAll({'Authorization': 'Bearer $accessToken'})),
            );
            return;
          }
        }
      }
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    debugPrint(err.response?.data.toString());
    debugPrint(err.message);
    debugPrint(err.error.toString());
    if (err.response?.statusCode == 401) {
      if (_counter > 5) return handler.next(err);
      _counter++;
      final refreshToken = _cacheService.storage.getString(AppConst.refreshToken);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        final response = await dio.post(ApiConstance.refreshToken, data: {AppConst.refreshToken: refreshToken});
        if (response.statusCode == 200) {
          final accessToken = (response.data['data'] ?? {})['accessToken'];
          if (accessToken != null) {
            await _cacheService.storage.setString(AppConst.accessToken, accessToken);
            await dio.request(
              err.requestOptions.path,
              data: err.requestOptions.data,
              options: Options(headers: err.requestOptions.headers..addAll({'Authorization': 'Bearer $accessToken'})),
            );
            return;
          }
        }
      }
    }
    _counter = 0;
    return handler.next(err);
  }
}