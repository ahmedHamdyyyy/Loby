// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../core/services/firestore_service.dart';
import '../../../../../locator.dart';
import '../profile/logic/cubit.dart';
import 'chat_screen.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            'Your Conversations',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
          ),
        ),
        const SizedBox(height: 20),

        // Search bar
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 20),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search...",
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
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final chats = snapshot.data ?? [];
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: chats.length,
                  separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.only(left: 12.0), child: Divider()),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ListTile(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(chat: chat))),
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
                              chat.lastTimestamp.toString().substring(0, 16).replaceAll('T', '  '),
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
