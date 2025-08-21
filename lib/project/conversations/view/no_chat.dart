import 'package:flutter/material.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/widgets.dart';
import 'all_widget_chats.dart';

class NoChatVendor extends StatelessWidget {
  const NoChatVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPop(context, "Notifications", AppColors.primaryTextColor),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          NotificationsHeaderWithNavigation(context: context),
          const EmptyConversationContent(),
        ],
      ),
    );
  }
}
