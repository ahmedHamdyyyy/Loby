// Property basics section with counters
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';

class PropertyBasicsSection extends StatelessWidget {
  final int guests;
  final int bedrooms;
  final int beds;
  final int bathrooms;
  final void Function(int) onGuestsChanged;
  final void Function(int) onBedroomsChanged;
  final void Function(int) onBedsChanged;
  final void Function(int) onBathroomsChanged;

  const PropertyBasicsSection({
    super.key,
    required this.guests,
    required this.bedrooms,
    required this.beds,
    required this.bathrooms,
    required this.onGuestsChanged,
    required this.onBedroomsChanged,
    required this.onBedsChanged,
    required this.onBathroomsChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Share some basics about your place",
        style: GoogleFonts.poppins(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 16),
      ),
      const SizedBox(height: 15),
      CounterItem(label: "Guests number", value: guests, onChanged: onGuestsChanged),
      CounterItem(label: "Bedrooms", value: bedrooms, onChanged: onBedroomsChanged),
      CounterItem(label: "Bed", value: beds, onChanged: onBedsChanged),
      CounterItem(label: "Bathroom", value: bathrooms, onChanged: onBathroomsChanged),
    ],
  );
}

// Counter item for property basics
class CounterItem extends StatefulWidget {
  const CounterItem({super.key, required this.label, required this.value, required this.onChanged});
  final void Function(int) onChanged;
  final String label;
  final int value;
  @override
  State<CounterItem> createState() => _CounterItemState();
}

class _CounterItemState extends State<CounterItem> {
  int _value = 0;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: GoogleFonts.poppins(color: AppColors.secondTextColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (_value == 0) return;
                  setState(() => _value--);
                  debugPrint(_value.toString());
                  widget.onChanged(_value);
                },
                child: SvgPicture.asset(ImageAssets.removeIcon, width: 22, height: 22),
              ),
              const SizedBox(width: 10),
              Text(
                _value.toString(),
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.secondTextColor),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  if (_value > 999) return;
                  setState(() => _value++);
                  debugPrint(_value.toString());
                  widget.onChanged(_value);
                },
                child: SvgPicture.asset(ImageAssets.addIcon, width: 22, height: 22),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}
