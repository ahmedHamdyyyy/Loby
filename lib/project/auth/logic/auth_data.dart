import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

import '../../../config/constants/api_constance.dart';
import '../../../config/constants/constance.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/cach_services.dart';
import '../../../models/user.dart';

class AuthData {
  const AuthData(this._apiServices, this._cacheServices);
  final ApiService _apiServices;
  final CacheService _cacheServices;

  Future<String> signout() async {
    final response = await _apiServices.dio.post(
      ApiConstance.logout,
      data: {AppConst.refreshToken: _cacheServices.storage.getString(AppConst.refreshToken)},
    );
    if (response.data['success'] == false) throw _responseException(response);
    await _cacheServices.storage.remove(AppConst.accessToken);
    await _cacheServices.storage.remove(AppConst.refreshToken);
    await _cacheServices.storage.remove(AppConst.vendorRole);
    return response.data['data']['message'];
  }

  Future<UserModel> signup({required UserModel user}) async {
    final mapData = await user.signUp();
    final response = await _apiServices.dio.post(ApiConstance.signup, data: mapData);
    final data = response.data['data'];
    if (data == null || data['user'] == null) throw _responseException(response);
    final addedUser = user.copyWith(id: data['user'][AppConst.id], profilePicture: data['user'][AppConst.profilePicture]);
    await _cacheServices.storage.setString(AppConst.accessToken, data['accessToken']);
    await _cacheServices.storage.setString(AppConst.refreshToken, data['refreshToken']);
    return addedUser;
  }

  Future<UserModel> signin({required String email, required String password}) async {
    final loginData = {AppConst.email: email, AppConst.password: password};
    final response = await _apiServices.dio.post(ApiConstance.signin, data: loginData);
    final data = response.data['data'];
    if (data == null || data['user'] == null) throw _responseException(response);
    final user = UserModel.fromJson(data['user']);
    await _cacheServices.storage.setString(AppConst.accessToken, data['accessToken']);
    await _cacheServices.storage.setString(AppConst.refreshToken, data['refreshToken']);
    return user;
  }

  Exception _responseException(Response response) =>
      DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);

  Future<void> verifyEmail({required String email}) async {
    final response = await _apiServices.dio.post(
      ApiConstance.verifyEmail,
      data: {AppConst.email: email},
      options: Options(headers: {'X-Device-ID': 1111}),
      // options: Options(headers: {'X-Device-ID': await getDeviceId()}),
    );
    if (response.statusCode != 200) throw _responseException(response);
  }

  Future<String> confirmOtpSignUp(String email, String otp, bool willSignup) async {
    final response = await _apiServices.dio.post(
      willSignup ? ApiConstance.confirmOtpSignUp : ApiConstance.confirmOtpResetPassword,
      data: {AppConst.email: email, 'code': otp},
    );
    if (response.data['success'] == false) throw _responseException(response);
    return response.data['data']['message'];
  }

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (await deviceInfo.deviceInfo is AndroidDeviceInfo) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (await deviceInfo.deviceInfo is IosDeviceInfo) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    } else {
      return '';
    }
  }

  Future<String> resetPassword(String email, String newPassword) async {
    final response = await _apiServices.dio.post(ApiConstance.forgetPasswordReset, data: {'newPassword': newPassword});
    if (response.data['success'] == false) throw _responseException(response);
    return response.data['data']['message'];
  }

  /*   Future<UserModel> signup({required UserModel user}) async {
    final response = await _apiServices.dio.post(ApiConstance.signup, data: await user.signUp());
    if (_hasException(response)) throw _responseException(response);
    final id = response.data['data']['user'][AppConst.id];
 
    final addedUser = user.copyWith(id: id, profilePicture: response.data['data']['user'][AppConst.profilePicture]);
    await _saveUser(addedUser);
    return addedUser;
  }

  Future<UserModel> signin({required String email, required String password}) async {
    final loginData = {AppConst.email: email, AppConst.password: password};
    final response = await _apiServices.dio.post(ApiConstance.signin, data: loginData);
    debugPrint(response.data.toString());
    if(response.data['data']==null ) {
      throw _responseException(response); 
    }
    final userData = response.data['data']['user'];
    
    if (_hasException(response) || userData == null ) throw _responseException(response);
    final user = UserModel.fromJson(userData);
 
    return user;
  }

  Future<String> signout() async {
    final response = await _apiServices.dio.post(
      ApiConstance.logout,
      data: {
        AppConst.refreshToken: _cacheServices.storage.getString(
          AppConst.refreshToken,
        ),
      },
    );
    if (response.data['success'] == false) throw _responseException(response);
    await _cacheServices.storage.remove(AppConst.accessToken);
    //await _cacheServices.storage.remove(AppConst.user);
    await _cacheServices.storage.remove(AppConst.refreshToken);
    return response.data['data']['message'];
  }

  Future<void> _saveUser(UserModel user) async => await _cacheServices.storage.setString(AppConst.user, user.toCache());

  Exception _responseException(Response response) =>
      DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);

  bool _hasException(Response response) =>
      ![200, 201, 202, 203].contains(response.statusCode) || !(response.data['success'] ?? false);

 */
}
