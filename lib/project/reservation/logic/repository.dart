import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../models/reservation.dart';
import 'data.dart';

class ReservationsRepository {
  const ReservationsRepository(this._data);
  final ReservationsData _data;

  Future<ReservationModel> updateReservation(ReservationModel property) async {
    try {
      return await _data.updateReservation(property);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) {
        final errorMessage = e.response?.data['error'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else {
          throw Exception(errorMessage.toString());
        }
      } else if (e.response?.statusCode != null) {
        throw Exception('Server error with status code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to update property: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<List<ReservationModel>> getReservations(bool isCurrentReservations) async {
    try {
      return await _data.getReservations(isCurrentReservations);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      if (e.response?.data['error'] != null) {
        final errorMessage = e.response?.data['error'];
        if (errorMessage is List) {
          throw Exception(errorMessage.join(', '));
        } else {
          throw Exception(errorMessage.toString());
        }
      } else if (e.response?.statusCode != null) {
        throw Exception('Server error with status code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to get Reservations: ${e.message}');
    } catch (e, stackTrace) {
      debugPrint('Unexpected error: $e');
      debugPrint('Stack trace: $stackTrace');
      throw Exception('An unexpected error occurred');
    }
  }
}
