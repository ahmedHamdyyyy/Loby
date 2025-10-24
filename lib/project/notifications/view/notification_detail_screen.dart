import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/widgets.dart';
import '../../../../models/notification.dart';
import '../../../core/localization/l10n_ext.dart';
import 'all_of_notifcation_widget.dart';

class NotificationDetailScreenVendor extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailScreenVendor({super.key, required this.notification});

  String _formatDate(BuildContext context, String raw) {
    if (raw.isEmpty) return '';
    final DateTime? parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.yMMMd(locale).format(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarPop(context, l10n.notificationTitle, AppColors.secondTextColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان الإشعار
            Text(
              l10n.notificationName,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary),
            ),
            const SizedBox(height: 25),
            Text(
              '${l10n.hello} Ahmed Hamdy',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
            ),
            const SizedBox(height: 10),
            Text(
              _formatDate(context, notification.createdAt),
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
