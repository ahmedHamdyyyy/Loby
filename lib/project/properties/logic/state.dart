part of 'cubit.dart';

class PropertiesState extends Equatable {
  final String msg;
  final PropertyModel property;
  final Status createStatus, updateStatus, deleteStatus, getStatus, getPropertyStatus;
  final List<CustomPropertyModel> properties;

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
  }) => PropertiesState(
    msg: msg ?? this.msg,
    getPropertyStatus: getPropertyStatus ?? this.getPropertyStatus,
    createStatus: createStatus ?? this.createStatus,
    updateStatus: updateStatus ?? this.updateStatus,
    deleteStatus: deleteStatus ?? this.deleteStatus,
    getStatus: getStatus ?? this.getStatus,
    properties: properties ?? this.properties,
    property: property ?? this.property,
  );

  @override
  List<Object> get props => [
    msg,
    createStatus,
    updateStatus,
    deleteStatus,
    getStatus,
    getPropertyStatus,
    properties,
    property,
  ];
}
