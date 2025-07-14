// Dialog showing lobby offers information
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';

class LobbyOffersDialog extends StatelessWidget {
  const LobbyOffersDialog({super.key});

  @override
  Widget build(BuildContext context) => Dialog(
    insetPadding: const EdgeInsets.all(20),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(ImageAssets.closeIcon),
              ),
            ],
          ),
          Text(
            "Lobby Offers",
            style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 8), height: 1.2, width: 120, color: AppColors.primaryColor),
          const SizedBox(height: 16),
          Text(
            'If you add from one apartment to 10, the percentage is 10% - from 0 to 20, the percentage is 15% - more than 25, the percentage is 20%',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('continue', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
          // DialogOptions(),
        ],
      ),
    ),
  );
}
