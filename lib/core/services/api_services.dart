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

      dio.interceptors.add(_Interceptor(dio, _cacheServices));
      return true;
    } on DioException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
class _Interceptor extends Interceptor {
  final Dio dio;
  final CacheService _cacheService;

  _Interceptor(this.dio, this._cacheService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken =  _cacheService.storage.getString(AppConst.accessToken);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }
 @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    if (response.data is Map && response.data['data'] is Map && response.data['data']['accessToken'] != null && response.data['data']['refreshToken'] != null) {
      final accessToken = response.data['data']['accessToken'];
      final refreshToken = response.data['data']['refreshToken'];
      await _cacheService.storage.setString(AppConst.accessToken, accessToken);
      await _cacheService.storage.setString(AppConst.refreshToken, refreshToken);
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {

      final refreshToken =  _cacheService.storage.getString(ApiConstance.refreshToken);
      if (refreshToken == null) return handler.next(err);
      try {
        final refreshResponse = await dio.post(ApiConstance.refreshToken, data: {'refreshToken': refreshToken});
        final newAccessToken = refreshResponse.data['data']['accessToken'];
        final newRefreshToken = refreshResponse.data['data']['refreshToken'];
        await _cacheService.storage.setString(ApiConstance.refreshToken, newRefreshToken);
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newAccessToken';
        final response = await dio.fetch(opts);
        return handler.resolve(response);
      } catch (e) {
        print(e.toString());
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}