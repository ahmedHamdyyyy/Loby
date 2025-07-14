// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../config/images/assets.dart';
import '../../../../config/images/image_assets.dart';
import '../../Home/cubit/home_cubit.dart';
import '../../Home/cubit/home_state.dart';
import '../../Home/screen/UI/properties/all_properts_widget.dart';
import '../../Home/screen/widget/pick_image_widget.dart';
import '../../models/property_model.dart';
import '../cubit/cubit.dart';

class EditPropertyScreen extends StatefulWidget {
  const EditPropertyScreen({super.key, required this.propertyId});
  final String propertyId;
  
  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  int guests = 1, bedrooms = 1, beds = 1, bathrooms = 1;
  final addressController = TextEditingController();
  final detailsController = TextEditingController();
  final priceController = TextEditingController();

  bool isStudioAvailable = false, showAvailabilitySection = true, isSelected = true;

  final List<String> _imagePaths = [];
  String? _contractPath, _licensePath;
  final _picker = ImagePicker();

  final List<String> _supportedImageTypes = ['jpg', 'jpeg', 'png'];

  DateTime currentMonth = DateTime.now();
  Set<DateTime> selectedDates = {};

  List<String> amenities = [
    "Wifi",
    "TV",
    "Washing machine",
    "pool",
    "Free parking on premises",
    "Kitchen",
    "Waterfront",
    "+   Add other things",
  ];
  List<String> selectedAmenities = [];
  String propertyType = '';

  @override
  void initState() {
    super.initState();
    // Fetch property details when screen loads
    context.read<PropertiesCubit>().getProperty(widget.propertyId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Listen for property data and populate fields
    final property = context.watch<PropertiesCubit>().state.property;
    if (property != PropertyModel.non) {
      _populateFields(property);
    }
  }

  void _populateFields(PropertyModel property) {
    if (mounted) {
      setState(() {
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
        
        // Handle existing images
        _imagePaths.clear();
        if (property.medias.isNotEmpty) {
          _imagePaths.addAll(property.medias);
        }
        
        // Handle existing contract and license
        if (property.ownershipContract.isNotEmpty) {
          _contractPath = property.ownershipContract.first;
        }
        if (property.facilityLicense.isNotEmpty) {
          _licensePath = property.facilityLicense.first;
        }
        
        // Handle available dates
        selectedDates.clear();
        for (var dateStr in property.availableDates) {
          try {
            DateTime? date;
            if (dateStr.contains('T')) {
              // Handle ISO format dates
              date = DateTime.parse(dateStr);
            } else {
              // Handle YYYY-MM-DD format
              final parts = dateStr.split('-');
              if (parts.length == 3) {
                date = DateTime(
                  int.parse(parts[0]), // year
                  int.parse(parts[1]), // month
                  int.parse(parts[2]), // day
                );
              }
            }
            if (date != null) {
              selectedDates.add(date);
            }
          } catch (e) {
            debugPrint('Error parsing date: $dateStr - $e');
            // Skip invalid dates
            continue;
          }
        }
      });
    }
  }

  bool _validateForm() {
    if (addressController.text.isEmpty ||
        detailsController.text.isEmpty ||
        priceController.text.isEmpty ||
        selectedDates.isEmpty ||
        _contractPath == null ||
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
      if (!imagePath.startsWith('http')) { // Only check new uploaded files
        String extension = path.extension(imagePath).toLowerCase().replaceAll('.', '');
        if (!_supportedImageTypes.contains(extension)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please use only jpg, jpeg, or png files for images'))
          );
          return false;
        }
      }
    }

    return true;
  }

  void _submitForm() async {
    if (_validateForm()) {
      try {
        final formattedDates = selectedDates.map((date) => 
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
        ).toList();

        final List<String> mediaFiles = [];
        for (String imagePath in _imagePaths) {
          if (imagePath.startsWith('http')) {
            // Keep existing remote URLs as is
            mediaFiles.add(imagePath);
          } else {
            // For new files, verify they exist
            final file = File(imagePath);
            if (await file.exists()) {
              mediaFiles.add(imagePath);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('One or more image files are missing'))
              );
              return;
            }
          }
        }

        if (_contractPath == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a contract file'))
          );
          return;
        }

        List<String> contractFiles = [];
        if (_contractPath!.startsWith('http')) {
          // Keep existing remote URL
          contractFiles.add(_contractPath!);
        } else {
          // For new file, verify it exists
          final contractFile = File(_contractPath!);
          if (await contractFile.exists()) {
            contractFiles.add(_contractPath!);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contract file is missing'))
            );
            return;
          }
        }

        List<String> licenseFiles = [];
        if (_licensePath != null) {
          if (_licensePath!.startsWith('http')) {
            licenseFiles.add(_licensePath!);
          } else {
            final licenseFile = File(_licensePath!);
            if (await licenseFile.exists()) {
              licenseFiles.add(_licensePath!);
            }
          }
        }

        context.read<PropertiesCubit>().updateProperty(
          PropertyModel(
            id: widget.propertyId,
            facilityLicense: licenseFiles,
            type: propertyType,
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
          
            ownershipContract: contractFiles,
            medias: mediaFiles,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error preparing files: $e')));
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final file = await FilePickerWidget.pickImage(context);
      if (file != null) {
        setState(() => _imagePaths.add(file.path));
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في اختيار الصورة')),
        );
      }
    }
  }

  Future<void> _pickPdfFile(String type) async {
    try {
      final file = await FilePickerWidget.pickPdfFile(context);
      if (file != null) {
        if (type == 'contract') {
          setState(() => _contractPath = file.path);
        } else if (type == 'license') {
          setState(() => _licensePath = file.path);
        }
      }
    } catch (e) {
      debugPrint('Error picking PDF file: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في اختيار الملف')),
        );
      }
    }
  }

  void _previousMonth() => setState(() => currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1));

  void _nextMonth() => setState(() => currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1));

  @override
  Widget build(BuildContext context) => BlocListener<PropertiesCubit, PropertiesState>(
    listener: (context, state) {
      if (state.updateStatus == Status.success) {
        Navigator.pop(context); // Return to previous screen after successful update
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تحديث العقار بنجاح'))
        );
      } else if (state.updateStatus == Status.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
      }
    },
    child: Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                if (context.watch<PropertiesCubit>().state.getPropertyStatus == Status.loading)
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withAlpha(125),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'برجاء الانتظار...',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            'جاري تحميل البيانات',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  HeaderImageSection(
                    imagePath: switch(propertyType.toLowerCase()) {
                      'house' => AssetsData.house,
                      'apartment' => AssetsData.house,
                      'cabin' => AssetsData.house,
                      'guest_house' => AssetsData.house,
                      'studio' => AssetsData.studio,
                      'yacht' => AssetsData.yacht,
                      'cruise' => AssetsData.cruise,
                      _ => AssetsData.house
                    },
                    type: propertyType,
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
                            onToggleAvailable: () => setState(() => isSelected = false),
                            onToggleNotAvailable: () => setState(() => isSelected = true),
                          ),
                        PropertyBasicsSection(
                          guests: guests,
                          bedrooms: bedrooms,
                          beds: beds,
                          bathrooms: bathrooms,
                          onGuestsIncrement: () => setState(() => guests++),
                          onGuestsDecrement: () => setState(() => guests = guests > 1 ? guests - 1 : 1),
                          onBedroomsIncrement: () => setState(() => bedrooms++),
                          onBedroomsDecrement: () => setState(() => bedrooms = bedrooms > 1 ? bedrooms - 1 : 1),
                          onBedsIncrement: () => setState(() => beds++),
                          onBedsDecrement: () => setState(() => beds = beds > 1 ? beds - 1 : 1),
                          onBathroomsIncrement: () => setState(() => bathrooms++),
                          onBathroomsDecrement: () => setState(() => bathrooms = bathrooms > 1 ? bathrooms - 1 : 1),
                        ),
                        AddressSectionHeader(showEditIcon: showAvailabilitySection),
                        const SizedBox(height: 10),
                        AddressTextField(controller: addressController),
                        const SizedBox(height: 20),
                        DetailsSectionHeader(showEditIcon: showAvailabilitySection),
                        const SizedBox(height: 15),
                        DetailsTextField(controller: detailsController),
                        const SizedBox(height: 20),
                        const AmenitiesSectionHeader(),
                        const SizedBox(height: 8),
                        AmenityChips(
                          amenities: amenities,
                          selectedAmenities: selectedAmenities,
                          onAmenitySelected: (amenity) {
                            if (selectedAmenities.contains(amenity)) {
                              selectedAmenities.remove(amenity);
                            } else {
                              selectedAmenities.add(amenity);
                            }
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 16),
                        PhotosSectionHeader(
                          showAvailabilitySection: showAvailabilitySection,
                          showEditIcon: showAvailabilitySection,
                        ),
                        const SizedBox(height: 10),
                        PropertyImageUpload(
                          imagePaths: _imagePaths,
                          onPickImage: _pickImage,
                          onRemoveImage: (imagePath) {
                            setState(() {
                              _imagePaths.remove(imagePath);
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        ContractSectionHeader(
                          showAvailabilitySection: showAvailabilitySection,
                          showEditIcon: showAvailabilitySection,
                        ),
                        const SizedBox(height: 10),
                        DocumentUploader(
                          label: "Upload Lease or ownership contract",
                          imagePaths: _contractPath != null ? [_contractPath!] : [],
                          onPickDocument: () => _pickPdfFile('contract'),
                          onRemoveDocument: (path) => setState(() => _contractPath = null),
                          isPdf: true,
                        ),
                        const SizedBox(height: 10),
                        LicenseSectionHeader(
                          showAvailabilitySection: showAvailabilitySection,
                          showEditIcon: showAvailabilitySection,
                        ),
                        const SizedBox(height: 10),
                        DocumentUploader(
                          label: "Upload Tourist hospitality facility license",
                          imagePaths: _licensePath != null ? [_licensePath!] : [],
                          onPickDocument: () => _pickPdfFile('license'),
                          onRemoveDocument: (path) => setState(() => _licensePath = null),
                          isPdf: true,
                        ),
                        const SizedBox(height: 16),
                        AvailableDatesSectionHeader(showEditIcon: showAvailabilitySection),
                        const SizedBox(height: 10),
                        CalendarWidget(
                          currentMonth: currentMonth,
                          selectedDates: selectedDates,
                          onPreviousMonth: _previousMonth,
                          onNextMonth: _nextMonth,
                          onSelectDate: (date) {
                            selectedDates.contains(date) ? selectedDates.remove(date) : selectedDates.add(date);
                            setState(() {});
                          },
                        ),
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
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'برجاء الانتظار...',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      'جاري تحديث البيانات',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

class ImageThumbnail extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRemove;

  const ImageThumbnail({super.key, required this.imagePath, required this.onRemove});

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
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading image: $error');
                      return Container(
                        width: 80,
                        height: 71,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
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
                        child: const Icon(Icons.error),
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
                  child: imagePath.startsWith('http')
                      ? Image.network(
                          imagePath,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('Error loading document: $error');
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            );
                          },
                        )
                      : Image.file(
                          File(imagePath),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('Error loading local document: $error');
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
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
