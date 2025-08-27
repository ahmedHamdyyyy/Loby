// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../config/images/image_assets.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleSearchBar extends StatelessWidget {
  final Function(String)? onSearch;
  final TextEditingController? controller;

  const SimpleSearchBar({
    super.key,
    this.onSearch,
    this.controller,
    //this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Standard height for search bar
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          // White input field with search icon
          Expanded(
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  children: [
                    const SizedBox(width: 10),

                    // Expanded area (acts as placeholder for text field)
                    Expanded(
                      child: Container(
                        height: 40,
                        child: TextField(
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          controller: controller,
                          //onTap: onSearch,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            hintText: '',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            prefixIcon: Container(
                              margin: EdgeInsets.only(
                                  top: 10.8, bottom: 10.8, left: 8),
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                ImageAssets.search,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Search button
          Container(
            height: 40,
            width: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF252525),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child:  Center(
              child: Text(
                'Search',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
