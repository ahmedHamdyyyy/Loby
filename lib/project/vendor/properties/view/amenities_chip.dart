// Selectable amenity chips
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';

class AmenityChips extends StatefulWidget {
  const AmenityChips({super.key, required this.selectedAmenities, required this.onAmenitiesChanged});
  final List<String> selectedAmenities;
  final Function(List<String>) onAmenitiesChanged;
  @override
  State<AmenityChips> createState() => _AmenityChipsState();
}

class _AmenityChipsState extends State<AmenityChips> {
  final List<String> _selectedAmenities = [];
  final List<String> _amenities = [
    "Wifi",
    "TV",
    "Washing machine",
    "pool",
    "Free parking on premises",
    "Kitchen",
    "Waterfront",
    "+   Add other things",
  ];

  @override
  void initState() {
    _selectedAmenities.addAll(widget.selectedAmenities);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    children:
        _amenities.map((amenity) {
          final isSelected = _selectedAmenities.contains(amenity);
          final isLastElement = amenity == _amenities.last;
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
                color:
                    isLastElement
                        ? AppColors.grayTextColor
                        : (widget.selectedAmenities.contains(amenity)
                            ? AppColors.accountTextColor
                            : const Color(0xFF000000)),
              ),
            ),
            selected: isSelected,
            onSelected: (_) {
              if (_selectedAmenities.contains(amenity)) {
                _selectedAmenities.remove(amenity);
              } else {
                _selectedAmenities.add(amenity);
              }
              setState(() {});
              widget.onAmenitiesChanged(_selectedAmenities);
            },
          );
        }).toList(),
  );
}
