import 'package:equatable/equatable.dart';

enum NotificationTypes {
  initial,
  vendorVerification,
  activityVerification,
  propertyVerification,
  newActivity,
  newProperty,
  newRegistration,
  confirmPayment,
  refund,
}

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String body;
  final NotificationTypes type;
  final String entityId;
  final String createdAt;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.entityId,
    required this.createdAt,
    required this.isRead,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? entityId,
    String? body,
    NotificationTypes? type,
    String? createdAt,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      entityId: entityId ?? this.entityId,
    );
  }

  // export enum NotificationTypes {
  //     VENDOR_VERIFICATION = 'vendor_verification',
  //     ACTIVITY_VERIFICATION = 'activity_verification' ,
  //     PROPERTY_VERIFICATION = 'property_verification' ,
  //     NEW_ACTIVITY = 'new_activity' ,
  //     NEW_PROPERTY = 'new_property' ,
  //     NEW_REGISTRATION = 'new_registration',
  //     CONFIRM_PAYMENT = 'confirm_payment',
  //     REFUND = 'refund',
  // }
  //   export interface INotification extends Document {
  //     title : string;
  //     body : string;
  //     userId : string;
  //     activityId? : string ;
  //     propertyId? : string ;
  //     registrationId? : string;
  //     type : NotificationTypes;
  //     isRead : boolean;
  //     createdAt: Date;
  //     updatedAt: Date;
  // }
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    final type = NotificationTypes.values.firstWhere(
      (e) => e.toString().split('.').last == map['type'],
      orElse: () => NotificationTypes.initial,
    );
    String entityKey = '';
    switch (type) {
      case NotificationTypes.newActivity:
      case NotificationTypes.activityVerification:
        entityKey = 'activityId';
        break;
      case NotificationTypes.propertyVerification:
      case NotificationTypes.newProperty:
        entityKey = 'propertyId';
        break;
      case NotificationTypes.newRegistration:
      case NotificationTypes.confirmPayment:
        entityKey = 'registrationId';
        break;
      default:
        entityKey = '';
    }
    final entityId = entityKey.isNotEmpty ? (map[entityKey]?.toString() ?? '') : '';
    return NotificationModel(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      type: type,
      entityId: entityId,
      createdAt: map['createdAt'] ?? '',
      isRead: map['isRead'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, title, body, type, createdAt, isRead];
}
