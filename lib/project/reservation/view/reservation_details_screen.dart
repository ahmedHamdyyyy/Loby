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
  const ReservationDetailsScreen({super.key, this.reservationId = ''});
  final String reservationId;
  @override
  State<ReservationDetailsScreen> createState() => _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  // bool isRefused = false;
  int nights(String checkIn, String checkOut) {
    final checkInDate = DateTime.parse(checkIn);
    final checkOutDate = DateTime.parse(checkOut);
    final difference = checkOutDate.difference(checkInDate).inDays;
    return difference;
  }

  final vendor = getIt<ProfileCubit>().state.user;

  @override
  void initState() {
    super.initState();
    if (widget.reservationId.isNotEmpty) {
      // Load reservation details by id
      getIt<ReservationsCubit>().getReservationById(widget.reservationId);
    }
  }

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
          showToast(text: context.l10n.updatedSuccessfully, stute: ToustStute.success);
        }
      },
      builder: (context, state) {
        if (widget.reservationId.isNotEmpty && state.reservation.id.isEmpty) {
          // Waiting for fetch
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final reservation = state.reservation;
        final price =
            reservation.type == ReservationType.property
                ? (reservation.item as PropertyModel).pricePerNight
                : (reservation.item as ActivityModel).price;
        final nightsNumber =
            reservation.type == ReservationType.property ? nights(reservation.checkInDate, reservation.checkOutDate) : 1;
        // isRefused = reservation.status == ReservationStatus.refund;
        return Scaffold(
          appBar: appBarPop(context, context.l10n.reservationTitle, AppColors.primaryColor),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  context.l10n.reservationNumberLabel(reservation.registrationNumber.toString()),
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 22),

                // buildItemCard(
                //   imagePath: 'assets/images/image6.png',
                //   title: "Studio - 5 Night",
                //   location: "Riyadh - District Name",
                //   price: "4000 SAR",
                // ),
                Row(
                  children: [
                    SizedBox(
                      width: 125,
                      height: 125,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/image7.png',
                          image:
                              reservation.type == ReservationType.property
                                  ? (reservation.item as PropertyModel).medias.firstOrNull ?? ''
                                  : (reservation.item as ActivityModel).medias.firstOrNull ?? '',
                          imageErrorBuilder:
                              (context, error, stackTrace) => Image.asset('assets/images/image7.png', fit: BoxFit.cover),
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.cover,
                        ),
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
                              (reservation.type == ReservationType.property
                                      ? (reservation.item as PropertyModel).type.name
                                      : (reservation.item as ActivityModel).name)
                                  .toUpperCase(),
                              style: GoogleFonts.poppins(fontSize: 16, color: AppColors.secondTextColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 8),
                            if (reservation.type == ReservationType.property) ...[
                              Text(
                                (reservation.item as PropertyModel).address.formattedAddress,
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                            ],
                            buildOrderDetailText(context.l10n.nightCount(nightsNumber)),
                            const SizedBox(height: 4),
                            buildOrderDetailText(
                              reservation.type == ReservationType.property
                                  ? (reservation.item as PropertyModel).address.formattedAddress
                                  : (reservation.item as ActivityModel).address.formattedAddress,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
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
                Text(
                  context.l10n.orderDetails,
                  style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                buildOrderDetailText(context.l10n.checkInLabel(reservation.checkInDate.substring(0, 10))),
                if (reservation.type == ReservationType.property) ...[
                  const SizedBox(height: 8),
                  buildOrderDetailText(context.l10n.checkOutLabel(reservation.checkOutDate.substring(0, 10))),
                ],
                const SizedBox(height: 8),
                buildOrderDetailText(
                  context.l10n.priceWithCurrency(reservation.totalPriceAfterFees, context.l10n.currencySar),
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
                const Divider(height: 32, thickness: 1, color: AppColors.editIconColor),
                Text(
                  context.l10n.summary,
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryTextColor),
                ),
                const SizedBox(height: 8),
                SummaryRow(
                  title:
                      '${context.l10n.nightCount(nightsNumber)} × ${context.l10n.personCount(reservation.guestNumber)} × $price ${context.l10n.perNight}',
                  price: '${reservation.totalPrice} ${context.l10n.currencySar}',
                ),
                SummaryRow(
                  title: context.l10n.fees,
                  price: '${(reservation.totalPriceAfterFees - reservation.totalPrice).abs()} ${context.l10n.currencySar}',
                ),
                SummaryRow(
                  title: context.l10n.totalPrice,
                  price: '${reservation.totalPriceAfterFees} ${context.l10n.currencySar}',
                ),
                // SummaryRow(title: 'Vat', price: '0 SAR'),
                // if (!isRefused) buildNoteSection(),
                if (reservation.status == ReservationStatus.completed) ...[
                  const SizedBox(height: 32),
                  buildActionButtons(context),
                ] else ...[
                  const SizedBox(height: 24),
                  Text(
                    context.l10n.reservationStatusMessage(_localizedStatus(context, reservation.status)),
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.secondTextColor),
                  ),
                ],
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
        // if (!isRefused)
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

String _localizedStatus(BuildContext context, ReservationStatus status) {
  switch (status) {
    case ReservationStatus.completed:
      return context.l10n.statusCompleted;
    case ReservationStatus.confirmed:
      return context.l10n.statusConfirmed;
    case ReservationStatus.refund:
      return context.l10n.statusRefund;
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
