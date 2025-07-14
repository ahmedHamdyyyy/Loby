// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/images/image_assets.dart';
import '../../../../../../config/constants/constance.dart';
import 'location_screens.dart';

// Header section with banner image and back button
class HeaderImageSection extends StatelessWidget {
  final String imagePath;
  final String type;
  const HeaderImageSection({super.key, required this.imagePath, required this.type});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 195,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 50,
          left: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              ImageAssets.backIcon,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            'Please enter your ${type} information',
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}

// Availability toggle section
class AvailabilityToggleSection extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onToggleAvailable;
  final VoidCallback onToggleNotAvailable;

  const AvailabilityToggleSection({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onToggleAvailable,
    required this.onToggleNotAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Are your ${type}",
          style: TextStyle(color: AppColors.secondTextColor, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildOptionContainer(label: "Available", isActive: !isSelected, onTap: onToggleAvailable),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: _buildOptionContainer(label: "Not Available", isActive: isSelected, onTap: onToggleNotAvailable),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

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
              child: isActive
                  ? SvgPicture.asset(ImageAssets.cracalBlack, width: 20, height: 20)
                  : SvgPicture.asset(ImageAssets.cracalWhite, width: 20, height: 20),
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.grayTextColor),
          ),
        ],
      ),
    );
  }
}

// Property basics section with counters
class PropertyBasicsSection extends StatelessWidget {
  final int guests;
  final int bedrooms;
  final int beds;
  final int bathrooms;
  final VoidCallback onGuestsIncrement;
  final VoidCallback onGuestsDecrement;
  final VoidCallback onBedroomsIncrement;
  final VoidCallback onBedroomsDecrement;
  final VoidCallback onBedsIncrement;
  final VoidCallback onBedsDecrement;
  final VoidCallback onBathroomsIncrement;
  final VoidCallback onBathroomsDecrement;

  const PropertyBasicsSection({
    super.key,
    required this.guests,
    required this.bedrooms,
    required this.beds,
    required this.bathrooms,
    required this.onGuestsIncrement,
    required this.onGuestsDecrement,
    required this.onBedroomsIncrement,
    required this.onBedroomsDecrement,
    required this.onBedsIncrement,
    required this.onBedsDecrement,
    required this.onBathroomsIncrement,
    required this.onBathroomsDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Share some basics about your place",
          style: GoogleFonts.poppins(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 15),
        CounterItem(label: "Guests number", value: guests, onIncrement: onGuestsIncrement, onDecrement: onGuestsDecrement),
        CounterItem(label: "Bedrooms", value: bedrooms, onIncrement: onBedroomsIncrement, onDecrement: onBedroomsDecrement),
        CounterItem(label: "Bed", value: beds, onIncrement: onBedsIncrement, onDecrement: onBedsDecrement),
        CounterItem(
          label: "Bathroom",
          value: bathrooms,
          onIncrement: onBathroomsIncrement,
          onDecrement: onBathroomsDecrement,
        ),
      ],
    );
  }
}

// Counter item for property basics
class CounterItem extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterItem({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                GestureDetector(onTap: onDecrement, child: SvgPicture.asset(ImageAssets.removeIcon, width: 22, height: 22)),
                const SizedBox(width: 10),
                Text(
                  value.toString(),
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.secondTextColor),
                ),
                const SizedBox(width: 10),
                GestureDetector(onTap: onIncrement, child: SvgPicture.asset(ImageAssets.addIcon, width: 22, height: 22)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// Header for address section
class AddressSectionHeader extends StatelessWidget {
  final bool showEditIcon;

  const AddressSectionHeader({super.key, required this.showEditIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Address",
          style: GoogleFonts.poppins(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        if (showEditIcon) SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
      ],
    );
  }
}

// TextField for address input
class AddressTextField extends StatelessWidget {
  final TextEditingController controller;

  const AddressTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Enter your address",
        hintStyle: GoogleFonts.poppins(color: const Color(0xFF757575)),
        prefixIcon: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationConfirmationScreen()));
          },
          icon: SvgPicture.asset(ImageAssets.locationIcon, width: 20, height: 20),
        ),
        suffixIcon: const Icon(Icons.add, color: AppColors.grayColorIcon),
        prefixIconColor: AppColors.primaryColor,
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
    );
  }
}

// Header for details section
class DetailsSectionHeader extends StatelessWidget {
  final bool showEditIcon;

  const DetailsSectionHeader({super.key, required this.showEditIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Add Some details",
          style: GoogleFonts.poppins(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        if (showEditIcon) SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
      ],
    );
  }
}

// TextField for details input
class DetailsTextField extends StatelessWidget {
  final TextEditingController controller;

  const DetailsTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "Add Details",
        hintStyle: GoogleFonts.poppins(color: const Color(0xFF757575)),
        prefixIconColor: AppColors.primaryColor,
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
    );
  }
}

// Header for amenities section
class AmenitiesSectionHeader extends StatelessWidget {
  const AmenitiesSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Tell guests what your place has to offer",
      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.primaryColor, fontSize: 16),
    );
  }
}

// Selectable amenity chips
class AmenityChips extends StatelessWidget {
  final List<String> amenities;
  final List<String> selectedAmenities;
  final Function(String) onAmenitySelected;

  const AmenityChips({super.key, required this.amenities, required this.selectedAmenities, required this.onAmenitySelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: amenities.map((amenity) {
        final isSelected = selectedAmenities.contains(amenity);
        final isLastElement = amenity == amenities.last;
        return FilterChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Color(0xFFCBCBCB)),
          ),
          backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
          label: Text(
            amenity,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isLastElement
                  ? AppColors.grayTextColor
                  : (selectedAmenities.contains(amenity) ? AppColors.accountTextColor : const Color(0xFF000000)),
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onAmenitySelected(amenity),
        );
      }).toList(),
    );
  }
}

// Header for photos section
class PhotosSectionHeader extends StatelessWidget {
  final bool showAvailabilitySection;
  final bool showEditIcon;

  const PhotosSectionHeader({super.key, required this.showAvailabilitySection, required this.showEditIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          !showAvailabilitySection ? "Upload studio photos or video" : "studio photos or video",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
        ),
        if (showEditIcon) SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
      ],
    );
  }
}

// Property image upload section
class PropertyImageUpload extends StatelessWidget {
  final List<String> imagePaths;
  final VoidCallback onPickImage;
  final Function(String) onRemoveImage;

  const PropertyImageUpload({
    super.key, 
    required this.imagePaths, 
    required this.onPickImage, 
    required this.onRemoveImage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imagePaths.isEmpty)
            EmptyImageUploadPrompt(onTap: onPickImage)
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...imagePaths.map((imagePath) => 
                    ImageThumbnail(
                      imagePath: imagePath,
                      onRemove: () => onRemoveImage(imagePath),
                    )
                  ),
                  if (imagePaths.length < 10) 
                    AddImageButton(onTap: onPickImage),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Empty state for image upload
class EmptyImageUploadPrompt extends StatelessWidget {
  final VoidCallback onTap;

  const EmptyImageUploadPrompt({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(ImageAssets.uploadIcon, width: 40, height: 40),
            const SizedBox(height: 8),
            Text(
              "Upload photos with high quality",
              style: GoogleFonts.poppins(
                fontSize: 14, 
                fontWeight: FontWeight.w400, 
                color: AppColors.grayTextColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Thumbnail for an individual image
class ImageThumbnail extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRemove;

  const ImageThumbnail({
    super.key, 
    required this.imagePath, 
    required this.onRemove
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imagePath.startsWith('http') 
              ? Image.network(
                  imagePath,
                  width: 80,
                  height: 71,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 80,
                      height: 71,
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('Error loading image: $error');
                    return Container(
                      width: 80,
                      height: 71,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                    );
                  },
                )
              : Image.file(
                  File(imagePath),
                  width: 80,
                  height: 71,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint('Error loading local image: $error');
                    return Container(
                      width: 80,
                      height: 71,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
          ),
          Positioned(
            top: -8,
            right: -2,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0XFFCC0000),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Button for adding a new image
class AddImageButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddImageButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 71,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFCBCBCB)),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Color(0xFFCBCBCB),
            size: 30,
          ),
        ),
      ),
    );
  }
}

// Header for contract section
class ContractSectionHeader extends StatelessWidget {
  final bool showAvailabilitySection;
  final bool showEditIcon;

  const ContractSectionHeader({super.key, required this.showAvailabilitySection, required this.showEditIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            !showAvailabilitySection ? "Upload Lease or ownership contract" : "Lease or ownership contract",
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
          ),
        ),
        if (showEditIcon) SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
      ],
    );
  }
}

// Header for license section
class LicenseSectionHeader extends StatelessWidget {
  final bool showAvailabilitySection;
  final bool showEditIcon;

  const LicenseSectionHeader({super.key, required this.showAvailabilitySection, required this.showEditIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                !showAvailabilitySection
                    ? "Upload Tourist hospitality facility license"
                    : "Tourist hospitality facility license",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
              ),
            ),
            if (showEditIcon) SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
          ],
        ),
        if (!showAvailabilitySection)
          Text(
            "( optional )",
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
          ),
      ],
    );
  }
}

// Document uploader component
class DocumentUploader extends StatelessWidget {
  final String label;
  final List<String> imagePaths;
  final VoidCallback onPickDocument;
  final Function(String) onRemoveDocument;
  final bool isPdf;

  const DocumentUploader({
    super.key,
    required this.label,
    required this.imagePaths,
    required this.onPickDocument,
    required this.onRemoveDocument,
    this.isPdf = false,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isNotEmpty) {
      return DocumentUploadWithPreview(
        imagePaths: imagePaths,
        isPdf: isPdf,
        onTap: onPickDocument,
        onRemoveDocument: onRemoveDocument,
      );
    } else {
      return EmptyDocumentUpload(label: label, onTap: onPickDocument);
    }
  }
}

// Empty state for document upload
class EmptyDocumentUpload extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const EmptyDocumentUpload({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCBCBCB)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(onTap: onTap, child: SvgPicture.asset(ImageAssets.uploadIcon, width: 40, height: 40)),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Document upload with preview
class DocumentUploadWithPreview extends StatelessWidget {
  final List<String> imagePaths;
  final bool isPdf;
  final VoidCallback onTap;
  final Function(String) onRemoveDocument;

  const DocumentUploadWithPreview({
    super.key,
    required this.imagePaths,
    required this.isPdf,
    required this.onTap,
    required this.onRemoveDocument,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCBCBCB)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...imagePaths.map(
                  (imagePath) =>
                      DocumentThumbnail(imagePath: imagePath, isPdf: isPdf, onRemove: () => onRemoveDocument(imagePath)),
                ),
                if (imagePaths.length < 10) AddDocumentButton(onTap: onTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Thumbnail for a document (PDF or image)
class DocumentThumbnail extends StatelessWidget {
  final String imagePath;
  final bool isPdf;
  final VoidCallback onRemove;

  const DocumentThumbnail({super.key, required this.imagePath, required this.isPdf, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          isPdf
              ? Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Image.asset(ImageAssets.pdfIcon, width: 70, height: 75)],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(File(imagePath), width: 80, height: 80, fit: BoxFit.cover),
                ),
          Positioned(
            top: -0,
            right: -5,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(color: Color(0XFFCC0000), shape: BoxShape.circle),
                child: const Center(child: Icon(Icons.close, size: 15, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Button for adding a new document
class AddDocumentButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddDocumentButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Center(child: Icon(Icons.add, color: Color(0xFFCBCBCB), size: 30)),
      ),
    );
  }
}

// Header for available dates section
class AvailableDatesSectionHeader extends StatelessWidget {
  final bool showEditIcon;

  const AvailableDatesSectionHeader({super.key, required this.showEditIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Available dates",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.primaryColor, fontSize: 16),
        ),
        if (showEditIcon) SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
      ],
    );
  }
}

// Calendar header with navigation
class CalendarHeader extends StatelessWidget {
  final int month;
  final int year;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const CalendarHeader({
    super.key,
    required this.month,
    required this.year,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  String _getMonthName(int month) => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ][month - 1];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${_getMonthName(month)} $year",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: onPreviousMonth,
              icon: const Icon(Icons.chevron_left, color: AppColors.primaryColor),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: onNextMonth,
              icon: const Icon(Icons.chevron_right, color: AppColors.primaryColor),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }
}

// Calendar widget
class CalendarWidget extends StatelessWidget {
  final DateTime currentMonth;
  final Set<DateTime> selectedDates;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final Function(DateTime) onSelectDate;

  const CalendarWidget({
    super.key,
    required this.currentMonth,
    required this.selectedDates,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarHeader(
            month: currentMonth.month,
            year: currentMonth.year,
            onPreviousMonth: onPreviousMonth,
            onNextMonth: onNextMonth,
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFCBCBCB)),
          const SizedBox(height: 16),
          // Selected dates summary
          if (selectedDates.isNotEmpty) ...[
            Text(
              'Selected Dates (${selectedDates.length}):',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedDates.map((date) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${date.day}/${date.month}/${date.year}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => onSelectDate(date),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFCBCBCB)),
            const SizedBox(height: 16),
          ],
          // Calendar days of week header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              'Sun',
              'Mon',
              'Tue',
              'Wed',
              'Thu',
              'Fri',
              'Sat',
            ].map((day) {
              return SizedBox(
                width: 35,
                child: Center(
                  child: Text(
                    day,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayTextColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          // Calendar grid
          CalendarGrid(
            currentMonth: currentMonth,
            selectedDates: selectedDates,
            onSelectDate: onSelectDate,
          ),
        ],
      ),
    );
  }
}

// Calendar grid
class CalendarGrid extends StatelessWidget {
  final DateTime currentMonth;
  final Set<DateTime> selectedDates;
  final Function(DateTime) onSelectDate;

  const CalendarGrid({
    super.key,
    required this.currentMonth,
    required this.selectedDates,
    required this.onSelectDate,
  });

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: 42, // 6 rows of 7 days
      itemBuilder: (context, index) {
        final firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
        final firstDayOffset = firstDay.weekday % 7;
        final displayIndex = index - firstDayOffset;
        final daysInMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
        final isCurrentMonth = displayIndex >= 0 && displayIndex < daysInMonth;

        final day = isCurrentMonth
            ? displayIndex + 1
            : displayIndex < 0
                ? DateTime(currentMonth.year, currentMonth.month, 0).day + displayIndex + 1
                : displayIndex - daysInMonth + 1;

        final date = isCurrentMonth
            ? DateTime(currentMonth.year, currentMonth.month, day)
            : displayIndex < 0
                ? DateTime(currentMonth.year, currentMonth.month - 1, day)
                : DateTime(currentMonth.year, currentMonth.month + 1, day);

        final isSelected = selectedDates.any((selectedDate) => _isSameDay(selectedDate, date));
        final isPastDate = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

        return CalendarDay(
          day: day,
          isCurrentMonth: isCurrentMonth,
          isSelected: isSelected,
          isDisabled: isPastDate,
          onTap: (isCurrentMonth && !isPastDate) ? () => onSelectDate(date) : null,
        );
      },
    );
  }
}

// Individual calendar day
class CalendarDay extends StatelessWidget {
  final int day;
  final bool isCurrentMonth;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  const CalendarDay({
    super.key,
    required this.day,
    required this.isCurrentMonth,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && onTap != null;
    
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        height: 35,
        width: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : null,
          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          day.toString(),
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: !isCurrentMonth
                ? Colors.grey.withOpacity(0.3)
                : isDisabled
                    ? Colors.grey.withOpacity(0.3)
                    : isSelected
                        ? Colors.white
                        : AppColors.primaryColor,
          ),
        ),
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
        Text(
          "Price",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.primaryColor, fontSize: 16),
        ),
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
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
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
        child: Text(
          'Continue',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
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
        child: Text(
          "Confirm",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
