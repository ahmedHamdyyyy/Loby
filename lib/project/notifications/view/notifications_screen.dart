// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/widgets.dart';
import 'notification_detail_screen.dart';

class NotificationsScreenVendor extends StatefulWidget {
  const NotificationsScreenVendor({super.key});

  @override
  State<NotificationsScreenVendor> createState() => _NotificationsScreenVendorState();
}

class _NotificationsScreenVendorState extends State<NotificationsScreenVendor> {
  bool hasNotifications = true;
  // int _currentIndex = 0;

  final List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'type': 'notification',
      'title': 'Notification Name',
      'subtitle': 'Lorem ipsum dolor sit amet',
      'date': '4/10/2024',
      'image': 'assets/svg/loby.svg',
    },
    {
      'id': 2,
      'type': 'notification',
      'title': 'Notification Name',
      'subtitle': 'Lorem ipsum dolor sit amet',
      'date': '4/10/2024',
      'image': 'assets/svg/loby.svg',
    },
    {
      'id': 3,
      'type': 'notification',
      'title': 'Notification Name',
      'subtitle': 'Lorem ipsum dolor sit amet',
      'date': '4/10/2024',
      'image': 'assets/svg/loby.svg',
    },
    {
      'id': 4,
      'type': 'notification',
      'title': 'Notification Name',
      'subtitle': 'Lorem ipsum dolor sit amet',
      'date': '4/10/2024',
      'image': 'assets/svg/loby.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, "Notifications", AppColors.primary),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                "Your Notifications",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryTextColor),
              ),
            ),
            hasNotifications ? _buildNotificationsList() : const EmptyNotificationsState(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Padding(padding: const EdgeInsets.only(bottom: 16), child: NotificationItem(notification: notification));
      },
    );
  }
}

class EmptyNotificationsState extends StatelessWidget {
  const EmptyNotificationsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 180),
          Icon(Icons.notifications_off_outlined, size: 130, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            'You don\'t have any notifications\nright now',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationDetailScreenVendor(notification: notification)),
          );
        },
        child: Container(
          height: 101,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.primary)),
          child: Row(
            children: [NotificationIcon(imagePath: notification['image']), NotificationContent(notification: notification)],
          ),
        ),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final String imagePath;

  const NotificationIcon({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 101,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade100),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: SvgPicture.asset("assets/svg/loby.svg", height: 22, width: 83, color: AppColors.primary),
    );
  }
}

class NotificationContent extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationContent({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notification['title'],
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryTextColor),
            ),
            const SizedBox(height: 4),
            Text(
              notification['subtitle'],
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
            ),
            const SizedBox(height: 4),
            Text(
              notification['date'],
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
