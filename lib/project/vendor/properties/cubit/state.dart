part of 'cubit.dart';

class PropertiesState extends Equatable {
  final String msg;
  final Status createStatus;
  final Status updateStatus;
  final Status deleteStatus;
  final Status getStatus;
  final Status getPropertyStatus;

  final List<CustomPropertyModel> properties;
  final PropertyModel property;

  const PropertiesState({
    this.msg = '',
    this.createStatus = Status.initial,
    this.updateStatus = Status.initial,
    this.deleteStatus = Status.initial,
    this.getPropertyStatus = Status.initial,
    this.getStatus = Status.initial,
    this.properties = const [],
    this.property = PropertyModel.non,
  });

  PropertiesState copyWith({
    String? msg,
    Status? createStatus,
    Status? updateStatus,
    Status? deleteStatus,
    Status? getStatus,
    Status? getPropertyStatus,
    List<CustomPropertyModel>? properties,
    PropertyModel? property,
  }) {
    return PropertiesState(
      msg: msg ?? this.msg,
      getPropertyStatus: getPropertyStatus ?? this.getPropertyStatus,
      createStatus: createStatus ?? this.createStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      getStatus: getStatus ?? this.getStatus,
      properties: properties ?? this.properties,
      property: property ?? this.property,
    );
  }

  @override
  List<Object> get props => [msg, createStatus, updateStatus, deleteStatus, getStatus, getPropertyStatus, properties, property];
}
