import 'package:flutter/material.dart';
import '../../../../../../config/images/image_assets.dart';
import 'all_widget_chats.dart';
// import 'package:fondok/core/widget/widgets.dart';

import 'conversations_screen.dart';

class NoChat extends StatelessWidget {
  const NoChat({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NoChatScreenContent(
          iconAsset: ImageAssets.chat,
          message: "You don't have any conversation \n yet",
          onTitleTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConversationScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
