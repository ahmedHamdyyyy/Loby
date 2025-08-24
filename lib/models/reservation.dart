import 'package:equatable/equatable.dart';

import 'activity.dart';
import 'property.dart';

enum ReservationType { activity, property }

enum ReservationStatus { pending, approved, rejected }

class ReservationModel extends Equatable {
  final String id, userId, userName, userImageUrl, checkInDate, checkOutDate;
  final ReservationType type;
  final ReservationStatus status;
  final int guestNumber, registrationNumber;
  final double totalPrice;
  final Object item;

  const ReservationModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
    required this.checkInDate,
    required this.checkOutDate,
    required this.type,
    required this.status,
    required this.guestNumber,
    required this.registrationNumber,
    required this.totalPrice,
    required this.item,
  });

  static const initial = ReservationModel(
    id: '',
    userId: '',
    userName: '',
    userImageUrl: '',
    checkInDate: '',
    checkOutDate: '',
    type: ReservationType.property,
    status: ReservationStatus.pending,
    guestNumber: 1,
    registrationNumber: 0,
    totalPrice: 0.0,
    item: PropertyModel.initial,
  );

  ReservationModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userImageUrl,
    String? checkInDate,
    String? checkOutDate,
    ReservationType? type,
    ReservationStatus? status,
    int? guestNumber,
    int? registrationNumber,
    double? totalPrice,
    Object? item,
  }) => ReservationModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
    userImageUrl: userImageUrl ?? this.userImageUrl,
    checkInDate: checkInDate ?? this.checkInDate,
    checkOutDate: checkOutDate ?? this.checkOutDate,
    type: type ?? this.type,
    status: status ?? this.status,
    registrationNumber: registrationNumber ?? this.registrationNumber,
    guestNumber: guestNumber ?? this.guestNumber,
    totalPrice: totalPrice ?? this.totalPrice,
    item: item ?? this.item,
  );

  Map<String, dynamic> toMap() => {
    'type': type.name,
    'userId': userId,
    if (type == ReservationType.property) ...{
      'propertyId': (item as PropertyModel).id,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
    } else ...{
      'activityId': (item as ActivityModel).id,
      'guestNumber': guestNumber,
    },
  };

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    final type = ReservationType.values.firstWhere((e) => e.name == map['type'], orElse: () => ReservationType.property);
    return ReservationModel(
      id: map['_id'] ?? '',
      userId: map['user']['id'] ?? '',
      userName: '${map['user']['firstName'] ?? ''} ${map['user']['lastName'] ?? ''}',
      userImageUrl: map['user']['imageUrl'] ?? '',
      type: type,
      checkInDate: map['checkInDate'] ?? '',
      checkOutDate: map['checkOutDate'] ?? '',
      status: ReservationStatus.values.firstWhere((e) => e.name == map['status'], orElse: () => ReservationStatus.pending),
      guestNumber: map['guestNumber'] ?? 1,
      registrationNumber: map['registrationNumber'] ?? 0,
      totalPrice: (map['totalPrice'] as num?)?.toDouble() ?? 0.0,
      item:
          type == ReservationType.property
              ? PropertyModel.fromJson(map['property'] ?? {})
              : ActivityModel.fromJson(map['activity'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    checkInDate,
    checkOutDate,
    type,
    status,
    guestNumber,
    registrationNumber,
    totalPrice,
    item,
  ];
}
