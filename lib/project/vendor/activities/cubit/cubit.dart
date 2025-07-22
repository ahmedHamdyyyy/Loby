import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/activity.dart';
import '../data/repository.dart';

part 'state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit(this._repo) : super(const ActivitiesState());
  final ActivitiesRepository _repo;

  void getActivities() async {
    emit(state.copyWith(getStatus: Status.loading));
    try {
      final activities = await _repo.getActivities();
      emit(state.copyWith(getStatus: Status.success, activities: activities));
    } catch (e) {
      emit(state.copyWith(getStatus: Status.error, msg: e.toString()));
    }
  }

  void createActivity(ActivityModel activity) async {
    emit(state.copyWith(createStatus: Status.loading));
    try {
      final createdProperty = await _repo.createActivity(activity);
      emit(
        state.copyWith(
          createStatus: Status.success,
          activity: createdProperty,
          activities: [...state.activities, CustomActivityModel.fromProperty(createdProperty)],
        ),
      );
    } catch (e) {
      emit(state.copyWith(createStatus: Status.error, msg: e.toString()));
    }
  }

  void updateActivity(ActivityModel activity) async {
    emit(state.copyWith(updateStatus: Status.loading));
    try {
      await _repo.updateActivity(activity);
      emit(
        state.copyWith(
          updateStatus: Status.success,
          activity: activity,
          activities: [...state.activities.map((p) => p.id == activity.id ? CustomActivityModel.fromProperty(activity) : p)],
        ),
      );
    } catch (e) {
      emit(state.copyWith(updateStatus: Status.error, msg: e.toString()));
    }
  }

  void deleteActivity() async {
    emit(state.copyWith(updateStatus: Status.loading));
    try {
      await _repo.deleteActivity(state.activity.id);
      emit(
        state.copyWith(
          updateStatus: Status.success,
          activities: [...state.activities.where((activity) => activity.id != state.activity.id)],
          activity: ActivityModel.non,
        ),
      );
    } catch (e) {
      emit(state.copyWith(updateStatus: Status.error, msg: e.toString()));
    }
  }
}
