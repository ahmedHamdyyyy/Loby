// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/widgets.dart';
import '../../../../config/constants/constance.dart';
import '../../../../locator.dart';
import '../../../../models/notification.dart';
import '../../../core/localization/l10n_ext.dart';
import '../../../core/utils/utile.dart';
import '../../activities/view/screens/activity_screen.dart';
import '../../properties/view/property_screen.dart';
import '../../reservation/view/reservation_details_screen.dart';
import '../logic/cubit.dart';

class NotificationsScreenVendor extends StatefulWidget {
  const NotificationsScreenVendor({super.key});

  @override
  State<NotificationsScreenVendor> createState() => _NotificationsScreenVendorState();
}

class _NotificationsScreenVendorState extends State<NotificationsScreenVendor> {
  bool hasNotifications = true;
  // int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getIt<NotificationsCubit>().loadNotifications();
  }

  // final List<Map<String, dynamic>> notifications = [
  //   {
  //     'id': 1,
  //     'type': 'notification',
  //     'title': 'Notification Name',
  //     'subtitle': 'Lorem ipsum dolor sit amet',
  //     'date': '4/10/2024',
  //     'image': 'assets/svg/loby.svg',
  //   },
  //   {
  //     'id': 2,
  //     'type': 'notification',
  //     'title': 'Notification Name',
  //     'subtitle': 'Lorem ipsum dolor sit amet',
  //     'date': '4/10/2024',
  //     'image': 'assets/svg/loby.svg',
  //   },
  //   {
  //     'id': 3,
  //     'type': 'notification',
  //     'title': 'Notification Name',
  //     'subtitle': 'Lorem ipsum dolor sit amet',
  //     'date': '4/10/2024',
  //     'image': 'assets/svg/loby.svg',
  //   },
  //   {
  //     'id': 4,
  //     'type': 'notification',
  //     'title': 'Notification Name',
  //     'subtitle': 'Lorem ipsum dolor sit amet',
  //     'date': '4/10/2024',
  //     'image': 'assets/svg/loby.svg',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, l10n.notificationsTitle, AppColors.primary),
      body: RefreshIndicator(
        onRefresh: () async => getIt<NotificationsCubit>().loadNotifications(),
        child: BlocConsumer<NotificationsCubit, NotificationsState>(
          listener: (context, state) {
            if (state.loadStatus == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
            } else if (state.readStatus == Status.error) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
            } else if (state.readStatus == Status.success) {
              Navigator.pop(context);
            } else if (state.readStatus == Status.loading) {
              Utils.loadingDialog(context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Text(
                      l10n.yourNotifications,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                  ),
                  if (state.loadStatus == Status.loading)
                    const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
                  else if (state.notifications.isEmpty)
                    const EmptyNotificationsState()
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: NotificationItem(notification: notification),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class EmptyNotificationsState extends StatelessWidget {
  const EmptyNotificationsState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 180),
          Icon(Icons.notifications_off_outlined, size: 130, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            l10n.noNotificationsYet,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  String _formatDate(BuildContext context, String raw) {
    if (raw.isEmpty) return '';
    final DateTime? parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.yMMMd(locale).format(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
          if (!notification.isRead) {
            context.read<NotificationsCubit>().readNotification(notification.id);
          }
          // Navigate based on notification type and entity id when available
          switch (notification.type) {
            case NotificationTypes.newRegistration:
            case NotificationTypes.confirmPayment:
            case NotificationTypes.refund:
              if (notification.entityId.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ReservationDetailsScreen(reservationId: notification.entityId)),
                );
              }
              break;
            case NotificationTypes.newActivity:
            case NotificationTypes.activityVerification:
              if (notification.entityId.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ActivityScreen(activityId: notification.entityId)),
                );
              }
              break;
            case NotificationTypes.newProperty:
            case NotificationTypes.propertyVerification:
              if (notification.entityId.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PropertyScreen(propertyId: notification.entityId)),
                );
              }
              break;
            default:
              break;
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary),
            color: notification.isRead ? AppColors.primary.withOpacity(0.1) : Colors.white,
          ),
          child: Row(
            children: [
              const NotificationIcon(imagePath: 'assets/svg/loby.svg'),
              NotificationContent(
                title: notification.title,
                subtitle: notification.body,
                date: _formatDate(context, notification.createdAt),
              ),
            ],
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
  final String title;
  final String subtitle;
  final String date;

  const NotificationContent({super.key, required this.title, required this.subtitle, required this.date});

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
              title,
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryTextColor),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
