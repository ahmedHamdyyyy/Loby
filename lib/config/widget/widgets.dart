import 'package:flutter/material.dart';
import '../colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
AppBar appBarPop(BuildContext context,String title,Color color) {
    return AppBar(
      backgroundColor: Colors.white,

      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(title,style: GoogleFonts.poppins(
          color: AppColors.grayTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

