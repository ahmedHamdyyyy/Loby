// ignore_for_file: creation_with_non_type
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../../config/colors/colors.dart';
// import '../../../../../config/images/image_assets.dart';
// import '../../../../../config/widget/common_styles.dart';
// import 'add_card_screen.dart';

// class DialogTitle extends StatelessWidget {
//   final String text;

//   const DialogTitle({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(text, style: TextStyles.title(color: AppColors.primaryColor, size: 16, weight: FontWeight.w500)),
//     );
//   }
// }

// class DialogContent extends StatelessWidget {
//   final String text;

//   const DialogContent({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Text(text, textAlign: TextAlign.center, style: TextStyles.body(color: AppColors.primaryTextColor, size: 16));
//   }
// }

// class ConfirmButton extends StatelessWidget {
//   final VoidCallback onPressed;

//   const ConfirmButton({super.key, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ButtonStyles.primary(
//         backgroundColor: AppColors.primaryColor,
//       ).copyWith(minimumSize: WidgetStateProperty.all(const Size(100, 40))),
//       child: Text("Yes", style: TextStyles.button(size: 16)),
//     );
//   }
// }

// class CancelButton extends StatelessWidget {
//   final VoidCallback onPressed;

//   const CancelButton({super.key, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: onPressed,
//       style: OutlinedButton.styleFrom(
//         minimumSize: const Size(100, 40),
//         side: const BorderSide(color: AppColors.primaryTextColor),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//       child: Text("Cancel", style: TextStyles.body(color: AppColors.primaryTextColor, size: 16)),
//     );
//   }
// }

// class ScreenTitle extends StatelessWidget {
//   final String title;

//   const ScreenTitle({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(title, style: TextStyles.title(color: AppColors.primaryTextColor));
//   }
// }

// class SavedCardItem extends StatelessWidget {
//   final bool isSelected;
//   final Function(bool) onSelectionChanged;
//   final String cardName;
//   final String cardLastDigits;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;

//   const SavedCardItem({
//     super.key,
//     required this.isSelected,
//     required this.onSelectionChanged,
//     required this.cardName,
//     required this.cardLastDigits,
//     required this.onEdit,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CardActions(isSelected: isSelected, onSelectionChanged: onSelectionChanged, onEdit: onEdit, onDelete: onDelete),
//           const CardDivider(),
//           CardDetails(cardName: cardName, cardLastDigits: cardLastDigits),
//         ],
//       ),
//     );
//   }
// }

// class CardActions extends StatelessWidget {
//   final bool isSelected;
//   final Function(bool) onSelectionChanged;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;

//   const CardActions({
//     super.key,
//     required this.isSelected,
//     required this.onSelectionChanged,
//     required this.onEdit,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SelectionToggle(isSelected: isSelected, onToggle: () => onSelectionChanged(!isSelected)),
//         const SizedBox(width: 8),
//         const Expanded(
//           child: Text(
//             "Use this card to pay",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: AppColors.primaryTextColor,
//               fontFamily: 'Poppins',
//             ),
//           ),
//         ),
//         ActionIcon(icon: ImageAssets.editIcon, onTap: onEdit),
//         const SizedBox(width: 8),
//         ActionIcon(icon: ImageAssets.deleteIcon, onTap: onDelete),
//       ],
//     );
//   }
// }

// class SelectionToggle extends StatelessWidget {
//   final bool isSelected;
//   final VoidCallback onToggle;

//   const SelectionToggle({super.key, required this.isSelected, required this.onToggle});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onToggle,
//       child:
//           isSelected
//               ? SvgPicture.asset(ImageAssets.cracalWhite, height: 20, width: 20)
//               : SvgPicture.asset(ImageAssets.cracalBlack, height: 20, width: 20),
//     );
//   }
// }

// class ActionIcon extends StatelessWidget {
//   final String icon;
//   final VoidCallback onTap;

//   const ActionIcon({super.key, required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(onTap: onTap, child: SvgPicture.asset(icon, height: 25, width: 25));
//   }
// }

// class CardDivider extends StatelessWidget {
//   const CardDivider({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
//       child: Container(height: 1, width: 50, color: AppColors.primaryTextColor),
//     );
//   }
// }

// class CardDetails extends StatelessWidget {
//   final String cardName;
//   final String cardLastDigits;

//   const CardDetails({super.key, required this.cardName, required this.cardLastDigits});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 10),
//         Text(cardName, style: TextStyles.body(color: AppColors.primaryTextColor, size: 16)),
//         Text("Card number ending with $cardLastDigits", style: TextStyles.body(color: AppColors.primaryTextColor, size: 16)),
//       ],
//     );
//   }
// }

// class AddNewCardButton extends StatelessWidget {
//   final VoidCallback onPressed;

//   const AddNewCardButton({super.key, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         style: ButtonStyles.primary(backgroundColor: AppColors.primaryTextColor),
//         onPressed: onPressed,
//         child: Text("Add New Card", style: TextStyles.button()),
//       ),
//     );
//   }
// }

// class CardFormHeader extends StatelessWidget {
//   const CardFormHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Text("Card details", style: TextStyles.title(color: AppColors.primaryColor));
//   }
// }

// class CardNumberField extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(String) onChanged;

//   const CardNumberField({super.key, required this.controller, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return FormField(
//       label: "Card Number",
//       controller: controller,
//       hint: "0000 0000 0000 0000",
//       keyboardType: TextInputType.number,
//       onChanged: onChanged,
//       formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16)],
//     );
//   }
// }

// class CardholderNameField extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(String) onChanged;

//   const CardholderNameField({super.key, required this.controller, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     return FormField(
//       label: "Card Name",
//       controller: controller,
//       hint: "Cardholder Name",
//       keyboardType: TextInputType.text,
//       onChanged: onChanged,
//     );
//   }
// }

// class CardExpiryAndCvv extends StatelessWidget {
//   final TextEditingController expirationController;
//   final TextEditingController cvvController;
//   final Function(String) onExpirationChanged;
//   final Function(String) onCvvChanged;

//   const CardExpiryAndCvv({
//     super.key,
//     required this.expirationController,
//     required this.cvvController,
//     required this.onExpirationChanged,
//     required this.onCvvChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: FormField(
//             label: "Expiration Date",
//             controller: expirationController,
//             hint: "MM/YY",
//             keyboardType: TextInputType.number,
//             onChanged: onExpirationChanged,
//             formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: FormField(
//             label: "CVV",
//             controller: cvvController,
//             hint: "***",
//             keyboardType: TextInputType.number,
//             onChanged: onCvvChanged,
//             obscureText: true,
//             formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SaveDataOption extends StatelessWidget {
//   final bool isSaveEnabled;
//   final VoidCallback onToggle;

//   const SaveDataOption({super.key, required this.isSaveEnabled, required this.onToggle});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         InkWell(
//           onTap: onToggle,
//           child: isSaveEnabled ? SvgPicture.asset(ImageAssets.cracalBlack) : SvgPicture.asset(ImageAssets.cracalWhite),
//         ),
//         const SizedBox(width: 8),
//         Text("Save data when paying later", style: TextStyles.body(color: AppColors.secondTextColor, size: 14)),
//       ],
//     );
//   }
// }

// class AddCardButton extends StatelessWidget {
//   final bool isFormValid;
//   final VoidCallback onPressed;

//   const AddCardButton({super.key, required this.isFormValid, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 48,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isFormValid ? AppColors.primaryColor : AppColors.primaryColor.withAlpha(125),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//         onPressed: isFormValid ? onPressed : null,
//         child: Text("Add", style: TextStyles.button(size: 18)),
//       ),
//     );
//   }
// }

// class FormField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final String hint;
//   final TextInputType keyboardType;
//   final Function(String)? onChanged;
//   final bool obscureText;
//   final List<TextInputFormatter>? formatters;

//   const FormField({
//     super.key,
//     required this.label,
//     required this.controller,
//     required this.hint,
//     required this.keyboardType,
//     this.onChanged,
//     this.obscureText = false,
//     this.formatters,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyles.body(color: AppColors.secondTextColor, size: 16)),
//         const SizedBox(height: 5),
//         Container(
//           width: double.infinity,
//           height: 48,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//           child: TextField(
//             controller: controller,
//             keyboardType: keyboardType,
//             obscureText: obscureText,
//             style: TextStyles.body(color: AppColors.grayTextColor, size: 16),
//             inputFormatters: formatters,
//             onChanged: onChanged,
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: TextStyles.body(color: const Color(0xFFCBCBCB), size: 16),
//               filled: true,
//               fillColor: AppColors.whiteColor,
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BankCardsHeader extends StatelessWidget {
//   const BankCardsHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       "Bank Cards",
//       style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryTextColor, fontSize: 16, fontWeight: FontWeight.w600),
//     );
//   }
// }

// class EmptyCardsContent extends StatelessWidget {
//   const EmptyCardsContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 25),
//         Center(child: SvgPicture.asset(ImageAssets.card2, height: 150)),
//         const SizedBox(height: 20),
//         const EmptyCardMessage(),
//         const SizedBox(height: 30),
//         AddCardButton2(onPressed: () => _navigateToAddCard(context)),
//       ],
//     );
//   }

//   void _navigateToAddCard(BuildContext context) {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCardScreenVendor()));
//   }
// }

// class EmptyCardMessage extends StatelessWidget {
//   const EmptyCardMessage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       "You have not added any bank card yet",
//       style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryTextColor, fontSize: 16, fontWeight: FontWeight.w400),
//       textAlign: TextAlign.center,
//     );
//   }
// }

// class AddCardButton2 extends StatelessWidget {
//   final VoidCallback onPressed;

//   const AddCardButton2({super.key, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryColor,
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         minimumSize: const Size(double.infinity, 50),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//       onPressed: onPressed,
//       child: const Text(
//         "Add Card",
//         style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
//       ),
//     );
//   }
// }
