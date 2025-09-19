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
  bool _isRefreshing = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    final isMultipart = options.data is FormData;
    final accessToken = _cacheService.storage.getString(AppConst.accessToken);
    print(accessToken);
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
    } else if (response.statusCode == 401 && !response.requestOptions.path.contains(ApiConstance.refreshToken)) {
      // Only attempt refresh if this is not already a refresh token request
      if (!_isRefreshing) {
        try {
          _isRefreshing = true;
          final refreshToken = _cacheService.storage.getString(AppConst.refreshToken);
          if (refreshToken == null || refreshToken.isEmpty) {
            _isRefreshing = false;
            return handler.next(response);
          }
          final accessToken = await getAccessToken(refreshToken);
          final opts = response.requestOptions;
          opts.headers['Authorization'] = 'Bearer $accessToken';
          final cloneReq = await _dio.fetch(opts);
          _isRefreshing = false;
          return handler.resolve(cloneReq);
        } catch (e) {
          _isRefreshing = false;
          await _cacheService.storage.remove(AppConst.accessToken);
          await _cacheService.storage.remove(AppConst.refreshToken);
          return handler.next(response);
        }
      }
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !err.requestOptions.path.contains(ApiConstance.refreshToken)) {
      // Only attempt refresh if this is not already a refresh token request
      if (!_isRefreshing) {
        try {
          _isRefreshing = true;
          final refreshToken = _cacheService.storage.getString(AppConst.refreshToken);
          if (refreshToken == null || refreshToken.isEmpty) {
            _isRefreshing = false;
            return handler.next(err);
          }
          final accessToken = await getAccessToken(refreshToken);
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $accessToken';
          final cloneReq = await _dio.fetch(opts);
          _isRefreshing = false;
          return handler.resolve(cloneReq);
        } catch (e) {
          _isRefreshing = false;
          await _cacheService.storage.remove(AppConst.accessToken);
          await _cacheService.storage.remove(AppConst.refreshToken);
          return handler.next(err);
        }
      }
    }
    super.onError(err, handler);
  }

  Future<String> getAccessToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        ApiConstance.refreshToken, 
        data: {AppConst.refreshToken: refreshToken},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ),
      );
      
      if (response.statusCode == 200 && response.data != null && response.data['success']) {
        final accessToken = response.data['data']['accessToken'];
        final newRefreshToken = response.data['data']['refreshToken'];
        
        if (accessToken != null) {
          await _cacheService.storage.setString(AppConst.accessToken, accessToken);
        }
        if (newRefreshToken != null) {
          await _cacheService.storage.setString(AppConst.refreshToken, newRefreshToken);
        }
        
        return accessToken;
      } else {
        throw Exception('Failed to refresh token: ${response.data?['message'] ?? 'Unknown error'}');
      }
    } on DioException catch (e) {
      debugPrint('Refresh token error: ${e.message}');
      throw Exception('Refresh token failed: ${e.message}');
    }
  }
}
