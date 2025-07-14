// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/images/image_assets.dart';
import '../../../../../../../config/widget/widgets.dart';

class LastReservationDetailsScreenvendor extends StatefulWidget {
  const LastReservationDetailsScreenvendor({super.key});

  @override
  State<LastReservationDetailsScreenvendor> createState() => _LastReservationDetailsScreenvendorState();
}

class _LastReservationDetailsScreenvendorState extends State<LastReservationDetailsScreenvendor> {
  bool isRefused = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPop(context, 'Last Reservation', AppColors.primaryColor),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildHeaderText(),
            const SizedBox(height: 22),
            const HostInfo(),
            const SizedBox(height: 16),
            _buildReservationItems(),
            _buildSummarySection(),
            const Divider(height: 32, thickness: 1, color: AppColors.editIconColor),
            const ViewReservationSummary(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      'Last Number 1234',
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
    );
  }

  Widget _buildReservationItems() {
    return Column(
      children: [
        buildItemCard(
          imagePath: 'assets/images/image6.png',
          title: "Studio - 5 Night",
          location: "Riyadh - District Name",
          price: "4000 SAR",
        ),
        const Divider(height: 30, thickness: 1, color: AppColors.editIconColor),
        buildItemCard(
          imagePath: 'assets/images/IMAG.png',
          title: "Studio - 5 Night",
          location: "Riyadh - District Name",
          price: "4000 SAR",
        ),
      ],
    );
  }

  Widget _buildSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 32, thickness: 1, color: AppColors.editIconColor),
        Text(
          'Summary',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryTextColor),
        ),
        const SizedBox(height: 8),
        const SumamaryRow(),
      ],
    );
  }
}

class ViewReservationSummary extends StatelessWidget {
  const ViewReservationSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(ImageAssets.pdfIcon, width: 30, height: 30),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            'View reservation summary',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LastReservationDetailsScreenvendor()));
          },
          child: const Icon(Icons.arrow_forward_ios, color: AppColors.grayColorIcon),
        ),
      ],
    );
  }
}

class SumamaryRow extends StatelessWidget {
  const SumamaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SummaryRow(title: '5 nights × 800', price: '4000 SAR'),
        SummaryRow(title: '2 Person × 800', price: '4000 SAR'),
        SummaryRow(title: 'Vat', price: '0 SAR'),
        SummaryRow(title: 'Discount', price: '-200 SAR'),
        SummaryRow(title: 'Discount', price: '-1000 SAR'),
      ],
    );
  }
}

Widget buildItemCard({required String imagePath, required String title, required String location, required String price}) {
  return Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3, // 🔴 نسبة عرض الصورة
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10)),
                    child: Image.asset(
                      imagePath,
                      height: 120, // 🔴 نفس طول محتوى الكارد
                      fit: BoxFit.cover, // 🔴 يحافظ على تناسب الصورة
                    ),
                  ),
                ],
              ),
            ),

            // ✅ المحتوى بجانب الصورة
            Expanded(
              flex: 5, // 🔴 نسبة عرض المحتوى
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔴 العنوان والسعر
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.secondTextColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Text(price, style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // 📍 الموقع
                    Text(location, style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 14)),

                    const SizedBox(height: 10),

                    // ✅ Free cancellation + أيقونات بدون تجاوز
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                "Free cancellation before 27 October",
                style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order details',
              style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            _buildOrderDetailText('Studio - 5 Night'),
            const SizedBox(height: 8),
            _buildOrderDetailText('Riyadh - District Name'),
            const SizedBox(height: 8),
            _buildOrderDetailText('Check in - 14 \\ 10\\ 2024'),
            const SizedBox(height: 8),
            _buildOrderDetailText('Check out - 19\\ 10\\ 2024'),
            const SizedBox(height: 8),
            _buildOrderDetailText('Price : 1230 SAR'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildOrderDetailText(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(color: AppColors.secondGrayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
  );
}

class HostInfo extends StatelessWidget {
  const HostInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset('assets/images/saudian_man.png', width: 64, height: 64, fit: BoxFit.cover),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Client Name',
              style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontWeight: FontWeight.w600, fontSize: 14),
            ),
            Text(
              'Mohamed Abdallah',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: AppColors.grayTextColor, fontSize: 14),
            ),
          ],
        ),
        const Spacer(),
        SvgPicture.asset(ImageAssets.messages2),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String title;
  final String price;

  const SummaryRow({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              height: 1.2,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondTextColor,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.poppins(
              height: 1.2,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
