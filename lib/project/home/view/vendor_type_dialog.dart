import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../config/constants/constance.dart';
import '../../activities/view/screens/activity_screen.dart';

class VendorTypeDialog extends StatelessWidget {
  const VendorTypeDialog({super.key});
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
          Text(
            "Please choose",
            style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 8), height: 1.2, width: 120, color: AppColors.primaryColor),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, VendorRole.property);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const PropertyTypesScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 48),
            ),
            child: Text(
              "Property owner",
              style: GoogleFonts.poppins(color: AppColors.primaryColor, fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, VendorRole.activity);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityScreen(activityId: '')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              "Tourist activity",
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    ),
  );
}
