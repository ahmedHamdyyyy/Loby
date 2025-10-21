import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';
import '../../../core/localization/l10n_ext.dart';
import 'notifications_screen.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          l10n.notificationsTitle,
          style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ],
    );
  }
}

class NotificationsHeaderWithNavigation extends StatelessWidget {
  final BuildContext context;

  const NotificationsHeaderWithNavigation({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return InkWell(
      onTap: () => _navigateToNotifications(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: GestureDetector(
          onTap: () => _navigateToNotifications(context),
          child: Text(
            l10n.yourNotifications,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  void _navigateToNotifications(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreenVendor()));
  }
}

class EmptyNotificationsContent extends StatelessWidget {
  const EmptyNotificationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              margin: const EdgeInsets.only(bottom: 24),
              child: SvgPicture.asset(ImageAssets.chat),
            ),
            Text(
              l10n.noNotificationsYet,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondTextColor,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// محتوى نصي مفصل للإشعار
Widget buildLongText() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay lorem ipsum dolor sit amet, consecr text Diam habitant ',
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
      ),
      const SizedBox(height: 12),
      Text(
        'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay lorem ipsum dolor sit amet, consecr text Diam habitant.',
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
      ),
      const SizedBox(height: 12),
      Text(
        'Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay lorem ipsum dolor sit amet.',
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
      ),
    ],
  );
}
