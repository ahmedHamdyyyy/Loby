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
      emit(state.copyWith(readStatus: Status.success, notifications: state.notifications.where((n) => n.id != id).toList()));
    } catch (e) {
      emit(state.copyWith(readStatus: Status.error, msg: e.toString()));
    } finally {
      emit(state.copyWith(readStatus: Status.initial));
    }
  }
}
