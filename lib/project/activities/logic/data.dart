import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../models/activity.dart';

class ActivitiesData {
  const ActivitiesData(this._apiService);
  final ApiService _apiService;

  Future<ActivityModel> createActivity(ActivityModel activity) async {
    final response = await _apiService.dio.post(ApiConstance.createActivity, data: await activity.create());
    _checkIfSuccess(response);
    return ActivityModel.fromJson(response.data['data']['activity']);
  }

  Future<void> updateActivity(ActivityModel activity) async {
    final response = await _apiService.dio.put(ApiConstance.updateActivity(activity.id), data: await activity.create());
    _checkIfSuccess(response);
  }

  Future<void> deleteActivity(String id) async {
    final response = await _apiService.dio.delete(ApiConstance.deleteActivity(id));
    _checkIfSuccess(response);
  }

  Future<List<CustomActivityModel>> getActivities() async {
    final response = await _apiService.dio.get(ApiConstance.getActivities);
    _checkIfSuccess(response);
    return (response.data['data']['data'] as List).map((e) => CustomActivityModel.fromJson(e)).toList();
  }

  Future<ActivityModel> getActivity(String id) async {
    final response = await _apiService.dio.get(ApiConstance.getActivity(id));
    _checkIfSuccess(response);
    return ActivityModel.fromJson(response.data['data']['activity']);
  }

  void _checkIfSuccess(Response<dynamic> response) {
    if (!(response.data['success'] ?? false)) {
      throw DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
    }
  }
}
