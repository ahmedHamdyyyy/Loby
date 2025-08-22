// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';

class AvailabilityToggleSection extends StatelessWidget {
  final String type;
  final bool isSelected;
  final void Function(bool) onToggleAvailability;

  const AvailabilityToggleSection({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onToggleAvailability,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Are your $type", style: TextStyle(color: AppColors.secondTextColor, fontWeight: FontWeight.w400, fontSize: 16)),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildOptionContainer(label: "Available", isActive: !isSelected, onTap: () => onToggleAvailability(true)),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: _buildOptionContainer(
              label: "Not Available",
              isActive: isSelected,
              onTap: () => onToggleAvailability(false),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
    ],
  );

  Widget _buildOptionContainer({required String label, required bool isActive, required VoidCallback onTap}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: onTap,
              child:
                  isActive
                      ? SvgPicture.asset(ImageAssets.cracalBlack, width: 20, height: 20)
                      : SvgPicture.asset(ImageAssets.cracalWhite, width: 20, height: 20),
            ),
          ),
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.grayTextColor)),
        ],
      ),
    );
  }
}

// Header for price section
class PriceSectionHeader extends StatelessWidget {
  const PriceSectionHeader({super.key, required this.showEditIcon});
  final bool showEditIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Price", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.primaryColor, fontSize: 16)),
        if (showEditIcon) SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
      ],
    );
  }
}

// TextField for price input
class PriceTextField extends StatelessWidget {
  final TextEditingController controller;

  const PriceTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: "Enter price per night",
        hintStyle: GoogleFonts.poppins(color: const Color(0xFF757575)),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCBCBCB)),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCBCBCB)),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCBCBCB)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter your Price";
        return null;
      },
    );
  }
}

/// Title widget for the agreement screen
class AgreementTitle extends StatelessWidget {
  const AgreementTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Loby Platform Usage Agreement',
      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.primaryColor),
    );
  }
}

/// Reusable widget for agreement text sections
class AgreementSection extends StatelessWidget {
  final String text;
  final bool isPrimary;

  const AgreementSection({super.key, required this.text, required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: isPrimary ? FontWeight.w500 : FontWeight.w400,
        color: isPrimary ? AppColors.primaryColor : AppColors.secondTextColor,
      ),
    );
  }
}

/// Checkbox widget for agreement acceptance
class AgreementCheckbox extends StatelessWidget {
  final bool isAgreed;
  final VoidCallback onToggle;

  const AgreementCheckbox({super.key, required this.isAgreed, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isAgreed ? AppColors.primaryColor : Colors.transparent,
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: isAgreed ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'I agree to all the terms and conditions',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
          ),
        ),
      ],
    );
  }
}

/// Continue button widget
class ContinueButton extends StatelessWidget {
  final bool isEnabled;

  const ContinueButton({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isEnabled ? () => Navigator.pop(context) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text('Continue', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
      ),
    );
  }
}

/// Displays the map background image
class MapBackground extends StatelessWidget {
  const MapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: Image.asset(ImageAssets.mapImage, fit: BoxFit.fill));
  }
}

/// Search bar positioned at the top of the screen
class LocationSearchBar extends StatelessWidget {
  const LocationSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: const Row(children: [SearchIcon(), SizedBox(width: 10), SearchTextField()]),
      ),
    );
  }
}

/// Search icon for the search bar
class SearchIcon extends StatelessWidget {
  const SearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(ImageAssets.searchIcon, width: 24, height: 24, color: AppColors.grayColorIcon);
  }
}

/// Text field for location search
class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search location',
          hintStyle: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

/// Location marker displayed at the center of the map
class MapMarker extends StatelessWidget {
  const MapMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        ImageAssets.locationIcon,
        width: 48,
        height: 48,
        colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      ),
    );
  }
}

/// Bottom panel showing the selected location and confirmation button
class LocationConfirmationPanel extends StatelessWidget {
  const LocationConfirmationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [LocationAddressRow(), SizedBox(height: 20), ConfirmButton()],
          ),
        ),
      ),
    );
  }
}

/// Row displaying the location address with an icon
class LocationAddressRow extends StatelessWidget {
  const LocationAddressRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(ImageAssets.locationIcon, width: 24, height: 24, color: AppColors.primaryColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "Riyadh - Kingdom of Saudi Arabia",
            style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

/// Confirmation button
class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          // Handle confirmation
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text("Confirm", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
