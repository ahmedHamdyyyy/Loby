import 'package:Luby/models/activity.dart';
import 'package:Luby/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../config/constants/constance.dart';
import '../../../core/localization/l10n_ext.dart';
import '../../../locator.dart';
import '../../../models/property.dart';
import '../logic/cubit.dart';
import 'reservation_details_screen.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});
  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  bool isCurrentReservations = true;
  @override
  Widget build(BuildContext context) {
    getIt<ReservationsCubit>().getReservations(isCurrentReservations);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 46),
            child: Text(
              context.l10n.reservationTitle,
              style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 0, right: 18, left: 18),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    text: context.l10n.currentReservations,
                    isSelected: isCurrentReservations,
                    onTap: () => setState(() => isCurrentReservations = true),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTabButton(
                    text: context.l10n.lastReservations,
                    isSelected: !isCurrentReservations,
                    onTap: () => setState(() => isCurrentReservations = false),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ReservationsCubit, ReservationsState>(
              builder: (context, state) {
                if (state.getStatus == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.getStatus == Status.error) {
                  return Center(child: Text(state.msg));
                } else if (state.reservations.isEmpty) {
                  return Center(
                    child: Text(
                      context.l10n.noReservationsFound,
                      style: GoogleFonts.poppins(fontSize: 16, color: AppColors.grayTextColor),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: state.reservations.length,
                  itemBuilder: (context, index) {
                    final reservation = state.reservations[index];
                    final isProperty = reservation.type == ReservationType.property;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, top: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 125,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/images/image7.png',
                                        image:
                                            isProperty
                                                ? (reservation.item as PropertyModel).medias.firstOrNull ?? ''
                                                : (reservation.item as ActivityModel).medias.firstOrNull ?? '',
                                        imageErrorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset('assets/images/image7.png', fit: BoxFit.cover),
                                        fit: BoxFit.cover,
                                        placeholderFit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isProperty
                                              ? (reservation.item as PropertyModel).type.name
                                              : (reservation.item as ActivityModel).name,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.secondTextColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          context.l10n.personCount(reservation.guestNumber),
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: AppColors.grayTextColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          isProperty
                                              ? (reservation.item as PropertyModel).address.formattedAddress
                                              : (reservation.item as ActivityModel).address.formattedAddress,
                                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600),
                                        ),
                                        const SizedBox(height: 4),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(fontSize: 14, color: AppColors.secondTextColor),
                                            children: [
                                              TextSpan(
                                                text: '${context.l10n.dateLabelInline} ',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: AppColors.secondTextColor,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    reservation.checkInDate.length >= 10
                                                        ? reservation.checkInDate.substring(0, 10)
                                                        : reservation.checkInDate,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: AppColors.grayTextColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (reservation.checkOutDate.isNotEmpty)
                                          RichText(
                                            text: TextSpan(
                                              style: const TextStyle(fontSize: 14, color: AppColors.secondTextColor),
                                              children: [
                                                TextSpan(
                                                  text: '${context.l10n.checkOutInline} ',
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: AppColors.secondTextColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: reservation.checkOutDate.substring(0, 10),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: AppColors.grayTextColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ElevatedButton(
                                  onPressed: () {
                                    getIt<ReservationsCubit>().setReservation(reservation);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ReservationDetailsScreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    minimumSize: Size(double.infinity, 48),
                                  ),
                                  child: Text(
                                    context.l10n.viewReservationDetails,
                                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({required String text, required bool isSelected, required VoidCallback onTap}) {
    return Container(
      width: 160,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.secondTextColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isSelected ? Colors.white : AppColors.secondTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
