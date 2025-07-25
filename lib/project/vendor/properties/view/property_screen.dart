// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path/path.dart' as path;

// import '../../../../../config/colors/colors.dart';
// import '../../../../../config/constants/constance.dart';
// import '../../../../config/images/assets.dart';
// import '../../Home/screen/UI/properties/all_properts_widget.dart';
// import '../../Home/screen/UI/properties/thank_you_screen.dart';
// import '../../Home/screen/widget/pick_image_widget.dart';
// import '../../models/property_model.dart';
// import '../cubit/cubit.dart';

// class PropertyScreen extends StatefulWidget {
//   const PropertyScreen({super.key, required this.type});
//   final String type;
//   @override
//   State<PropertyScreen> createState() => _PropertyScreenState();
// }

// class _PropertyScreenState extends State<PropertyScreen> {
//   int guests = 1, bedrooms = 1, beds = 1, bathrooms = 1;
//   final addressController = TextEditingController();
//   final detailsController = TextEditingController();
//   final priceController = TextEditingController();

//   bool isStudioAvailable = false, showAvailabilitySection = true, isSelected = true;

//   final List<String> _imagePaths = [];
//   String? _contractPath, _licensePath;
//   // final _picker = ImagePicker();

//   final List<String> _supportedImageTypes = ['jpg', 'jpeg', 'png'];

//   DateTime currentMonth = DateTime.now();
//   Set<DateTime> selectedDates = {};

//   List<String> amenities = [
//     "Wifi",
//     "TV",
//     "Washing machine",
//     "pool",
//     "Free parking on premises",
//     "Kitchen",
//     "Waterfront",
//     "+   Add other things",
//   ];
//   List<String> selectedAmenities = [];

//   bool _validateForm() {
//     if (addressController.text.isEmpty ||
//         detailsController.text.isEmpty ||
//         priceController.text.isEmpty ||
//         selectedDates.isEmpty ||
//         _contractPath == null ||
//         _imagePaths.isEmpty ||
//         selectedAmenities.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields')));
//       return false;
//     }

//     try {
//       final price = int.parse(priceController.text);
//       if (price <= 0) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Price must be greater than 0')));
//         return false;
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid price')));
//       return false;
//     }

//     for (String imagePath in _imagePaths) {
//       String extension = path.extension(imagePath).toLowerCase().replaceAll('.', '');
//       if (!_supportedImageTypes.contains(extension)) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Please use only jpg, jpeg, or png files for images')));
//         return false;
//       }
//     }

//     return true;
//   }

//   void _submitForm() async {
//     if (_validateForm()) {
//       try {
//         final formattedDates =
//             selectedDates
//                 .map(
//                   (date) => '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
//                 )
//                 .toList();
//         final List<File> mediaFiles = [];
//         for (String imagePath in _imagePaths) {
//           final file = File(imagePath);
//           if (await file.exists()) {
//             mediaFiles.add(file);
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('One or more image files are missing')));
//             return;
//           }
//         }

//         if (_contractPath == null) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a contract file')));
//           return;
//         }

//         final contractFile = File(_contractPath!);
//         if (!await contractFile.exists()) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contract file is missing')));
//           return;
//         }
//         context.read<PropertiesCubit>().createProperty(
//           PropertyModel(
//             id: '',
//             facilityLicense: const [],
//             type: widget.type,
//             available: !isSelected,
//             guestNumber: guests,
//             bedrooms: bedrooms,
//             bathrooms: bathrooms,
//             beds: beds,
//             address: addressController.text,
//             details: detailsController.text,
//             tags: selectedAmenities,
//             pricePerNight: int.parse(priceController.text),
//             availableDates: formattedDates,
//             maxDays: 5,
//             ownershipContract: [contractFile.path],
//             medias: mediaFiles.map((file) => file.path).toList(),
//           ),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error preparing files: $e')));
//       }
//     }
//   }

//   Future<void> _pickImage() async {
//     try {
//       final file = await FilePickerWidget.pickImage(context);
//       if (file != null) {
//         setState(() => _imagePaths.add(file.path));
//       }
//     } catch (e) {
//       debugPrint('Error picking image: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('فشل في اختيار الصورة')));
//       }
//     }
//   }

//   Future<void> _pickPdfFile(String type) async {
//     try {
//       final file = await FilePickerWidget.pickPdfFile(context);
//       if (file != null) {
//         if (type == 'contract') {
//           setState(() => _contractPath = file.path);
//         } else if (type == 'license') {
//           setState(() => _licensePath = file.path);
//         }
//       }
//     } catch (e) {
//       debugPrint('Error picking PDF file: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('فشل في اختيار الملف')));
//       }
//     }
//   }

//   void _previousMonth() => setState(() => currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1));

//   void _nextMonth() => setState(() => currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1));

//   @override
//   Widget build(BuildContext context) => BlocListener<PropertiesCubit, PropertiesState>(
//     listener: (context, state) {
//       if (state.createStatus == Status.success) {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const ThankYouScreenRental()));
//         setState(() => showAvailabilitySection = true);
//       } else if (state.createStatus == Status.error) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
//       }
//     },
//     child: Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 HeaderImageSection(
//                   imagePath: switch (widget.type) {
//                     'house' => AssetsData.house,
//                     'yacht' => AssetsData.yacht,
//                     'cruise' => AssetsData.cruise,
//                     'studio' => AssetsData.studio,
//                     _ => AssetsData.house,
//                   },
//                   type: widget.type,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 12),
//                       if (showAvailabilitySection)
//                         AvailabilityToggleSection(
//                           type: widget.type,
//                           isSelected: isSelected,
//                           onToggleAvailable: () => setState(() => isSelected = false),
//                           onToggleNotAvailable: () => setState(() => isSelected = true),
//                         ),
//                       PropertyBasicsSection(
//                         guests: guests,
//                         bedrooms: bedrooms,
//                         beds: beds,
//                         bathrooms: bathrooms,
//                         onGuestsIncrement: () => setState(() => guests++),
//                         onGuestsDecrement: () => setState(() => guests = guests > 1 ? guests - 1 : 1),
//                         onBedroomsIncrement: () => setState(() => bedrooms++),
//                         onBedroomsDecrement: () => setState(() => bedrooms = bedrooms > 1 ? bedrooms - 1 : 1),
//                         onBedsIncrement: () => setState(() => beds++),
//                         onBedsDecrement: () => setState(() => beds = beds > 1 ? beds - 1 : 1),
//                         onBathroomsIncrement: () => setState(() => bathrooms++),
//                         onBathroomsDecrement: () => setState(() => bathrooms = bathrooms > 1 ? bathrooms - 1 : 1),
//                       ),
//                       AddressSectionHeader(showEditIcon: showAvailabilitySection),
//                       const SizedBox(height: 10),
//                       AddressTextField(controller: addressController),
//                       const SizedBox(height: 20),
//                       DetailsSectionHeader(showEditIcon: showAvailabilitySection),
//                       const SizedBox(height: 15),
//                       DetailsTextField(controller: detailsController),
//                       const SizedBox(height: 20),
//                       const AmenitiesSectionHeader(),
//                       const SizedBox(height: 8),
//                       AmenityChips(
//                         amenities: amenities,
//                         selectedAmenities: selectedAmenities,
//                         onAmenitiesChanged: (amenity) {
//                           if (selectedAmenities.contains(amenity)) {
//                             selectedAmenities.remove(amenity);
//                           } else {
//                             selectedAmenities.add(amenity);
//                           }
//                           setState(() {});
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       PhotosSectionHeader(
//                         showAvailabilitySection: showAvailabilitySection,
//                         showEditIcon: showAvailabilitySection,
//                       ),
//                       const SizedBox(height: 10),
//                       PropertyImageUpload(
//                         imagePaths: _imagePaths,
//                         onPickImage: _pickImage,
//                         onRemoveImage: (imagePath) {
//                           setState(() {
//                             _imagePaths.remove(imagePath);
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 10),
//                       ContractSectionHeader(
//                         showAvailabilitySection: showAvailabilitySection,
//                         showEditIcon: showAvailabilitySection,
//                       ),
//                       const SizedBox(height: 10),
//                       DocumentUploader(
//                         label: "Upload Lease or ownership contract",
//                         paths: _contractPath != null ? [_contractPath!] : [],
//                         onPickDocument: () => _pickPdfFile('contract'),
//                         onRemoveDocument: (path) => setState(() => _contractPath = null),
//                         isPdf: true,
//                       ),
//                       const SizedBox(height: 10),
//                       LicenseSectionHeader(
//                         showAvailabilitySection: showAvailabilitySection,
//                         showEditIcon: showAvailabilitySection,
//                       ),
//                       const SizedBox(height: 10),
//                       DocumentUploader(
//                         label: "Upload Tourist hospitality facility license",
//                         paths: _licensePath != null ? [_licensePath!] : [],
//                         onPickDocument: () => _pickPdfFile('license'),
//                         onRemoveDocument: (path) => setState(() => _licensePath = null),
//                         isPdf: true,
//                       ),
//                       const SizedBox(height: 16),
//                       AvailableDatesSectionHeader(showEditIcon: showAvailabilitySection),
//                       const SizedBox(height: 10),
//                       CalendarWidget(
//                         currentMonth: currentMonth,
//                         selectedDates: selectedDates,
//                         onPreviousMonth: _previousMonth,
//                         onNextMonth: _nextMonth,
//                         onSelectDate: (date) {
//                           selectedDates.contains(date) ? selectedDates.remove(date) : selectedDates.add(date);
//                           setState(() {});
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       PriceSectionHeader(showEditIcon: showAvailabilitySection),
//                       const SizedBox(height: 8),
//                       PriceTextField(controller: priceController),
//                       const SizedBox(height: 24),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _submitForm,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryColor,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                           ),
//                           child: Text("حفظ", style: GoogleFonts.poppins(fontSize: 16, color: AppColors.whiteColor)),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (context.watch<PropertiesCubit>().state.createStatus == Status.loading)
//             Container(
//               color: Colors.black.withAlpha(125),
//               child: Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
//                     const SizedBox(height: 20),
//                     Text(
//                       'برجاء الانتظار...',
//                       style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
//                     ),
//                     Text(
//                       'جاري حفظ البيانات',
//                       style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w400),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     ),
//   );
// }
