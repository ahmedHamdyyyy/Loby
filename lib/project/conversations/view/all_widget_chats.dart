import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';
import 'chat_screen.dart';
import 'conversations_screen.dart';

class ChatScreenHeader extends StatelessWidget {
  const ChatScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
        ),
        const SizedBox(width: 8),
        Text(
          "Conversations",
          style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ],
    );
  }
}

class UserInfoHeader extends StatelessWidget {
  final String userName;
  final String userImage;
  final bool isOnline;

  const UserInfoHeader({super.key, required this.userName, required this.userImage, required this.isOnline});

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
          UserAvatarWithStatus(userImage: userImage, isOnline: isOnline),
          const SizedBox(width: 12),
          UserNameAndStatus(userName: userName, isOnline: isOnline),
        ],
      ),
    );
  }
}

class UserAvatarWithStatus extends StatelessWidget {
  final String userImage;
  final bool isOnline;

  const UserAvatarWithStatus({super.key, required this.userImage, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(radius: 30, backgroundImage: AssetImage(userImage)),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

class UserNameAndStatus extends StatelessWidget {
  final String userName;
  final bool isOnline;

  const UserNameAndStatus({super.key, required this.userName, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryTextColor),
        ),
        const SizedBox(height: 2),
        Text(
          isOnline ? "Online" : "Offline",
          style: GoogleFonts.poppins(fontSize: 14, color: isOnline ? Colors.green : Colors.grey),
        ),
      ],
    );
  }
}

class MessagesList extends StatelessWidget {
  final List<ChatMessage> messages;

  const MessagesList({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF8F8F8),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: messages.length,
          reverse: false,
          itemBuilder: (context, index) {
            final message = messages[index];
            return MessageBubble(message: message);
          },
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: message.isMe ? 80 : 0, right: message.isMe ? 0 : 80, bottom: 12),
        child: Column(
          crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isMe ? Colors.white : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: message.isMe ? AppColors.primaryColor : Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
              child: Text(
                message.time,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageInputBox extends StatelessWidget {
  final TextEditingController controller;

  const MessageInputBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 5, top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: const InkWell(
                    child: Icon(Icons.sentiment_satisfied_alt_outlined, color: AppColors.grayTextColor),
                  ),
                  hintText: "message",
                  hintStyle: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 16, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
            child: SvgPicture.asset(ImageAssets.mic),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
        ),
        const SizedBox(width: 8),
        Text(
          "Conversations",
          style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ],
    );
  }
}

class ConversationsHeader extends StatelessWidget {
  const ConversationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        'Your Conversations',
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchBarWidget({super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0, right: 20),
      child: SizedBox() /* SimpleSearchBar(
        controller: controller,
        onSearch: onSearch,
      ), */,
    );
  }
}

class ConversationsList extends StatelessWidget {
  const ConversationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 20),
        child: ListView.separated(
          itemCount: 4,
          separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.only(left: 12.0), child: Divider()),
          itemBuilder: (context, index) {
            return ConversationListItem(
              index: index,
              userName: 'Mohamed Ahmed',
              userImage: 'assets/images/saudian_man.png',
              isOnline: index == 0,
              messagePreview: _getMessagePreview(index),
            );
          },
        ),
      ),
    );
  }

  String _getMessagePreview(int index) {
    final messages = [
      "Hello ! howe Are you",
      "Lorem ipsum dolor sit amet, consecr text adipiscing",
      "Hey! How have you ?",
      "Lorem ipsum dolor sit amet",
    ];
    return messages[index];
  }
}

class ConversationListItem extends StatelessWidget {
  final int index;
  final String userName;
  final String userImage;
  final bool isOnline;
  final String messagePreview;

  const ConversationListItem({
    super.key,
    required this.index,
    required this.userName,
    required this.userImage,
    required this.isOnline,
    required this.messagePreview,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreenVendor(userName: userName, userImage: userImage, isOnline: isOnline),
          ),
        );
      },
      leading: UserAvatar(userImage: userImage, isOnline: isOnline),
      title: Text(
        userName,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primaryTextColor),
      ),
      subtitle: Text(
        messagePreview,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
      ),
      trailing: const MessageTimeAndStatus(),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String userImage;
  final bool isOnline;

  const UserAvatar({super.key, required this.userImage, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/images/saudian_man.png')),
        if (isOnline)
          Positioned(
            bottom: 5,
            right: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

class MessageTimeAndStatus extends StatelessWidget {
  const MessageTimeAndStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '12:25 PM',
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
        ),
        const SizedBox(height: 5),
        const Icon(Icons.done_all, size: 16, color: Colors.grey),
      ],
    );
  }
}

class NotificationsHeaderWithNavigation extends StatelessWidget {
  final BuildContext context;

  const NotificationsHeaderWithNavigation({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToNotifications(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Text(
          'Your Notifications',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
        ),
      ),
    );
  }

  void _navigateToNotifications(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ConversationScreenVendor()));
  }
}

class EmptyConversationContent extends StatelessWidget {
  const EmptyConversationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              margin: const EdgeInsets.only(bottom: 24),
              child: SvgPicture.asset(ImageAssets.chatIcon),
            ),
            Text(
              "You don't have any conversation \n yet",
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
      ),
    );
  }
}
