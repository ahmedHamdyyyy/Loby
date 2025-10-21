import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../models/notification.dart';
import 'data.dart';

class NotificationsRepository {
  const NotificationsRepository(this._data);
  final NotificationsData _data;

  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      return await _data.fetchNotifications();
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    } catch (e) {
      throw Exception('Unexpected error');
    }
  }

  Future<void> readNotification(String id) async {
    try {
      await _data.readNotification(id);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      throw Exception(e.response?.data['error'].toString());
    } catch (e) {
      throw Exception('Unexpected error');
    }
  }
}
