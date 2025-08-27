import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String id, vendorId, userId, vendorName, vendorImageUrl, userName, userImageUrl, lastMessage;
  final DateTime lastTimestamp;

  const ChatModel({
    required this.id,
    required this.vendorId,
    required this.userId,
    required this.lastMessage,
    required this.lastTimestamp,
    required this.vendorName,
    required this.vendorImageUrl,
    required this.userName,
    required this.userImageUrl,
  });

  factory ChatModel.fromFirestore(Map<String, dynamic> map, String id) => ChatModel(
    id: id,
    vendorId: map['vendorId'] ?? '',
    userId: map['userId'] ?? '',
    lastMessage: map['lastMessage'] ?? '',
    vendorName: map['vendorName'] ?? '',
    vendorImageUrl: map['vendorImageUrl'] ?? '',
    userName: map['userName'] ?? '',
    userImageUrl: map['userImageUrl'] ?? '',
    lastTimestamp: (map['lastTimestamp'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toMap() => {
    if (id.isNotEmpty) 'id': id,
    'vendorId': vendorId,
    'userId': userId,
    'lastMessage': lastMessage,
    'vendorName': vendorName,
    'vendorImageUrl': vendorImageUrl,
    'userName': userName,
    'userImageUrl': userImageUrl,
    'lastTimestamp': Timestamp.fromDate(lastTimestamp),
  };

  @override
  List<Object?> get props => [
    id,
    vendorId,
    userId,
    lastMessage,
    lastTimestamp,
    vendorName,
    vendorImageUrl,
    userName,
    userImageUrl,
  ];
}

class ChatMessage extends Equatable {
  final String id, text, senderId;
  final DateTime timestamp;

  const ChatMessage({required this.id, required this.text, required this.senderId, required this.timestamp});

  ChatMessage copyWith({String? id, String? text, String? senderId, DateTime? timestamp}) => ChatMessage(
    id: id ?? this.id,
    text: text ?? this.text,
    senderId: senderId ?? this.senderId,
    timestamp: timestamp ?? this.timestamp,
  );

  factory ChatMessage.fromFirestore(Map<String, dynamic> map, String id) => ChatMessage(
    id: id,
    text: map['text'] ?? '',
    senderId: map['senderId'] ?? '',
    timestamp: (map['timestamp'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toMap() => {
    if (id.isNotEmpty) 'id': id,
    'text': text,
    'senderId': senderId,
    'timestamp': Timestamp.fromDate(timestamp),
  };

  @override
  List<Object?> get props => [id, text, senderId, timestamp];
}
