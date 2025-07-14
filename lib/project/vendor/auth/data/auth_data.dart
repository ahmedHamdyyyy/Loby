import 'package:dio/dio.dart';

import '../../../../../config/constants/api_constance.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../core/services/api_services.dart';
import '../../../../../core/services/cach_services.dart';
import '../../models/user_model.dart';

class AuthData {
  const AuthData(this._apiServices, this._cacheServices);
  final ApiService _apiServices;
  final CacheService _cacheServices;

  Future<UserModel> signup({required UserModel user}) async {
    final response = await _apiServices.dio.post(ApiConstance.signup, data: FormData.fromMap(await user.signUp()));
    final id = response.data['data']['user'][AppConst.id];
    final token = response.data['data']['token'];
    if (_hasException(response) || id == null || token == null) throw _responseException(response);
    final addedUser = user.copyWith(id: id);
    await _cacheServices.storage.setString(AppConst.token, token);
    await _cacheServices.storage.setString(AppConst.id, id);
    await _saveUser(addedUser);
    return addedUser;
  }

  Future<UserModel> signin({required String email, required String password}) async {
    final loginData = {AppConst.email: email, AppConst.password: password};
    final response = await _apiServices.dio.post(ApiConstance.signin, data: loginData);
    final userData = response.data['data']['user'];
    final token = response.data['data']['token'];
    if (_hasException(response) || userData == null || token == null) throw _responseException(response);
    final user = UserModel.fromJson(userData);
    await _cacheServices.storage.setString(AppConst.token, token);
    await _cacheServices.storage.setString(AppConst.id, user.id);
    await _saveUser(user);
    return user;
  }
  Future<void> signout() async {
    await _cacheServices.storage.remove(AppConst.token);
    await _cacheServices.storage.remove(AppConst.id);
    await _cacheServices.storage.remove(AppConst.user);
  }

  Future<void> _saveUser(UserModel user) async => await _cacheServices.storage.setString(AppConst.user, user.toCache());

  Exception _responseException(Response response) =>
      DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);

  bool _hasException(Response response) =>
      ![200, 201, 202, 203].contains(response.statusCode) || !(response.data['success'] ?? false);
}
