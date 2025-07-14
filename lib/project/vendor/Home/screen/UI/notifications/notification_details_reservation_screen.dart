// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/widget/widgets.dart';

class NotificationDetailsReservationScreen extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationDetailsReservationScreen({super.key, required this.notification});

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
            Text('24/07/2024', style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor)),
            const SizedBox(height: 25),

            // رسالة تأكيد الحجز
            Text(
              'Your studio reservation has been successfully completed!',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.grayTextColor,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 130),

            // زر عرض تفاصيل الحجز
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  /*  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReservationScreen()));
                  // التنقل إلى شاشة تفاصيل الحجز
                  print('Navigate to reservation details'); */
                },
                child: Text(
                  'Show reservation details',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
