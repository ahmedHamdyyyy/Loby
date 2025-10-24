import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../config/constants/api_constance.dart';
import '../../../../core/services/api_services.dart';
import '../../../models/reservation.dart';

class ReservationsData {
  const ReservationsData(this._apiService);
  final ApiService _apiService;

  Future<ReservationModel> updateReservation(ReservationModel reservation) async {
    final response = await _apiService.dio.put(ApiConstance.updateReservation(reservation.id), data: reservation.toMap());
    if (!(response.data['success'] ?? false)) throw _dioError(response);
    return ReservationModel.fromMap(response.data['data']);
  }

  Future<List<ReservationModel>> getReservations(bool isCurrentReservations) async {
    final response = await _apiService.dio.get(
      ApiConstance.getReservations,
      queryParameters: {'status': isCurrentReservations ? 'current' : 'last'},
    );
    log(response.data.toString());
    if (!(response.data['success'] ?? false) || response.data['data']['data'] == null) throw _dioError(response);
    return (response.data['data']['data'] as List).map((e) => ReservationModel.fromMap(e)).toList();
  }

  Future<void> acceptReservation(String id) async {
    final response = await _apiService.dio.post(ApiConstance.acceptReservation(id));
    if (!(response.data['success'] ?? false)) throw _dioError(response);
  }

  Future<void> refundReservation(String id) async {
    final response = await _apiService.dio.post(ApiConstance.refundReservation, data: {'registrationId': id});
    if (!(response.data['success'] ?? false)) throw _dioError(response);
  }

  Future<ReservationModel> getReservationById(String id) async {
    final response = await _apiService.dio.get(ApiConstance.getReservation(id));
    if (!(response.data['success'] ?? false) || response.data['data'] == null) throw _dioError(response);
    return ReservationModel.fromMap(response.data['data']);
  }

  DioException _dioError(Response<dynamic> response) {
    return DioException(requestOptions: response.requestOptions, response: response, error: response.data['error']);
  }
}
