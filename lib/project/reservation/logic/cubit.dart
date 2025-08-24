import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../models/reservation.dart';
import 'repository.dart';

part 'state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit(this._repo) : super(const ReservationsState());
  final ReservationsRepository _repo;

  void getReservations(bool isCurrentReservations) async {
    emit(state.copyWith(getStatus: Status.loading));
    try {
      final reservations = await _repo.getReservations(isCurrentReservations);
      emit(state.copyWith(getStatus: Status.success, reservations: reservations));
    } catch (e) {
      emit(state.copyWith(getStatus: Status.error, msg: e.toString()));
    }
  }

  void updateReservation(ReservationModel reservation) async {
    emit(state.copyWith(updateStatus: Status.loading));
    try {
      final updatedReservation = await _repo.updateReservation(reservation);
      emit(
        state.copyWith(
          updateStatus: Status.success,
          reservations: [...state.reservations.map((p) => p.id == updatedReservation.id ? updatedReservation : p)],
        ),
      );
    } catch (e) {
      emit(state.copyWith(updateStatus: Status.error, msg: e.toString()));
    } finally {
      emit(state.copyWith(updateStatus: Status.initial));
    }
  }

  void init() => emit(state.copyWith(updateStatus: Status.initial));
}
