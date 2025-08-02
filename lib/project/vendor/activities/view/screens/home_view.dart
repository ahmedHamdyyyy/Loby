import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';
import '../../../../../config/widget/widget.dart';
import '../../../../../locator.dart';
import '../../../Home/screen/widget/pick_image_widget.dart';
import '../../../models/activity.dart';
import '../../../user/cubit/cubit.dart';
import '../../cubit/cubit.dart';
import '../widgets/usage_agreement.dart';
import '../widgets/wideger_activity.dart';

class ActivityRegistrationScreen extends StatefulWidget {
  const ActivityRegistrationScreen({super.key});

  @override
  State<ActivityRegistrationScreen> createState() => _ActivityRegistrationScreenState();
}

class _ActivityRegistrationScreenState extends State<ActivityRegistrationScreen> {
  final List<String> selectedAmenities = ['Photography', 'pool', 'Transfer', 'Waterfront'];
  List<String> medias = [];
  final activityNameController = TextEditingController();
  final addressController = TextEditingController();
  final detailsController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final durationController = TextEditingController();

  bool _isAgreed = false;

  void setAgreement(bool isAgreed) => _isAgreed = isAgreed;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
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
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name of activity',
                  style: GoogleFonts.poppins(fontSize: 16, color: AppColors.grayTextColor, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15),
                CustomTextField(controller: activityNameController, hintText: 'Enter your activity name'),
                const SizedBox(height: 20),
                AddressField(controller: addressController),
                const SizedBox(height: 20),
                DetailsField(controller: detailsController),
                const SizedBox(height: 20),
                const AmenitiesSection(),
                const SizedBox(height: 20),
                Text(
                  'Upload studio photos or video',
                  style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryTextColor, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                ImagePickerWidget(onImagesUploaded: (images) => medias = images),
                const SizedBox(height: 20),
                DateField(controller: dateController),
                const SizedBox(height: 20),
                TimeField(controller: timeController),
                const SizedBox(height: 20),
                ActivityDurationField(controller: durationController),
                const SizedBox(height: 20),
                PriceField(controller: priceController),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_isAgreed) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UsageAgreement(setAgreement: setAgreement)),
                        );
                      }
                      if (!_isAgreed) {
                        return showToast(text: 'Please agree to the terms and conditions', stute: ToustStute.worning);
                      }
                      // التحقق من صحة البيانات قبل الإرسال
                      if (activityNameController.text.isEmpty) {
                        return showToast(text: 'يرجى إدخال اسم النشاط', stute: ToustStute.worning);
                      }
                      
                      if (dateController.text.isEmpty || dateController.text.trim() == 'ا' || dateController.text.trim() == '') {
                        return showToast(text: 'يرجى اختيار تاريخ صحيح', stute: ToustStute.worning);
                      }
                      
                      if (timeController.text.isEmpty) {
                        return showToast(text: 'يرجى اختيار وقت صحيح', stute: ToustStute.worning);
                      }
                      
                      if (priceController.text.isEmpty || double.tryParse(priceController.text) == null) {
                        return showToast(text: 'يرجى إدخال سعر صحيح', stute: ToustStute.worning);
                      }
                      
                      getIt<ActivitiesCubit>().createActivity(
                        ActivityModel(
                          id: '', // إترك فارغ ليتم توليده تلقائياً من الخادم
                          vendorId: getIt<UserCubit>().state.user.id,
                          tags: selectedAmenities,
                          medias: medias,
                          verified: false, // سيتم تحويله في ActivityModel.create()
                          name: activityNameController.text,
                          address: addressController.text,
                          details: detailsController.text,
                          price: double.parse(priceController.text),
                          date: dateController.text,
                          time: timeController.text,
                          activityTime: durationController.text,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      backgroundColor: const Color(0xFF262626),
                    ),
                    child: Text(
                      'Save',
                      style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.w500),
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
  );
}
