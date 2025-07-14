// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'all_widget_chats.dart';


class ConversationScreenVendor extends StatelessWidget {
  const ConversationScreenVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const ScreenHeader(),
            const SizedBox(height: 22),
            const ConversationsHeader(),
            const SizedBox(height: 20),
            SearchBarWidget(
              controller: TextEditingController(),
              onSearch: (query) {
                print('Searching for: $query');
              },
            ),
            const SizedBox(height: 20),
            const ConversationsList(),
          ],
        ),
      ),
    );
  }
}
