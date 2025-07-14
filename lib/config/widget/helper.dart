import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/colors.dart';

OutlineInputBorder buildOutlineInputBorder(double radius) {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFCBCBCB)),
    borderRadius: BorderRadius.circular(radius),
  );
}

AppBar appBarPop(BuildContext context, String title, Color color) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
      onPressed: () => Navigator.pop(context),
    ),
    title: Text(
      title,
      style: const TextStyle(color: AppColors.grayTextColor, fontSize: 16, fontWeight: FontWeight.w400),
    ),
  );
}

class Driver extends StatefulWidget {
  const Driver({super.key});

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  // final Color color = const Color(0xFFCBCBCB);

  @override
  Widget build(BuildContext context) {
    const Color color = Color(0xFFCBCBCB);
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(height: 1, color: color),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.text, required this.color, required this.fontSize, required this.fontWeight});
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
