import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';
import '../../../models/chat.dart';

// ------------------------ Chat Message Model ------------------------

// ------------------------ Chat Service ------------------------

// class ChatService {
//   final _firestore = FirebaseFirestore.instance;

//   // Create or get chat room ID
//   String getChatRoomId(String userId1, String userId2) {
//     // Sort IDs to ensure consistent chat room ID
//     List<String> sortedIds = [userId1, userId2]..sort();
//     return '${sortedIds[0]}_${sortedIds[1]}';
//   }

//   // Send message
//   Future<void> sendMessage(String chatRoomId, ChatMessage message) async {
//     try {
//       // First, ensure chat room exists
//       await _firestore.collection('chats').doc(chatRoomId).set({
//         'participants': [message.senderId, message.receiverId],
//         'createdAt': FieldValue.serverTimestamp(),
//         'updatedAt': FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));

//       // Then add the message
//       await _firestore.collection('chats').doc(chatRoomId).collection('messages').add(message.toMap());

//       // Update chat room with last message
//       await _firestore.collection('chats').doc(chatRoomId).update({
//         'lastMessage': message.text,
//         'lastMessageTime': message.timestamp,
//         'updatedAt': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       print('Error sending message: $e');
//       if (e.toString().contains('permission-denied')) {
//         throw Exception('خطأ في الأذونات: تأكد من تسجيل الدخول');
//       } else if (e.toString().contains('unavailable')) {
//         throw Exception('خطأ في الاتصال: تحقق من اتصال الإنترنت');
//       } else {
//         throw Exception('فشل في إرسال الرسالة: $e');
//       }
//     }
//   }

//   // Get messages stream
//   Stream<QuerySnapshot> getMessages(String chatRoomId) {
//     try {
//       return _firestore
//           .collection('chats')
//           .doc(chatRoomId)
//           .collection('messages')
//           .orderBy('timestamp', descending: true)
//           .snapshots()
//           .handleError((error) {
//             print('Error in messages stream: $error');
//             if (error.toString().contains('permission-denied')) throw Exception('خطأ في الأذونات: تأكد من تسجيل الدخول');
//             throw error;
//           });
//     } catch (e) {
//       print('Error getting messages: $e');
//       return Stream.empty();
//     }
//   }

//   // Check if chat room exists
//   Future<bool> chatRoomExists(String chatRoomId) async {
//     try {
//       final doc = await _firestore.collection('chats').doc(chatRoomId).get();
//       return doc.exists;
//     } catch (e) {
//       print('Error checking chat room: $e');
//       return false;
//     }
//   }

//   // Create chat room if it doesn't exist
//   Future<void> ensureChatRoom({required String chatRoomId, required String vendorId, required String userId}) async {
//     try {
//       await _firestore.collection('chats').doc(chatRoomId).set({
//         'vendorId': vendorId,
//         'userId': userId,
//         'lastMessage': '',
//         'lastMessageTime': FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//     } catch (e) {
//       print('Error creating chat room: $e');
//       throw Exception('فشل في إنشاء غرفة الدردشة: $e');
//     }
//   }
// }

// ------------------------ Chat Screen Widgets ------------------------

// User Info Header Widget
class UserInfoHeaderWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final bool isOnline;

  const UserInfoHeaderWidget({super.key, required this.userName, required this.userImage, this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),
          InkWell(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon)),
          const SizedBox(width: 5),
          // User image with online status
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(100),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/saudian_man.png',
              image: userImage,
              width: 35,
              height: 35,
              placeholderCacheHeight: 35,
              placeholderCacheWidth: 35,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/saudian_man.png', width: 50, height: 50);
              },
            ),
          ),
          const SizedBox(width: 12),
          // User name and status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryTextColor),
                ),
                const SizedBox(height: 2),
                // Text(
                //   isOnline ? "Online" : "Offline",
                //   style: GoogleFonts.poppins(fontSize: 14, color: isOnline ? Colors.green : Colors.grey),
                // ),   `
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Chat Message Item Widget
class ChatMessageItemWidget extends StatelessWidget {
  const ChatMessageItemWidget({super.key, required this.message, required this.isMine});
  final ChatMessage message;
  final bool isMine;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: isMine ? 80 : 0, right: isMine ? 0 : 80, bottom: 16),
        child: Column(
          crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Message bubble
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMine ? Colors.white : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Text(
                message.text,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isMine ? AppColors.primaryColor : Colors.white,
                ),
              ),
            ),
            // Message time
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
              child: Text(
                message.timestamp.toString().substring(0, 16).replaceAll('T', '  '),
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------ No Chats Screen Widgets ------------------------

// Empty State Widget
class NoChatsWidget extends StatelessWidget {
  final String iconAsset;
  final String message;

  const NoChatsWidget({super.key, required this.iconAsset, this.message = "You don't have any conversation \n yet"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty state icon
          Container(width: 130, height: 130, margin: const EdgeInsets.only(bottom: 24), child: SvgPicture.asset(iconAsset)),

          // Empty state message
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondTextColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// Header Title Widget for Conversations
class ConversationHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool showBackButton;

  const ConversationHeaderWidget({super.key, required this.title, this.onTap, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            const SizedBox(width: 20),
            if (showBackButton)
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
              ),
            const SizedBox(width: 8),
            Text(
              "Conversations",
              style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 22),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}

// No Chat Screen Content Widget
class NoChatScreenContent extends StatelessWidget {
  final VoidCallback? onTitleTap;
  final bool showBackButton;
  final String iconAsset;
  final String message;

  const NoChatScreenContent({
    super.key,
    this.onTitleTap,
    this.showBackButton = false,
    this.iconAsset = ImageAssets.chat,
    this.message = "You don't have any conversation \n yet",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        ConversationHeaderWidget(title: 'Your Conversations', onTap: onTitleTap, showBackButton: showBackButton),

        // Empty state
        Expanded(child: NoChatsWidget(iconAsset: iconAsset, message: message)),
      ],
    );
  }
}
