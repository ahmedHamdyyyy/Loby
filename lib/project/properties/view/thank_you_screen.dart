import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home/view/main_vandor_home.dart';

class ThankYouScreenRental extends StatelessWidget {
  const ThankYouScreenRental({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text('Thank you', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
            const SizedBox(height: 15),
            const Divider(color: Colors.black, height: 2, thickness: 2, indent: 90, endIndent: 90),
            const SizedBox(height: 20),
            Text(
              'The application will be reviewed within 48 hours.',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainVendorHome()));
                },
                child: Text('Done', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
