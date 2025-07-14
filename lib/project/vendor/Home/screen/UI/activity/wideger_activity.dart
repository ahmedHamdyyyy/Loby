import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/images/image_assets.dart';
import '../../widget/pick_image_widget.dart';
import '../Properties/location_screens.dart';
import 'usage_agreement.dart';

class AgreementTitle extends StatelessWidget {
  const AgreementTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Loby Platform Usage Agreement',
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
    );
  }
}

class AgreementCheckbox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onToggle;

  const AgreementCheckbox({super.key, required this.isChecked, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: SvgPicture.asset(isChecked ? ImageAssets.cracalWhite : ImageAssets.cracalBlack),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'I agree to all the terms and conditions',
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.secondGrayTextColor),
          ),
        ),
      ],
    );
  }
}

class AgreementContent extends StatelessWidget {
  const AgreementContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AgreementParagraph(
          'With God\'s help and success, an agreement was reached on (Sunday) and the date (11/08/2024) between',
        ),
        SizedBox(height: 10),
        AgreementParagraph(
          'Loby and the host name ( company name ) Registry No. 1437/27/11 , address, phone number , email address',
        ),
        SizedBox(height: 10),
        AgreementParagraph('Hereinafter referred to as (First Party, Jathran or Platform) '),
        SizedBox(height: 16),
        AgreementParagraph(
          'Mr. Y Saudi nationality. Address: Saudi Arabia al-Kharj-Baraka neighborhood, phone number.(546325010), ID number (1104642127)and e-mail address,E-mail,(badrlafi@hotmail.com)")',
        ),
        SizedBox(height: 10),
        AgreementParagraph('Hereinafter referred to as (Second Party or Host)'),
        SizedBox(height: 16),
        AgreementParagraph(
          'Whereas the first party has an online platform (Loby) through which it provides Property rentals and sale services for properties through various applications and agreements, and whereas the first party wishes to enable the Second Party to own or rent a property intended for rental accommodation purposes and the following:',
        ),
        SizedBox(height: 16),
        AgreementParagraph('Hereinafter referred to as (Second Party or Host)'),
        SizedBox(height: 16),
        AgreementParagraph(
          'Whereas the first party has an online platform (Loby) through which it provides property marketing services pursuant to agreements and precise offer, and whereas the second party wishes to use the service of the Platform to market a property intended for rental accommodation purposes with their full capacity, and henceforth by utilizing this service, the User declares that they are in compliance with the following:',
        ),
        SizedBox(height: 8),
        SizedBox(height: 8),
        AgreementParagraph(
          'Mr. Y Saudi nationality. Address: Saudi Arabia, Al-Kharj, Al-Baraka neighborhood, phone number (546325010), ID number (1104642127) and e-mail address E-mail (badrlafi@hotmail.com)',
        ),
      ],
    );
  }
}

class AgreementParagraph extends StatelessWidget {
  final String text;

  const AgreementParagraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: AppColors.secondGrayTextColor,
        fontWeight: FontWeight.w400,
        wordSpacing: 0.5,
        height: 1.5,
      ),
      textAlign: TextAlign.justify,
    );
  }
}

class ActivityRegistrationHeader extends StatelessWidget {
  const ActivityRegistrationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}

class ActivityNameField extends StatelessWidget {
  final TextEditingController controller;

  const ActivityNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name of activity',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.grayTextColor, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        CustomTextField(controller: controller, hintText: 'Enter your activity name'),
      ],
    );
  }
}

class AddressField extends StatelessWidget {
  final TextEditingController controller;

  const AddressField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.grayTextColor, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            border: buildOutlineBorder(),
            focusedBorder: buildOutlineBorder(AppColors.grayTextColor),
            enabledBorder: buildOutlineBorder(),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 5),
              child: SvgPicture.asset(ImageAssets.locationIcon, width: 24, height: 24),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            suffixIcon: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationConfirmationScreen()));
              },
              icon: const Icon(Icons.add, color: AppColors.grayColorIcon),
            ),
            hintText: 'Enter your address',
            hintStyle: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          controller: controller,
        ),
      ],
    );
  }
}

class DetailsField extends StatelessWidget {
  final TextEditingController controller;

  const DetailsField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Some details',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.grayTextColor, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            border: buildOutlineBorder(),
            focusedBorder: buildOutlineBorder(AppColors.grayTextColor),
            enabledBorder: buildOutlineBorder(),
            hintText: 'Add Details',
            hintStyle: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          controller: controller,
        ),
      ],
    );
  }
}

class AmenitiesSection extends StatelessWidget {
  const AmenitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell guests what your place has to offer',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
        ),
        // const TagSelectorWidget(),
      ],
    );
  }
}

class PhotoUploadSection extends StatelessWidget {
  const PhotoUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload studio photos or video',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryTextColor, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const ImagePickerWidget(),
      ],
    );
  }
}

class DateField extends StatelessWidget {
  final TextEditingController controller;

  const DateField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryTextColor, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        CustomTextField(controller: controller, hintText: 'dd/mm/yyyy'),
      ],
    );
  }
}

class TimeField extends StatelessWidget {
  final TextEditingController controller;

  const TimeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryTextColor, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        CustomTextField(controller: controller, hintText: '2:00am'),
      ],
    );
  }
}

class ActivityDurationField extends StatelessWidget {
  final TextEditingController controller;

  const ActivityDurationField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activity time',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryTextColor, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        CustomTextField(controller: controller, hintText: '2 hours'),
      ],
    );
  }
}

class PriceField extends StatelessWidget {
  final TextEditingController controller;

  const PriceField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price',
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryTextColor, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        CustomTextField(controller: controller, hintText: 'Enter price per person'),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: buildOutlineBorder(),
        focusedBorder: buildOutlineBorder(AppColors.grayTextColor),
        enabledBorder: buildOutlineBorder(),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
      ),
      controller: controller,
    );
  }
}

OutlineInputBorder buildOutlineBorder([Color? color]) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: color ?? AppColors.lightGray),
  );
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const UsageAgreement()));
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
    );
  }
}
