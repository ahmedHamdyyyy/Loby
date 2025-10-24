import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../../models/notification.dart';

class NotificationsData {
  NotificationsData(this._apiService);
  final ApiService _apiService;

  void _check(Response response) {
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    print('response.data ' * 5);
    final response = await _apiService.dio.get(ApiConstance.notifications);
    _check(response);
    print(response.data);
    final list = (response.data['data']['data'] as List?) ?? [];
    return list.map((e) => NotificationModel.fromMap(e)).toList();
  }

  Future<void> readNotification(String id) async {
    final response = await _apiService.dio.patch(ApiConstance.readNotification(id));
    _check(response);
  }
}
