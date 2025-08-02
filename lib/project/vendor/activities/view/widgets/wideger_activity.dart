import 'package:Luby/project/vendor/activities/view/widgets/tag_selector_widget.dart' show TagSelectorWidget;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';
import '../../../Home/screen/UI/Properties/location_screens.dart';

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
        const TagSelectorWidget(),
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
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (selectedDate != null) {
              // تنسيق التاريخ بصيغة yyyy-MM-dd
              controller.text = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
            }
          },
          decoration: InputDecoration(
            border: buildOutlineBorder(),
            focusedBorder: buildOutlineBorder(AppColors.grayTextColor),
            enabledBorder: buildOutlineBorder(),
            hintText: 'yyyy-MM-dd',
            hintStyle: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
        ),
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
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (selectedTime != null) {
              // تنسيق الوقت بصيغة HH:mm
              final hour = selectedTime.hour.toString().padLeft(2, '0');
              final minute = selectedTime.minute.toString().padLeft(2, '0');
              controller.text = "$hour:$minute";
            }
          },
          decoration: InputDecoration(
            border: buildOutlineBorder(),
            focusedBorder: buildOutlineBorder(AppColors.grayTextColor),
            enabledBorder: buildOutlineBorder(),
            hintText: 'HH:MM',
            hintStyle: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
            suffixIcon: const Icon(Icons.access_time),
          ),
        ),
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
  Widget build(BuildContext context) => TextFormField(
    decoration: InputDecoration(
      border: buildOutlineBorder(),
      focusedBorder: buildOutlineBorder(AppColors.grayTextColor),
      enabledBorder: buildOutlineBorder(),
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return 'Please enter $hintText';
      return null;
    },
    controller: controller,
  );
}

OutlineInputBorder buildOutlineBorder([Color? color]) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: color ?? AppColors.lightGray),
  );
}
