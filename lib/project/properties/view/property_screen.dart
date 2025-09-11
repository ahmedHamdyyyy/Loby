// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:Luby/config/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;

import '../../../../config/colors/colors.dart';
import '../../../../config/constants/constance.dart';
import '../../../../config/images/assets.dart';
import '../../../../config/images/image_assets.dart';
import '../../../core/utils/utile.dart';
import '../../../models/address.dart';
import '../../../models/property.dart';
import '../../activities/view/widgets/wideger_activity.dart';
import '../logic/cubit.dart';
import 'all_properts_widget.dart';
import 'basics_section.dart';
import 'document_section.dart';
import 'images_section.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key, this.propertyId = '', required this.type});
  final String propertyId;
  final PropertyType type;
  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isStudioAvailable = false, showAvailabilitySection = false, isSelected = true;
  List<String> _imagePaths = [], _contractPaths = [], _licensePaths = [];
  int guests = 1, bedrooms = 1, beds = 1, bathrooms = 1;
  final detailsController = TextEditingController();
  final priceController = TextEditingController();
  PropertyType propertyType = PropertyType.house;
  List<String> tags = [];
  String startDate = '---- -- --', endDate = '---- -- --';
  Address address = Address.initial;

  @override
  void initState() {
    super.initState();
    _setProperty();
  }

  void _setProperty() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.propertyId.isEmpty) {
        context.read<PropertiesCubit>().setProperty(PropertyModel.initial);
        _setPropertyFields(PropertyModel.initial);
      } else {
        context.read<PropertiesCubit>().getProperty(widget.propertyId);
      }
    });
  }

  void _setPropertyFields(PropertyModel property) {
    guests = property.guestNumber;
    bedrooms = property.bedrooms;
    beds = property.beds;
    bathrooms = property.bathrooms;
    address = property.address;
    detailsController.text = property.details;
    priceController.text = property.pricePerNight.toString();
    tags = [...property.tags];
    propertyType = property.type;
    isSelected = !property.available;
    _imagePaths = [...property.medias];
    _contractPaths = [...property.ownershipContract];
    _licensePaths = [...property.facilityLicense];
    startDate = property.startDate.isNotEmpty ? property.startDate : DateTime.now().toIso8601String();
    endDate =
        property.endDate.isNotEmpty ? property.endDate : DateTime.now().add(const Duration(days: 30)).toIso8601String();
    setState(() {});
  }

  bool _validateForm() {
    if (_contractPaths.isEmpty || _imagePaths.isEmpty || tags.isEmpty || !_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields')));
      return false;
    }
    if (address.latitude == 0 && address.longitude == 0) {
      showToast(text: 'Please Select the Address on The Map', stute: ToustStute.worning);
      return false;
    }

    for (String imagePath in _imagePaths) {
      if (!imagePath.startsWith('http')) {
        String extension = path.extension(imagePath).toLowerCase().replaceAll('.', '');
        final List<String> allowedImages = ['jpg', 'jpeg', 'png'];
        final List<String> allowedVideos = ['mp4'];
        if (!allowedImages.contains(extension) && !allowedVideos.contains(extension)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Please use only jpg, jpeg, png images or mp4 videos')));
          return false;
        }
      }
    }

    return true;
  }

  void _submitForm() async {
    if (!_validateForm()) return;
    final property = PropertyModel(
      id: widget.propertyId,
      startDate: startDate,
      endDate: endDate,
      facilityLicense: _licensePaths,
      type: widget.type,
      available: !isSelected,
      guestNumber: guests,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      beds: beds,
      address: address,
      details: detailsController.text,
      tags: tags,
      pricePerNight: int.parse(priceController.text),
      maxDays: 5,
      ownershipContract: _contractPaths,
      medias: _imagePaths,
    );
    if (widget.propertyId.isEmpty) {
      context.read<PropertiesCubit>().createProperty(property);
    } else {
      context.read<PropertiesCubit>().updateProperty(property);
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<PropertiesCubit, PropertiesState>(
    listener: (context, state) {
      switch (state.getPropertyStatus) {
        case Status.loading:
          Utils.loadingDialog(context);
          break;
        case Status.success:
          Navigator.pop(context);
          _setPropertyFields(state.property);
          break;
        case Status.error:
          Navigator.pop(context);
          _setPropertyFields(state.property);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
          break;
        default:
          break;
      }
      switch (state.createStatus) {
        case Status.loading:
          Utils.loadingDialog(context);
          break;
        case Status.success:
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تحديث العقار بنجاح')));
          break;
        case Status.error:
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
          break;
        default:
          break;
      }
      switch (state.updateStatus) {
        case Status.loading:
          Utils.loadingDialog(context);
          break;
        case Status.success:
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تحديث العقار بنجاح')));
          break;
        case Status.error:
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
          break;
        default:
          break;
      }
    },
    builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                      child: Image.asset(switch (propertyType) {
                        PropertyType.studio => AssetsData.studio,
                        PropertyType.yacht => AssetsData.yacht,
                        PropertyType.cruise => AssetsData.cruise,
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
                      'Please enter your ${propertyType.name} information',
                      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
              if (state.getPropertyStatus == Status.loading)
                const Padding(padding: EdgeInsets.all(20), child: Center(child: CircularProgressIndicator()))
              else
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        if (showAvailabilitySection)
                          AvailabilityToggleSection(
                            type: propertyType.name,
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Address",
                        //       style: GoogleFonts.poppins(
                        //         color: AppColors.primaryColor,
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 16,
                        //       ),
                        //     ),
                        //     if (showAvailabilitySection)
                        //       SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
                        //   ],
                        // ),
                        const SizedBox(height: 10),
                        AddressField(address, onAddressSelected: (address) => this.address = address),
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
                              SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Please enter your Details";
                            return null;
                          },
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
                        TagsSection(selectedTags: tags, onTagsSelected: (selected) => tags = selected),
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
                              SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
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
                              SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
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
                              "Available date range",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                                fontSize: 16,
                              ),
                            ),
                            if (showAvailabilitySection)
                              SvgPicture.asset(ImageAssets.editIcon, color: AppColors.editIconColor, width: 20, height: 20),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grayTextColor, width: 0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Start Date:   ${startDate.substring(0, 10)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              IconButton(
                                onPressed: () async {
                                  final newDate = await showDatePicker(
                                    context: context,
                                    initialDate: startDate.isNotEmpty ? DateTime.parse(startDate) : DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                  if (newDate != null) setState(() => startDate = newDate.toIso8601String());
                                },
                                icon: Icon(Icons.date_range),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grayTextColor, width: 0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'End Date:   ${endDate.substring(0, 10)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              IconButton(
                                onPressed: () async {
                                  final newDate = await showDatePicker(
                                    context: context,
                                    initialDate: endDate.isNotEmpty ? DateTime.parse(endDate) : DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                  if (newDate != null) setState(() => endDate = newDate.toIso8601String());
                                },
                                icon: Icon(Icons.date_range),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
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
                            child: Text(
                              widget.propertyId.isEmpty ? "Add" : "Update",
                              style: GoogleFonts.poppins(fontSize: 16, color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
