// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../config/widget/helper.dart';
import '../../../models/property.dart';
import 'lobby_offers_dialog.dart';
import 'property_screen.dart';

class PropertyTypesScreen extends StatefulWidget {
  const PropertyTypesScreen({super.key});
  @override
  State<PropertyTypesScreen> createState() => _PropertyTypesScreenState();
}

class _PropertyTypesScreenState extends State<PropertyTypesScreen> {
  @override
  void initState() {
    super.initState();
    _showLobbyOffersDialog();
  }

  void _showLobbyOffersDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, barrierDismissible: false, builder: (context) => const LobbyOffersDialog());
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: appBarPop(context, "Categories", AppColors.grayTextColor),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Which of these describes your place ?",
              style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.7,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemCount: PropertyType.values.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PropertyScreen(type: PropertyType.values[index])),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              [
                                ImageAssets.houseCategories,
                                ImageAssets.apartmentCategories,
                                ImageAssets.conbinCategories,
                                ImageAssets.guesthouseCategories,
                                ImageAssets.studioCategories,
                                ImageAssets.yachtCategories,
                                ImageAssets.cruiseCategories,
                              ][index],
                              width: 40,
                              height: 40,
                              color: Colors.black54,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              PropertyType.values[index].name,
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
