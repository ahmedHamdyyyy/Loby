// ignore_for_file: use_key_in_widget_constructors

import 'package:Luby/config/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/images/image_assets.dart';
import '../../../../../config/widget/widgets.dart';
import '../../../config/constants/constance.dart';
import '../../../core/localization/l10n_ext.dart';
import '../../../core/utils/utile.dart';
import '../../../locator.dart';
import '../../../models/activity.dart';
import '../../../models/chat.dart';
import '../../../models/property.dart';
import '../../../models/reservation.dart';
import '../../Conversations/chat_screen.dart';
import '../../profile/logic/cubit.dart';
import '../logic/cubit.dart';

class ReservationDetailsScreen extends StatefulWidget {
  const ReservationDetailsScreen({super.key});
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
    return BlocConsumer<ReservationsCubit, ReservationsState>(
      listener: (context, state) {
        if (state.updateStatus == Status.loading) {
          Utils.loadingDialog(context);
        } else if (state.updateStatus == Status.error) {
          Navigator.pop(context);
          Utils.errorDialog(context, state.msg);
        } else if (state.updateStatus == Status.success) {
          Navigator.pop(context);
          showToast(text: 'Updated Successfully', stute: ToustStute.success);
        }
      },
      builder: (context, state) {
        final reservation = state.reservation;
        final price =
            reservation.type == ReservationType.property
                ? (reservation.item as PropertyModel).pricePerNight
                : (reservation.item as ActivityModel).price;
        final nightsNumber =
            reservation.type == ReservationType.property ? nights(reservation.checkInDate, reservation.checkOutDate) : 1;
        isRefused = reservation.status == ReservationStatus.refunded;
        return Scaffold(
          appBar: appBarPop(
            context,
            isRefused ? context.l10n.lastReservations : context.l10n.currentReservations,
            AppColors.primaryColor,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  isRefused
                      ? context.l10n.reservationNumberLabel(reservation.registrationNumber.toString())
                      : context.l10n.lastNumberLabel(reservation.registrationNumber.toString()),
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
                          image: reservation.userImageUrl,
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
                          context.l10n.clientName,
                          style: GoogleFonts.poppins(
                            color: AppColors.secondTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          reservation.userName,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: AppColors.grayTextColor,
                            fontSize: 14,
                          ),
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
                                  id: reservation.id,
                                  vendorId: vendor.id,
                                  userId: reservation.userId,
                                  vendorName: '${vendor.firstName} ${vendor.lastName}',
                                  vendorImageUrl: vendor.profilePicture,
                                  userName: reservation.userName,
                                  userImageUrl: reservation.userImageUrl,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.assetNetwork(
                        width: 125,
                        height: 125,
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/image6.png',
                        image:
                            reservation.type == ReservationType.property
                                ? (reservation.item as PropertyModel).medias.first
                                : (reservation.item as ActivityModel).medias.first,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reservation.type == ReservationType.property
                                  ? (reservation.item as PropertyModel).type.name
                                  : (reservation.item as ActivityModel).name,
                              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.secondTextColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              reservation.type == ReservationType.property
                                  ? (reservation.item as PropertyModel).address.formattedAddress
                                  : (reservation.item as ActivityModel).address.formattedAddress,
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
                        context.l10n.freeCancellationBefore(reservation.checkInDate.substring(0, 10)),
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
                      context.l10n.orderDetails,
                      style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    buildOrderDetailText(
                      '${reservation.type == ReservationType.property ? (reservation.item as PropertyModel).type.name : (reservation.item as ActivityModel).name} - $nightsNumber Night',
                    ),
                    const SizedBox(height: 8),
                    buildOrderDetailText(
                      reservation.type == ReservationType.property
                          ? (reservation.item as PropertyModel).address.formattedAddress
                          : (reservation.item as ActivityModel).address.formattedAddress,
                    ),
                    const SizedBox(height: 8),
                    buildOrderDetailText(context.l10n.checkInLabel(reservation.checkInDate.substring(0, 10))),
                    if (reservation.type == ReservationType.property) ...[
                      const SizedBox(height: 8),
                      buildOrderDetailText(context.l10n.checkOutLabel(reservation.checkOutDate.substring(0, 10))),
                    ],
                    const SizedBox(height: 8),
                    buildOrderDetailText(context.l10n.priceWithCurrency(reservation.totalPrice, context.l10n.currencySar)),
                  ],
                ),
                const Divider(height: 32, thickness: 1, color: AppColors.editIconColor),
                Text(
                  context.l10n.summary,
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryTextColor),
                ),
                const SizedBox(height: 8),
                SummaryRow(
                  title:
                      '$nightsNumber Night${nightsNumber > 1 ? 's' : ''} × ${reservation.guestNumber} Person${reservation.guestNumber > 1 ? 's' : ''} × $price Per Night',
                  price: '${nightsNumber * reservation.guestNumber * price} SAR',
                ),
                // SummaryRow(title: '$price', price: '${reservation.guestNumber * price} SAR'),
                // SummaryRow(title: 'Vat', price: '0 SAR'),
                // SummaryRow(title: 'Discount', price: '-200 SAR'),
                // if (!isRefused) buildNoteSection(),
                if (!isRefused) const SizedBox(height: 54),
                if (!isRefused) buildActionButtons(context),
                const Divider(height: 32, thickness: 1, color: AppColors.editIconColor),
                const ViewReservationSummary(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildNoteSection(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 32, thickness: 1, color: AppColors.editIconColor),
        Row(
          children: [
            SvgPicture.asset(ImageAssets.noteIcon),
            const SizedBox(width: 10),
            Text(
              context.l10n.noteClientPaidFees,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondGrayTextColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: getIt<ReservationsCubit>().acceptReservation,
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(5)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  context.l10n.commonAccept,
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
              onTap: getIt<ReservationsCubit>().refundReservation,
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
                    context.l10n.commonRefuse,
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
            context.l10n.viewReservationSummary,
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
