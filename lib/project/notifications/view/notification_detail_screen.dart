import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/widgets.dart';
import 'all_of_notifcation_widget.dart';

class NotificationDetailScreenVendor extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationDetailScreenVendor({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, "Notification", AppColors.secondTextColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان الإشعار
            Text(
              'Notification Name',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary),
            ),
            const SizedBox(height: 25),
            Text(
              'Hello Ahmed Hamdy',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
            ),
            const SizedBox(height: 10),
            Text(
              '24/07/2024',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.grayTextColor),
            ),
            const SizedBox(height: 25),
            // رسالة تأكيد الحجز
            buildLongText(),
            const SizedBox(height: 130),
            // زر عرض تفاصيل الحجز
          ],
        ),
      ),
    );
  }
}
