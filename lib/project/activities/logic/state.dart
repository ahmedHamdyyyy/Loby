part of 'cubit.dart';

class ActivitiesState extends Equatable {
  final String msg;
  final Status createStatus, updateStatus, deleteStatus, getActivityStatus, getStatus;
  final List<CustomActivityModel> activities;
  final ActivityModel activity;

  const ActivitiesState({
    this.msg = '',
    this.getActivityStatus = Status.initial,
    this.createStatus = Status.initial,
    this.updateStatus = Status.initial,
    this.deleteStatus = Status.initial,
    this.getStatus = Status.initial,
    this.activities = const [],
    this.activity = ActivityModel.non,
  });

  ActivitiesState copyWith({
    String? msg,
    Status? createStatus,
    Status? updateStatus,
    Status? getActivityStatus,
    Status? deleteStatus,
    Status? getStatus,
    List<CustomActivityModel>? activities,
    ActivityModel? activity,
  }) {
    return ActivitiesState(
      msg: msg ?? this.msg,
      getActivityStatus: getActivityStatus ?? this.getActivityStatus,
      createStatus: createStatus ?? this.createStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      getStatus: getStatus ?? this.getStatus,
      activities: activities ?? this.activities,
      activity: activity ?? this.activity,
    );
  }

  @override
  List<Object> get props => [msg, createStatus, updateStatus, deleteStatus, getActivityStatus, getStatus, activities, activity];
}
