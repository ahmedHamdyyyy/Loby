part of 'cubit.dart';

class NotificationsState extends Equatable {
  final String msg;
  final List<NotificationModel> notifications;
  final Status loadStatus;
  final Status readStatus;

  const NotificationsState({
    this.msg = '',
    this.notifications = const [],
    this.loadStatus = Status.initial,
    this.readStatus = Status.initial,
  });

  NotificationsState copyWith({
    String? msg,
    List<NotificationModel>? notifications,
    Status? loadStatus,
    Status? readStatus,
  }) => NotificationsState(
    msg: msg ?? this.msg,
    notifications: notifications ?? this.notifications,
    loadStatus: loadStatus ?? this.loadStatus,
    readStatus: readStatus ?? this.readStatus,
  );

  @override
  List<Object> get props => [msg, notifications, loadStatus, readStatus];
}
