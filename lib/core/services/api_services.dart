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
  _ApiInterceptor(this._cacheService, this._dio);
  final CacheService _cacheService;
  final Dio _dio;
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
    debugPrint(response.data.toString());
    if (response.data != null && response.data['success'] == true) {
      final data = response.data['data'] ?? {};
      final accessToken = data[AppConst.accessToken];
      final refreshToken = data[AppConst.refreshToken];
      if (accessToken != null) await _cacheService.storage.setString(AppConst.accessToken, accessToken);
      if (refreshToken != null) await _cacheService.storage.setString(AppConst.refreshToken, refreshToken);
    }
    if (response.statusCode == 401) {
      if (_counter == 2) {
        await _clearTokens();
        return handler.next(response);
      }
      _counter++;
      return await _handleUnauthorized(response, handler);
    }
    _counter = 0;
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (_counter == 2) {
        await _clearTokens();
        return handler.next(err);
      }
      _counter++;
      return await _handleUnauthorizedError(err, handler);
    }
    _counter = 0;
    super.onError(err, handler);
  }

  Future<void> _handleUnauthorized(Response response, ResponseInterceptorHandler handler) async {
    _counter++;
    try {
      final refreshToken = _cacheService.storage.getString(AppConst.refreshToken);
      if (refreshToken == null || refreshToken.isEmpty) return handler.next(response);
      final accessToken = await getAccessToken(refreshToken);
      await _cacheService.storage.setString(AppConst.accessToken, accessToken);
      final opts = response.requestOptions;
      opts.headers['Authorization'] = 'Bearer $accessToken';
      final cloneReq = await _dio.fetch(opts);
      return handler.resolve(cloneReq);
    } catch (e) {
      await _clearTokens();
      return handler.next(response);
    }
  }

  Future<void> _handleUnauthorizedError(DioException err, ErrorInterceptorHandler handler) async {
    if (_counter == 2) {
      await _clearTokens();
      return handler.next(err);
    }
    _counter++;
    try {
      final refreshToken = _cacheService.storage.getString(AppConst.refreshToken);
      if (refreshToken == null || refreshToken.isEmpty) return handler.next(err);

      final accessToken = await getAccessToken(refreshToken);
      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $accessToken';
      final cloneReq = await _dio.fetch(opts);
      return handler.resolve(cloneReq);
    } catch (e) {
      await _clearTokens();
      return handler.next(err);
    }
  }

  Future<void> _clearTokens() async {
    await _cacheService.storage.remove(AppConst.accessToken);
    await _cacheService.storage.remove(AppConst.refreshToken);
  }

  Future<String> getAccessToken(String refreshToken) async {
    final response = await _dio.post(ApiConstance.refreshToken, data: {AppConst.refreshToken: refreshToken});
    final accessToken = response.data['data']['accessToken'];
    await _cacheService.storage.setString(AppConst.accessToken, accessToken);
    return accessToken;
  }
}
