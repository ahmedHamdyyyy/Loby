// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../config/widget/helper.dart';
import '../../../../locator.dart';
import '../cubit/cubit.dart';
import 'add_property_screen.dart';
import 'lobby_offers_dialog.dart';

typedef PropertyType = ({String name, String icon});

class PropertyTypesScreen extends StatefulWidget {
  const PropertyTypesScreen({super.key});

  @override
  State<PropertyTypesScreen> createState() => _PropertyTypesScreenState();
}

class _PropertyTypesScreenState extends State<PropertyTypesScreen> {
  // Selected property type
  String? selectedPropertyType;

  // Helper function to convert display name to backend value
  String _convertToBackendType(String displayName) {
    switch (displayName.toLowerCase()) {
      case 'house':
        return 'house';
      case 'flat / appartment':
        return 'apartment';
      case 'cabin':
        return 'cabin';
      case 'guest-house':
        return 'guest_house';
      case 'studio':
        return 'studio';
      case 'yacht':
        return 'yacht';
      case 'cruise':
        return 'cruise';
      default:
        return displayName.toLowerCase();
    }
  }

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

  void _selectPropertyType(String typeName) {
    final String backendType = _convertToBackendType(typeName);
    setState(() => selectedPropertyType = typeName);
    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => BlocProvider.value(value: getIt<PropertiesCubit>(), child: PropertyScreen(type: backendType)),
        builder: (context) => BlocProvider.value(value: getIt<PropertiesCubit>(), child: PropertyScreen(type: backendType)),
      ),
    );
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
              child: PropertyTypesGrid(
                propertyTypes: propertyTypes,
                selectedType: selectedPropertyType,
                onSelectType: _selectPropertyType,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class PropertyTypesGrid extends StatelessWidget {
  const PropertyTypesGrid({super.key, required this.propertyTypes, required this.selectedType, required this.onSelectType});
  final List<PropertyType> propertyTypes;
  final String? selectedType;
  final Function(String) onSelectType;

  @override
  Widget build(BuildContext context) => GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1.7,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
    ),
    itemCount: propertyTypes.length,
    itemBuilder: (context, index) {
      final propertyType = propertyTypes[index];
      final isSelected = selectedType == propertyTypes[index].name;
      return GestureDetector(
        onTap: () => onSelectType(propertyTypes[index].name),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: isSelected ? AppColors.primaryColor : Colors.grey.shade300, width: isSelected ? 2 : 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  propertyType.icon,
                  width: 40,
                  height: 40,
                  color: isSelected ? AppColors.primaryColor : Colors.black54,
                ),
                const SizedBox(height: 8),
                Text(
                  propertyType.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isSelected ? AppColors.primaryColor : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// List of property types with their icons
final List<PropertyType> propertyTypes = [
  (name: 'House', icon: ImageAssets.houseCategories),
  (name: 'Flat / Appartment', icon: ImageAssets.apartmentCategories),
  (name: 'Cabin', icon: ImageAssets.conbinCategories),
  (name: 'Guest-house', icon: ImageAssets.guesthouseCategories),
  (name: 'Studio', icon: ImageAssets.studioCategories),
  (name: 'Yacht', icon: ImageAssets.yachtCategories),
  (name: 'Cruise', icon: ImageAssets.cruiseCategories),
];
