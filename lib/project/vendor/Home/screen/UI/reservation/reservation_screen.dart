import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/colors/colors.dart';
import '../../../../../../../config/widget/widgets.dart';
import 'current_reservation_details.dart';
import 'last_reservation_details.dart';

class ReservationScreenvendor extends StatefulWidget {
  const ReservationScreenvendor({super.key});

  @override
  State<ReservationScreenvendor> createState() => _ReservationScreenvendorState();
}

class _ReservationScreenvendorState extends State<ReservationScreenvendor> {
  bool isCurrentReservations = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
       appBar: appBarPop(context, "Reservation", AppColors.grayTextColor),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildTabButtons(),
          _buildReservationList(),
        ],
      ),

  
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
      
        
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 16),
          child: Text(
            'Reservation',
            style: GoogleFonts.poppins(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildTabButtons() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
        top: 0,
        right: 18,
        left: 18,
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              text: 'Current Reservations',
              isSelected: isCurrentReservations,
              onTap: () {
                setState(() {
                  isCurrentReservations = true;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTabButton(
              text: 'Last Reservations',
              isSelected: !isCurrentReservations,
              onTap: () {
                setState(() {
                  isCurrentReservations = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationList() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: isCurrentReservations
            ? _buildCurrentReservations()
            : _buildLastReservations(),
      ),
    );
  }

  List<Widget> _buildCurrentReservations() {
    return [
      _buildCurrentReservationCard(),
      _buildCurrentReservationCard(),
    ];
  }

  Widget _buildCurrentReservationCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        children: [
          _buildHotelReservationCardCurrentReservation(
            imageUrl: 'assets/images/image6.png',
            title: 'Studio - 5 Night',
            location: 'Riyadh - District Name',
            checkInDate: '14/10/2024',
            checkOutDate: '19/10/2024',
          ),
          _buildActivityCardCurrentReservation(
            imageUrl: 'assets/images/image7.png',
            title: 'Activity Name',
            location: 'Riyadh - District Name',
            persons: 2,
            date: '14/10/2024',
            onViewDetails: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CurretReservationDetailsScreenvendor(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLastReservations() {
    return [
      Column(
        children: [
          _buildLastReservationHotelCard(),
          const SizedBox(height: 16),
          _buildLastReservationActivityCard(),
        ],
      ),
    ];
  }

  Widget _buildLastReservationHotelCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      child: _buildHotelReservationCardLastReservation(
        imageUrl: 'assets/images/image6.png',
        title: 'Studio - 5 Night',
        location: 'Riyadh - District Name',
        checkInDate: '14/10/2024',
        checkOutDate: '19/10/2024',
        onViewDetails: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LastReservationDetailsScreenvendor(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLastReservationActivityCard() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      child: _buildActivityCardLastReservation(
        imageUrl: 'assets/images/image7.png',
        title: 'Activity Name',
        location: 'Riyadh - District Name',
        persons: 2,
        date: '14/10/2024',
        onViewDetails: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LastReservationDetailsScreenvendor(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
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

  Widget _buildHotelReservationCardCurrentReservation({
    required String imageUrl,
    required String title,
    required String location,
    required String checkInDate,
    required String checkOutDate,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    imageUrl,
                    width: 101,
                    height: 101,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.grayTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildCheckInOutText('check in ', checkInDate),
                      const SizedBox(height: 2),
                      _buildCheckInOutText('check out ', checkOutDate),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckInOutText(String label, String date) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.secondTextColor,
        ),
        children: [
          TextSpan(
            text: label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.secondTextColor,
            ),
          ),
          TextSpan(
            text: date,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.grayTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelReservationCardLastReservation({
    required String imageUrl,
    required String title,
    required String location,
    required String checkInDate,
    required String checkOutDate,
    required VoidCallback onViewDetails,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    imageUrl,
                    width: 101,
                    height: 101,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.grayTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildCheckInOutText('check in ', checkInDate),
                      const SizedBox(height: 2),
                      _buildCheckInOutText('check out ', checkOutDate),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: _buildViewDetailsButton(onViewDetails),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCardCurrentReservation({
    required String imageUrl,
    required String title,
    required String location,
    required int persons,
    required String date,
    required VoidCallback onViewDetails,
  }) {
    return Card(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    width: 101,
                    height: 101,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$persons person',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.grayTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildDateText(date),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _buildViewDetailsButton(onViewDetails),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateText(String date) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.secondTextColor,
        ),
        children: [
          TextSpan(
            text: 'Date ',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.secondTextColor,
            ),
          ),
          TextSpan(
            text: date,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.grayTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCardLastReservation({
    required String imageUrl,
    required String title,
    required String location,
    required int persons,
    required String date,
    required VoidCallback onViewDetails,
  }) {
    return Card(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageUrl,
                    width: 101,
                    height: 101,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$persons person',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.grayTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildDateText(date),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _buildViewDetailsButton(onViewDetails),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewDetailsButton(VoidCallback onPress) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'View Reservations Details',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  // Bottom Navigation Bar
}
