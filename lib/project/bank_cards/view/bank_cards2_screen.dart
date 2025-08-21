import 'package:flutter/material.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/common_styles.dart';
import '../../../../../config/widget/widgets.dart';
import 'all_wideget_bank_card.dart';

class SavedCardsScreenVendor extends StatefulWidget {
  const SavedCardsScreenVendor({super.key});

  @override
  State<SavedCardsScreenVendor> createState() => _SavedCardsScreenVendorState();
}

class _SavedCardsScreenVendorState extends State<SavedCardsScreenVendor> {
  // bool _isFirstCardSelected = true;
  // bool _isSecondCardSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: appBarPop(context, "Bank Cards", AppColors.primaryTextColor),
      body: const Padding(
        padding: Paddings.standard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(title: "Save Cards"),
            SizedBox(height: 20),
            /*  SavedCardItem(
              isSelected: _isFirstCardSelected,
              onSelectionChanged: (value) => setState(() => _isFirstCardSelected = value),
              cardName: "Card Name",
              cardLastDigits: "5678",
              onEdit: () => _navigateToEditCard(),
              onDelete: () => _showDeleteDialog(context),
            ), */
            /*    SavedCardItem(
              isSelected: _isSecondCardSelected,
              onSelectionChanged: (value) => setState(() => _isSecondCardSelected = value),
              cardName: "Card Name",
              cardLastDigits: "5678",
              onEdit: () => _navigateToEditCard(),
              onDelete: () => _showDeleteDialog(context),
            ), */
            SizedBox(height: 20),
            // AddNewCardButton(onPressed: _navigateToAddCard),
          ],
        ),
      ),
    );
  }

  /*  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const DeleteCardDialog(),
    );
  } */

  // void _navigateToEditCard() {
  //   Navigator.push(context, MaterialPageRoute(builder: (_) => const EditCardScreenVendor()));
  // }

  /*   void _navigateToAddCard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AddCardScreen()),
    );
  } */
}
