// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../core/services/firestore_service.dart';
import '../../../../../locator.dart';
import '../../core/localization/l10n_ext.dart';
import '../../models/chat.dart';
import '../profile/logic/cubit.dart';
import 'chat_screen.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _searchController = TextEditingController();
  final _firestoreService = FirestoreService();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatTimestamp(DateTime timestamp) {
    final dateStr = timestamp.toString();
    if (dateStr.length >= 16) {
      return dateStr.substring(0, 16).replaceAll('T', '  ');
    }
    return dateStr.replaceAll('T', '  ');
  }

  Future<void> _showDeleteDialog(ChatModel chat) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.l10n.deleteConversationTitle, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          content: Text(context.l10n.deleteConversationContent(chat.userName), style: GoogleFonts.poppins()),
          actions: <Widget>[
            TextButton(
              child: Text(context.l10n.commonCancel, style: GoogleFonts.poppins(color: AppColors.grayTextColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(context.l10n.commonDelete, style: GoogleFonts.poppins(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await _firestoreService.deleteChat(chat.id);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.conversationDeletedSuccessfully, style: GoogleFonts.poppins()),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.conversationDeleteError, style: GoogleFonts.poppins()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        // Title
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            context.l10n.conversationTitle,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
          ),
        ),
        const SizedBox(height: 20),

        // Search bar
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: context.l10n.searchHint,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onChanged: (term) {},
          ),
        ),

        // Conversations list
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 20),
            child: StreamBuilder(
              stream: FirestoreService().getUserChats(getIt<ProfileCubit>().state.user.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(context.l10n.errorWithMessage('${snapshot.error}')));
                }
                final chats = snapshot.data ?? [];

                // Sort conversations by lastTimestamp in descending order (most recent first)
                chats.sort((a, b) => b.lastTimestamp.compareTo(a.lastTimestamp));

                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: chats.length,
                  separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.only(left: 12.0), child: Divider()),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ListTile(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(chat: chat))),
                      onLongPress: () => _showDeleteDialog(chat),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/saudian_man.png',
                          image: chat.userImageUrl,
                          imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/images/saudian_man.png'),
                          width: 50,
                          height: 50,
                        ),
                      ),
                      title: Text(
                        chat.userName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryTextColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grayTextColor,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              _formatTimestamp(chat.lastTimestamp),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grayTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
