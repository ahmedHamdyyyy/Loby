import '../../../../config/constants/api_constance.dart';
import '../../../../config/constants/constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/cach_services.dart';
import '../../models/user_model.dart';

class UserData {
  const UserData(this._apiServices, this._cacheServices);
  final ApiService _apiServices;
  final CacheService _cacheServices;

  UserModel getCachedUser() {
    final userData = _cacheServices.storage.getString(AppConst.user);
    if (userData == null) throw Exception('فشل العثور علي الملف الشخصي يرجي اعادة تسجيل الدخول');
    return UserModel.fromCache(userData);
  }

  Future<UserModel> fetchUser() async {
    final response = await _apiServices.dio.get(ApiConstance.userProfile);
    print(response.data);
    if (!(response.data['success'] ?? false) || response.data['data'] == null) throw Exception('فشل تحميل الملف الشخصي');
    final userResponse = UserModel.fromJson(response.data['data']);
    return userResponse;
  }
}
