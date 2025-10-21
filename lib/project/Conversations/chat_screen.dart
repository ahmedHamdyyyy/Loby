import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../core/services/firestore_service.dart';
import '../../../models/chat.dart';
import '../../config/widget/widget.dart';
import '../../core/localization/l10n_ext.dart';
import 'all_widget_chats.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chat});
  final ChatModel chat;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _firestoreService = FirestoreService();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    await _firestoreService.ensureChatExists(widget.chat);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSendMessage() async {
    if (_messageController.text.isEmpty) {
      showToast(text: context.l10n.messageCannotBeEmpty, stute: ToustStute.worning);
      return;
    }
    setState(() => _isSending = true);
    await _firestoreService.sendMessage(
      widget.chat.id,
      ChatMessage(id: '', text: _messageController.text.trim(), senderId: widget.chat.vendorId, timestamp: DateTime.now()),
    );
    _messageController.clear();
    setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      children: [
        const SizedBox(height: 35),
        // User info header
        UserInfoHeaderWidget(userName: widget.chat.userName, userImage: widget.chat.userImageUrl),
        // Messages list
        Expanded(
          child: StreamBuilder(
            stream: _firestoreService.getMessages(widget.chat.id),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (asyncSnapshot.hasError) {
                return Center(child: Text(context.l10n.errorWithMessage('${asyncSnapshot.error}')));
              }
              final messages = asyncSnapshot.data ?? [];
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                child:
                    messages.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[400]),
                              const SizedBox(height: 16),
                              Text(
                                context.l10n.noMessagesYet,
                                style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                context.l10n.startConversation,
                                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: messages.length,
                          reverse: true, // Show newest messages at bottom
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return ChatMessageItemWidget(message: message, isMine: message.senderId == widget.chat.vendorId);
                          },
                        ),
              );
            },
          ),
        ),

        // Message input box
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 8),
          child: Row(
            children: [
              // Text field
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 5, top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Icon(Icons.sentiment_satisfied_alt_outlined, color: AppColors.grayTextColor),
                      ),
                      hintText: context.l10n.typeMessageHint,
                      hintStyle: GoogleFonts.poppins(
                        color: AppColors.grayTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                    ),
                    onFieldSubmitted: (value) {
                      if (value.trim().isNotEmpty) _handleSendMessage();
                    },
                    textInputAction: TextInputAction.send,
                  ),
                ),
              ),
              // Send button
              const SizedBox(width: 10),
              InkWell(
                onTap: _handleSendMessage,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                  child:
                      _isSending
                          ? const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Center(child: Icon(Icons.send, color: Colors.white, size: 24)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
