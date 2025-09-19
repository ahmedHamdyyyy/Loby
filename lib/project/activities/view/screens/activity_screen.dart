// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;

import '../../../../config/colors/colors.dart';
import '../../../../config/constants/constance.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../config/widget/widget.dart';
import '../../../../core/utils/utile.dart';
import '../../../../models/activity.dart';
import '../../../../models/address.dart';
import '../../../profile/logic/cubit.dart';
import '../../../properties/view/images_section.dart';
import '../../logic/cubit.dart';
import '../widgets/usage_agreement.dart';
import '../widgets/wideger_activity.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key, this.activityId = ''});
  final String activityId;
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final activityNameController = TextEditingController();
  final detailsController = TextEditingController(), priceController = TextEditingController();
  final dateController = TextEditingController(), timeController = TextEditingController();
  final activityTimeController = TextEditingController(), maximumGuestNumberController = TextEditingController();
  List<String> _tags = [], _medias = [];
  bool _isAgreed = false;

  Address _address = Address.initial;

  @override
  void initState() {
    super.initState();
    _setActivity();
    context.read<ActivitiesCubit>().initStatus();
  }

  void _setActivity() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.activityId.isEmpty) {
        context.read<ActivitiesCubit>().setActivity(ActivityModel.non);
        _setActivityFields(ActivityModel.non);
      } else {
        context.read<ActivitiesCubit>().getActivity(widget.activityId);
      }
    });
  }

  void _setActivityFields(ActivityModel activity) {
    activityNameController.text = activity.name;
    _address = activity.address;
    detailsController.text = activity.details;
    priceController.text = activity.price > 0 ? activity.price.toString() : '';
    dateController.text = activity.date;
    timeController.text = activity.time;
    activityTimeController.text = activity.activityTime.toString();
    maximumGuestNumberController.text = activity.maximumGuestNumber.toString();
    _tags = [...activity.tags];
    _medias = [...activity.medias];
    setState(() {});
  }

  void setAgreement(bool isAgreed) => _isAgreed = isAgreed;

  Future<bool> _validateForm() async {
    if (!_isAgreed) {
      await Navigator.push(context, MaterialPageRoute(builder: (context) => UsageAgreement(setAgreement: setAgreement)));
    }
    if (!_isAgreed) {
      showToast(text: 'Please agree to the terms and conditions', stute: ToustStute.worning);
      return false;
    }

    if (_address.latitude == 0 || _address.longitude == 0) {
      showToast(text: 'Please select a valid address from the Map', stute: ToustStute.worning);
      return false;
    }

    if (_medias.isEmpty || _tags.isEmpty || !_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields')));
      return false;
    }

    for (String imagePath in _medias) {
      if (!imagePath.startsWith('http')) {
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
    if (!await _validateForm()) return;
    final activity = ActivityModel(
      id: widget.activityId,
      date: dateController.text,
      time: timeController.text,
      activityTime: activityTimeController.text,
      name: activityNameController.text,
      address: _address,
      details: detailsController.text,
      tags: _tags,
      price: double.parse(priceController.text),
      maximumGuestNumber: int.parse(maximumGuestNumberController.text),
      medias: _medias,
      verified: false,
    );
    final vendorId = context.read<ProfileCubit>().state.user.id;
    if (widget.activityId.isEmpty) {
      context.read<ActivitiesCubit>().createActivity(activity, vendorId);
    } else {
      context.read<ActivitiesCubit>().updateActivity(activity, vendorId);
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<ActivitiesCubit, ActivitiesState>(
    listener: (context, state) {
      switch (state.getActivityStatus) {
        case Status.loading:
          Utils.loadingDialog(context);
          break;
        case Status.success:
          Navigator.pop(context);
          _setActivityFields(state.activity);
          break;
        case Status.error:
          Navigator.pop(context);
          _setActivityFields(state.activity);
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تحديث النشاط بنجاح')));
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تحديث النشاط بنجاح')));
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Material(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      height: 171,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/shutterstock.jpg'), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(ImageAssets.backIcon, width: 24, height: 24),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Please enter your activity information',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (state.getActivityStatus == Status.loading)
                const Padding(padding: EdgeInsets.all(20), child: Center(child: CircularProgressIndicator()))
              else
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name of activity',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.grayTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(controller: activityNameController, hintText: 'Enter your activity name'),
                        const SizedBox(height: 20),
                        AddressField(_address, onAddressSelected: (address) => _address = address),

                        // if (addressController.text.isNotEmpty) ...[
                        //   const SizedBox(height: 16),
                        //   Container(
                        //     padding: const EdgeInsets.all(16),
                        //     decoration: BoxDecoration(
                        //       color: Colors.green.withAlpha(25),
                        //       borderRadius: BorderRadius.circular(8),
                        //       border: Border.all(color: Colors.green.withAlpha(75)),
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             Icon(Icons.location_on, color: Colors.green, size: 20),
                        //             const SizedBox(width: 8),
                        //             Text(
                        //               'Selected Location',
                        //               style: GoogleFonts.poppins(
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Colors.green,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        // const SizedBox(height: 8),
                        // Text(
                        //   addressController.text,
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 14,
                        //     color: AppColors.primaryTextColor,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // if (_selectedLatitude != null && _selectedLongitude != null) ...[
                        //   const SizedBox(height: 4),
                        //   Text(
                        //     'Coordinates: ${_selectedLatitude!.toStringAsFixed(6)}, ${_selectedLongitude!.toStringAsFixed(6)}',
                        //     style: GoogleFonts.poppins(
                        //       fontSize: 12,
                        //       color: AppColors.grayTextColor,
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //   ),
                        // ],
                        //       ],
                        //     ),
                        //   ),
                        // ],
                        const SizedBox(height: 20),
                        DetailsField(controller: detailsController),
                        const SizedBox(height: 20),
                        TagsSection(selectedTags: _tags, onTagsSelected: (tags) => _tags = tags),
                        const SizedBox(height: 20),
                        Text(
                          'Upload studio photos or video',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        PropertyImagesSection(imagePaths: _medias, onImagesChanged: (imagesPaths) => _medias = imagesPaths),
                        const SizedBox(height: 20),
                        DateField(controller: dateController),
                        const SizedBox(height: 20),
                        TimeField(controller: timeController),
                        const SizedBox(height: 20),
                        Text(
                          'Activity time',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: activityTimeController,
                          decoration: InputDecoration(
                            hintText: "2 hours",
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Please enter the Activity time";
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Maximum Guests',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: maximumGuestNumberController,
                          decoration: InputDecoration(
                            hintText: "Enter Max Guests",
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Please enter the maximum guest number";
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Price',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: priceController,
                          decoration: InputDecoration(
                            hintText: "Enter Price",
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Please enter the Price";
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              backgroundColor: const Color(0xFF262626),
                            ),
                            child:
                                state.createStatus == Status.loading || state.updateStatus == Status.loading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                      widget.activityId.isEmpty ? 'Save' : 'Update',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
