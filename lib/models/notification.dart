import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String body;
  final String timestamp;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.isRead,
  });

  NotificationModel copyWith({String? id, String? title, String? body, String? timestamp, bool? isRead}) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [id, title, body, timestamp, isRead];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'title': title, 'body': body, 'timestamp': timestamp, 'isRead': isRead};
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id']?.toString() ?? map['_id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      body: map['body']?.toString() ?? '',
      timestamp: map['timestamp']?.toString() ?? map['createdAt']?.toString() ?? '',
      isRead: (map['isRead'] as bool?) ?? (map['read'] as bool?) ?? false,
    );
  }
}
