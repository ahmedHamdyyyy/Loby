import 'package:equatable/equatable.dart';

import '../../models/property_model.dart';
import '../../models/user_model.dart';

enum HomeStatus { initial, loading, success, error }

enum PropertyCreationStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final PropertyCreationStatus propertyStatus;
  final UserModel user;
  final PropertyModel property;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.propertyStatus = PropertyCreationStatus.initial,
    this.user = UserModel.non,
    this.property = PropertyModel.non,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    PropertyCreationStatus? propertyStatus,
    UserModel? user,
    PropertyModel? property,
    String? errorMessage,
  }) => HomeState(
    status: status ?? this.status,
    propertyStatus: propertyStatus ?? this.propertyStatus,
    user: user ?? this.user,
    property: property ?? this.property,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, propertyStatus, user, property, errorMessage];
}
