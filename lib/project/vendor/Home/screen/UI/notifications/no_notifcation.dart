import 'package:flutter/material.dart';

import 'all_of_notifcation_widget.dart';


class NoChatVendor extends StatelessWidget {
  const NoChatVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            const HeaderSection(),
            const SizedBox(height: 22),
            NotificationsHeaderWithNavigation(context: context),
            const EmptyNotificationsContent(),
          ],
        ),
      ),
    );
  }
}
