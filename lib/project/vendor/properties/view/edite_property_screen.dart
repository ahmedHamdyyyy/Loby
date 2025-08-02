// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;

import '../../../../config/colors/colors.dart';
import '../../../../config/constants/constance.dart';
import '../../../../config/images/assets.dart';
import '../../../../config/images/image_assets.dart';
import '../../Home/screen/UI/properties/all_properts_widget.dart';
import '../../Home/screen/UI/properties/location_screens.dart';
import '../../models/property_model.dart';
import '../cubit/cubit.dart';
import 'amenities_chip.dart';
import 'basics_section.dart';
import 'calender_widget.dart';
import 'document_section.dart';
import 'images_section.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key, this.propertyId = '', this.type = 'house'});
  final String propertyId;
  final String type;
  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  bool isStudioAvailable = false, showAvailabilitySection = true, isSelected = true;
  List<String> _imagePaths = [], _contractPaths = [], _licensePaths = [];
  int guests = 1, bedrooms = 1, beds = 1, bathrooms = 1;
  final addressController = TextEditingController();
  final detailsController = TextEditingController();
  final priceController = TextEditingController();
  List<String> selectedAmenities = [];
  Set<DateTime> selectedDates = {};
  String propertyType = '';

  @override
  void initState() {
    super.initState();
    _setProperty();
  }

  void _setProperty() async {
    final property = await context.read<PropertiesCubit>().getProperty(widget.propertyId);
    guests = property.guestNumber;
    bedrooms = property.bedrooms;
    beds = property.beds;
    bathrooms = property.bathrooms;
    addressController.text = property.address;
    detailsController.text = property.details;
    priceController.text = property.pricePerNight.toString();
    selectedAmenities = property.tags;
    propertyType = property.type;
    isSelected = !property.available;
    _contractPaths.addAll(property.ownershipContract);
    _licensePaths.addAll(property.facilityLicense);
    selectedDates =
        property.availableDates.map((date) {
          final parts = date.split('-');
          return DateTime.parse('${parts[0]}-${parts[1]}-${parts[2]}');
        }).toSet();
    _imagePaths.addAll(property.medias);
    setState(() {});
  }

  bool _validateForm() {
    if (addressController.text.isEmpty ||
        detailsController.text.isEmpty ||
        priceController.text.isEmpty ||
        selectedDates.isEmpty ||
        _contractPaths.isEmpty ||
        _imagePaths.isEmpty ||
        selectedAmenities.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields')));
      return false;
    }

    try {
      final price = int.parse(priceController.text);
      if (price <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Price must be greater than 0')));
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid price')));
      return false;
    }

    for (String imagePath in _imagePaths) {
      if (!imagePath.startsWith('http')) {
        // Only check new uploaded files
        String extension = path.extension(imagePath).toLowerCase().replaceAll('.', '');
        if (!['jpg', 'jpeg', 'png'].contains(extension)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Please use only jpg, jpeg, or png files for images')));
          return false;
        }
      }
    }

    return true;
  }

  void _submitForm() async {
    if (_validateForm()) {
      try {
        final formattedDates =
            selectedDates.map((date) {
              return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
            }).toList();
        final property = PropertyModel(
          id: widget.propertyId,
          facilityLicense: _licensePaths,
          type: 'house',
          available: !isSelected,
          guestNumber: guests,
          bedrooms: bedrooms,
          bathrooms: bathrooms,
          beds: beds,
          address: addressController.text,
          details: detailsController.text,
          tags: selectedAmenities,
          pricePerNight: int.parse(priceController.text),
          availableDates: formattedDates,
          maxDays: 5,
          ownershipContract: _contractPaths,
          medias: _imagePaths,
        );
        if (widget.propertyId.isEmpty) {
          context.read<PropertiesCubit>().createProperty(property);
        } else {
          context.read<PropertiesCubit>().updateProperty(property);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error preparing files: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<PropertiesCubit, PropertiesState>(
    listener: (context, state) {
      if (state.updateStatus == Status.success && state.createStatus == Status.success) {
        Navigator.pop(context); // Return to previous screen after successful update
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تحديث العقار بنجاح')));
      } else if (state.updateStatus == Status.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
      }
    },
    builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  if (state.getPropertyStatus == Status.loading)
                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withAlpha(125),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            const SizedBox(height: 20),
                            Text(
                              'برجاء الانتظار...',
                              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'جاري تحميل البيانات',
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: 195,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            child: Image.asset(switch (propertyType.toLowerCase()) {
                              'house' => AssetsData.house,
                              'apartment' => AssetsData.house,
                              'cabin' => AssetsData.house,
                              'guest_house' => AssetsData.house,
                              'studio' => AssetsData.studio,
                              'yacht' => AssetsData.yacht,
                              'cruise' => AssetsData.cruise,
                              _ => AssetsData.house,
                            }, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 16,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
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
                            'Please enter your $propertyType information',
                            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          if (showAvailabilitySection)
                            AvailabilityToggleSection(
                              type: propertyType,
                              isSelected: isSelected,
                              onToggleAvailability: (isAvailable) => setState(() => isSelected = isAvailable),
                            ),
                          PropertyBasicsSection(
                            guests: guests,
                            bedrooms: bedrooms,
                            beds: beds,
                            bathrooms: bathrooms,
                            onGuestsChanged: (value) => guests = value,
                            onBedroomsChanged: (value) => bedrooms = value,
                            onBedsChanged: (value) => beds = value,
                            onBathroomsChanged: (value) => bathrooms = value,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Address",
                                style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              if (showAvailabilitySection)
                                SvgPicture.asset(
                                  ImageAssets.editIcon,
                                  color: AppColors.editIconColor,
                                  width: 20,
                                  height: 20,
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              hintText: "Enter your address",
                              hintStyle: GoogleFonts.poppins(color: const Color(0xFF757575)),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LocationConfirmationScreen()),
                                  );
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
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add Some details",
                                style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              if (showAvailabilitySection)
                                SvgPicture.asset(
                                  ImageAssets.editIcon,
                                  color: AppColors.editIconColor,
                                  width: 20,
                                  height: 20,
                                ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: detailsController,
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
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Tell guests what your place has to offer",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AmenityChips(
                            selectedAmenities: selectedAmenities,
                            onAmenitiesChanged: (amenities) => selectedAmenities = amenities,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                !showAvailabilitySection ? "Upload studio photos or video" : "studio photos or video",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              if (showAvailabilitySection)
                                SvgPicture.asset(
                                  ImageAssets.editIcon,
                                  color: AppColors.editIconColor,
                                  width: 20,
                                  height: 20,
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          PropertyImagesSection(
                            imagePaths: _imagePaths,
                            onImagesChanged: (imagesPaths) => _imagePaths = imagesPaths,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  !showAvailabilitySection
                                      ? "Upload Lease or ownership contract"
                                      : "Lease or ownership contract",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              if (showAvailabilitySection)
                                SvgPicture.asset(
                                  ImageAssets.editIcon,
                                  color: AppColors.editIconColor,
                                  width: 20,
                                  height: 20,
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          DocumentUploader(
                            label: "Upload Lease or ownership contract",
                            paths: _contractPaths,
                            onPathesChanged: (paths) => _contractPaths = paths,
                          ),
                          const SizedBox(height: 10),
                          Column(
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
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (showAvailabilitySection)
                                    SvgPicture.asset(
                                      ImageAssets.editIcon,
                                      color: AppColors.editIconColor,
                                      width: 20,
                                      height: 20,
                                    ),
                                ],
                              ),
                              if (!showAvailabilitySection)
                                Text(
                                  "( optional )",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grayTextColor,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          DocumentUploader(
                            label: "Upload Tourist hospitality facility license",
                            paths: _licensePaths,
                            onPathesChanged: (paths) => _licensePaths = paths,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Available dates",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              if (showAvailabilitySection)
                                SvgPicture.asset(
                                  ImageAssets.editIcon,
                                  color: AppColors.editIconColor,
                                  width: 20,
                                  height: 20,
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CalendarSection(selectedDates: selectedDates, onDatesChanged: (dates) => selectedDates = dates),
                          const SizedBox(height: 16),
                          PriceSectionHeader(showEditIcon: showAvailabilitySection),
                          const SizedBox(height: 8),
                          PriceTextField(controller: priceController),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Text("تحديث", style: GoogleFonts.poppins(fontSize: 16, color: AppColors.whiteColor)),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (context.watch<PropertiesCubit>().state.updateStatus == Status.loading)
              Container(
                color: Colors.black.withAlpha(125),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                      const SizedBox(height: 20),
                      Text(
                        'برجاء الانتظار...',
                        style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'جاري تحديث البيانات',
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    },
  );
}
