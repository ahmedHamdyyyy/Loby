part of 'cubit.dart';

class ReservationsState extends Equatable {
  final String msg;
  final ReservationModel reservation;
  final List<ReservationModel> reservations;
  final Status updateStatus, getStatus;

  const ReservationsState({
    this.msg = '',
    this.updateStatus = Status.initial,
    this.getStatus = Status.initial,
    this.reservations = const [],
    this.reservation = ReservationModel.initial,
  });

  ReservationsState copyWith({
    String? msg,
    Status? updateStatus,
    Status? getStatus,
    List<ReservationModel>? reservations,
    ReservationModel? reservation,
  }) => ReservationsState(
    msg: msg ?? this.msg,
    updateStatus: updateStatus ?? this.updateStatus,
    getStatus: getStatus ?? this.getStatus,
    reservations: reservations ?? this.reservations,
    reservation: reservation ?? this.reservation,
  );

  @override
  List<Object> get props => [msg, updateStatus, getStatus, reservations, reservation];
}
