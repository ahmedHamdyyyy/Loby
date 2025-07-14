// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/images/image_assets.dart';
import '../../../../../../../config/widget/common_styles.dart';
import 'bill_details.dart';
import 'widget_wellet.dart';

// import '../propreties/widgets/bottom_nav_bar_widget.dart';

class WalletScreenVendor extends StatelessWidget {
  const WalletScreenVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            CommonWidgets.headerWithBack(context: context, title: 'Wallet'),
            const SizedBox(height: 14),
            CommonWidgets.pageTitle(title: 'Wallet'),
            const WalletBalanceCard(),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SvgPicture.asset(ImageAssets.billIcon, height: 24, width: 24, color: AppColors.secondTextColor),
                  const SizedBox(width: 10),
                  Text(
                    'Bill Details',
                    style: TextStyles.body(color: AppColors.secondTextColor, size: 16, weight: FontWeight.w400),
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return BillItem(
                  billCode: '#122345',
                  totalPrice: '1230',
                  serviceName: 'Service Name',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BillDetails()));
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
