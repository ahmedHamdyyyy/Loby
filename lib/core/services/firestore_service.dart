import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  static const _chatsCollection = 'chats';
  static const _messagesCollection = 'messages';

  Stream<List<ChatModel>> getUserChats(String userId) => _firestore
      .collection(_chatsCollection)
      .where('vendorId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ChatModel.fromFirestore(doc.data(), doc.id)).toList());

  Future<void> sendMessage(String chatId, ChatMessage message) async {
    await _firestore.collection(_chatsCollection).doc(chatId).collection(_messagesCollection).add(message.toMap());
    await _firestore.collection(_chatsCollection).doc(chatId).update({
      'lastMessage': message.text,
      'lastTimestamp': Timestamp.fromDate(message.timestamp),
    });
  }

  Future<void> ensureChatExists(ChatModel chat) async {
    final chatRef = _firestore.collection(_chatsCollection).doc(chat.id);
    final chatDoc = await chatRef.get();
    if (!chatDoc.exists) await chatRef.set(chat.toMap());
  }

  Stream<List<ChatMessage>> getMessages(String chatId) => _firestore
      .collection(_chatsCollection)
      .doc(chatId)
      .collection(_messagesCollection)
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ChatMessage.fromFirestore(doc.data(), doc.id)).toList());

  // إضافة دالة حذف المحادثة
  Future<void> deleteChat(String chatId) async {
    // حذف جميع الرسائل في المحادثة أولاً
    final messagesSnapshot = await _firestore
        .collection(_chatsCollection)
        .doc(chatId)
        .collection(_messagesCollection)
        .get();
    
    for (var doc in messagesSnapshot.docs) {
      await doc.reference.delete();
    }
    
    // حذف المحادثة نفسها
    await _firestore.collection(_chatsCollection).doc(chatId).delete();
  }
}
