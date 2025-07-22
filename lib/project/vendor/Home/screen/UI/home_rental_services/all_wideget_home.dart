import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/images/image_assets.dart';
import '../../../../activities/view/screens/home_view.dart';
import '../../../../properties/view/property_types_screen.dart';

/// Dialog for selecting vendor type
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
          Column(
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
                "Please choose",
                style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 1.2,
                width: 120,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 25),
          const DialogOptions(),
        ],
      ),
    ),
  );
}

/// Options for the vendor type dialog
class DialogOptions extends StatelessWidget {
  const DialogOptions({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PropertyTypesScreen())),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Property owner",
            style: GoogleFonts.poppins(color: AppColors.primaryColor, fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
      ),
      const SizedBox(height: 20),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityRegistrationScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            "Tourist activty",
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
      ),
      const SizedBox(height: 50),
    ],
  );
}
