// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';
import '../../../../../config/widget/common_styles.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184,
      margin: Paddings.horizontal,
      decoration: ContainerStyles.card(color: AppColors.primaryColor, radius: 12),
      child: const Padding(
        padding: Paddings.standard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [BalanceLabel(), SizedBox(height: 16), BalanceAmount(amount: '15,000', currency: 'SAR')],
        ),
      ),
    );
  }
}

class BalanceLabel extends StatelessWidget {
  const BalanceLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Available balance', style: TextStyles.body(color: AppColors.whiteColor, size: 16));
  }
}

class BalanceAmount extends StatelessWidget {
  final String amount;
  final String currency;

  const BalanceAmount({super.key, required this.amount, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(amount, style: TextStyles.title(color: AppColors.whiteColor, size: 32, weight: FontWeight.w400)),
        const SizedBox(width: 4),
        Text(currency, style: TextStyles.body(color: AppColors.whiteColor, size: 16)),
      ],
    );
  }
}

class BillItem extends StatelessWidget {
  final String billCode;
  final String totalPrice;
  final String serviceName;
  final VoidCallback onTap;

  const BillItem({
    super.key,
    required this.billCode,
    required this.totalPrice,
    required this.serviceName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bill code : $billCode',
                  style: TextStyles.body(color: AppColors.secondTextColor, size: 14, weight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle download action
                  },
                  child: SvgPicture.asset(ImageAssets.downloadIcon, height: 24, width: 24, color: AppColors.secondTextColor),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('Total Price : ', style: TextStyles.body(color: AppColors.secondTextColor, size: 14)),
                Text(
                  totalPrice,
                  style: TextStyles.body(color: AppColors.secondTextColor, size: 14, weight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(serviceName, style: TextStyles.body(color: AppColors.secondTextColor, size: 14)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whiteColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: Text(
                  'Bill Details',
                  style: TextStyles.body(color: AppColors.whiteColor, size: 14, weight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BillDetailsHeader extends StatelessWidget {
  const BillDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text('Bill Details', style: TextStyles.body(color: AppColors.primaryColor, size: 16, weight: FontWeight.w400)),
    );
  }
}

class BillDetailsCard extends StatelessWidget {
  const BillDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillCodeHeader(),
          BillDivider(),
          BillInfoItem(text: 'Studio - 5 Night'),
          SizedBox(height: 8),
          BillInfoItem(text: 'Riyadh - District Name'),
          SizedBox(height: 8),
          BillInfoItem(text: 'Check in - 14\\10\\2024'),
          SizedBox(height: 8),
          BillInfoItem(text: 'Check out - 19\\10\\2024'),
          SizedBox(height: 8),
          BillInfoItem(text: 'Price : 1230 SAR'),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class BillCodeHeader extends StatelessWidget {
  const BillCodeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Bill code : #122345',
          style: TextStyle(color: AppColors.secondGrayTextColor, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(ImageAssets.downloadIcon, height: 24, width: 24, color: AppColors.secondTextColor),
        ),
      ],
    );
  }
}

class BillDivider extends StatelessWidget {
  const BillDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 24, indent: 0, endIndent: 220, color: AppColors.primaryColor);
  }
}

class BillInfoItem extends StatelessWidget {
  final String text;

  const BillInfoItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(color: AppColors.secondGrayTextColor, fontSize: 16, fontWeight: FontWeight.w400),
    );
  }
}
