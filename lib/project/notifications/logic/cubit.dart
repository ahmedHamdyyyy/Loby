import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../../models/notification.dart';
import 'repository.dart';

part 'state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repo) : super(const NotificationsState());

  final NotificationsRepository _repo;

  void loadNotifications() async {
    emit(state.copyWith(loadStatus: Status.loading));
    try {
      final notifications = await _repo.fetchNotifications();
      emit(state.copyWith(loadStatus: Status.success, notifications: notifications));
    } catch (e) {
      emit(state.copyWith(loadStatus: Status.error, msg: e.toString()));
    } finally {
      emit(state.copyWith(loadStatus: Status.initial));
    }
  }

  void readNotification(String id) async {
    emit(state.copyWith(readStatus: Status.loading));
    try {
      await _repo.readNotification(id);
      // Mark notification as read locally instead of removing it
      final updated = state.notifications.map((n) => n.id == id ? n.copyWith(isRead: true) : n).toList();
      emit(state.copyWith(readStatus: Status.success, notifications: updated));
    } catch (e) {
      emit(state.copyWith(readStatus: Status.error, msg: e.toString()));
    } finally {
      emit(state.copyWith(readStatus: Status.initial));
    }
  }
}
