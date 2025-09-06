// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';
import '../../../../../config/widget/widgets.dart';
import '../../../locator.dart';
import '../../../models/activity.dart';
import '../../../models/chat.dart';
import '../../../models/property.dart';
import '../../../models/reservation.dart';
import '../../Conversations/chat_screen.dart';
import '../../profile/logic/cubit.dart';

class ReservationDetailsScreen extends StatefulWidget {
  const ReservationDetailsScreen(this.reservation, {super.key});
  final ReservationModel reservation;
  @override
  State<ReservationDetailsScreen> createState() => _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  bool isRefused = false;
  int nights(String checkIn, String checkOut) {
    final checkInDate = DateTime.parse(checkIn);
    final checkOutDate = DateTime.parse(checkOut);
    final difference = checkOutDate.difference(checkInDate).inDays;
    return difference;
  }

  final vendor = getIt<ProfileCubit>().state.user;

  @override
  Widget build(BuildContext context) {
    final price =
        widget.reservation.type == ReservationType.property
            ? (widget.reservation.item as PropertyModel).pricePerNight
            : (widget.reservation.item as ActivityModel).price;
    final nightsNumber =
        widget.reservation.type == ReservationType.property
            ? nights(widget.reservation.checkInDate, widget.reservation.checkOutDate)
            : 1;

    return Scaffold(
      appBar: appBarPop(context, isRefused ? 'Last Reservation' : 'Current Reservations', AppColors.primaryColor),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              isRefused
                  ? 'Reservation Number ${widget.reservation.registrationNumber}'
                  : 'Last Number ${widget.reservation.registrationNumber}',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/saudian_man.png',
                      image: widget.reservation.userImageUrl,
                      imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/images/saudian_man.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Client Name',
                      style: GoogleFonts.poppins(
                        color: AppColors.secondTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.reservation.userName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: AppColors.grayTextColor, fontSize: 14),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChatScreen(
                            chat: ChatModel(
                              id: widget.reservation.id,
                              vendorId: vendor.id,
                              userId: widget.reservation.userId,
                              vendorName: '${vendor.firstName} ${vendor.lastName}',
                              vendorImageUrl: vendor.profilePicture,
                              userName: widget.reservation.userName,
                              userImageUrl: widget.reservation.userImageUrl,
                              lastMessage: '',
                              lastTimestamp: DateTime.now(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: SvgPicture.asset(ImageAssets.messages2),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // buildItemCard(
            //   imagePath: 'assets/images/image6.png',
            //   title: "Studio - 5 Night",
            //   location: "Riyadh - District Name",
            //   price: "4000 SAR",
            // ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(10)),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/image6.png',
                          image:
                              widget.reservation.type == ReservationType.property
                                  ? (widget.reservation.item as PropertyModel).medias.first
                                  : (widget.reservation.item as ActivityModel).medias.first,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.reservation.type == ReservationType.property
                                    ? (widget.reservation.item as PropertyModel).type.name
                                    : (widget.reservation.item as ActivityModel).name,
                                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.secondTextColor),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Text(
                              price.toString(),
                              style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.reservation.type == ReservationType.property
                              ? (widget.reservation.item as PropertyModel).address.formattedAddress
                              : (widget.reservation.item as ActivityModel).address.formattedAddress,
                          style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
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
                    "Free cancellation before ${widget.reservation.checkInDate.substring(0, 10)} October",
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
                buildOrderDetailText(
                  '${widget.reservation.type == ReservationType.property ? (widget.reservation.item as PropertyModel).type.name : (widget.reservation.item as ActivityModel).name} - $nightsNumber Night',
                ),
                const SizedBox(height: 8),
                buildOrderDetailText(
                  widget.reservation.type == ReservationType.property
                      ? (widget.reservation.item as PropertyModel).address.formattedAddress
                      : (widget.reservation.item as ActivityModel).address.formattedAddress,
                ),
                const SizedBox(height: 8),
                buildOrderDetailText('Check in - ${widget.reservation.checkInDate.substring(0, 10)}'),
                if (widget.reservation.type == ReservationType.property) ...[
                  const SizedBox(height: 8),
                  buildOrderDetailText('Check out - ${widget.reservation.checkOutDate.substring(0, 10)}'),
                ],
                const SizedBox(height: 8),
                buildOrderDetailText('Price : ${widget.reservation.totalPrice} SAR'),
              ],
            ),
            const Divider(height: 32, thickness: 1, color: AppColors.editIconColor),
            Text(
              'Summary',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryTextColor),
            ),
            const SizedBox(height: 8),
            SummaryRow(title: '$nightsNumber Night × $price', price: '${nightsNumber * price} SAR'),
            SummaryRow(
              title: '${widget.reservation.guestNumber} Person × $price',
              price: '${widget.reservation.guestNumber * price} SAR',
            ),
            SummaryRow(title: 'Vat', price: '0 SAR'),
            SummaryRow(title: 'Discount', price: '-200 SAR'),
            SummaryRow(title: 'Discount', price: '-1000 SAR'),
            if (!isRefused) buildNoteSection(),
            if (!isRefused) const SizedBox(height: 16),
            if (!isRefused) buildActionButtons(),
            const Divider(height: 32, thickness: 1, color: AppColors.editIconColor),
            const ViewReservationSummary(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildNoteSection() {
    return Column(
      children: [
        const Divider(height: 32, thickness: 1, color: AppColors.editIconColor),
        Row(
          children: [
            SvgPicture.asset(ImageAssets.noteIcon),
            const SizedBox(width: 10),
            Text(
              'Note : The client has paid the fues',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondGrayTextColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                isRefused = !isRefused;
              });
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(5)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Accept',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        if (!isRefused)
          Expanded(
            child: GestureDetector(
              onTap: () {
                // showRefuseDialoge(context);
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.editIconColor),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Refuse',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
          ),
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
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const LastReservationDetailsScreenvendor()));
          },
          child: const Icon(Icons.arrow_forward_ios, color: AppColors.grayColorIcon),
        ),
      ],
    );
  }
}

Widget buildOrderDetailText(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(color: AppColors.secondGrayTextColor, fontSize: 14, fontWeight: FontWeight.w400),
  );
}

class SummaryRow extends StatelessWidget {
  final String title;
  final String price;

  const SummaryRow({super.key, required this.title, required this.price});

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
