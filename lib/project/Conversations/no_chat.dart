import 'package:flutter/material.dart';

import '../../../../../../config/images/image_assets.dart';
// import 'package:fondok/core/widget/widgets.dart';
import '../../../core/localization/l10n_ext.dart';
import 'all_widget_chats.dart';
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
          message: context.l10n.noConversationsYet,
          onTitleTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ConversationScreen()));
          },
        ),
      ),
    );
  }
}
