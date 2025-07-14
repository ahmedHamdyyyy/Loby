import 'package:flutter/material.dart';

import 'wideger_activity.dart';

class ActivityRegistrationScreen extends StatefulWidget {
  const ActivityRegistrationScreen({super.key});

  @override
  State<ActivityRegistrationScreen> createState() => _ActivityRegistrationScreenState();
}

class _ActivityRegistrationScreenState extends State<ActivityRegistrationScreen> {
  final List<String> selectedAmenities = ['Photography', 'pool', 'Transfer', 'Waterfront'];
  final activityNameController = TextEditingController();
  final addressController = TextEditingController();
  final detailsController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ActivityRegistrationHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActivityNameField(controller: activityNameController),
                  const SizedBox(height: 20),
                  AddressField(controller: addressController),
                  const SizedBox(height: 20),
                  DetailsField(controller: detailsController),
                  const SizedBox(height: 20),
                  const AmenitiesSection(),
                  const SizedBox(height: 20),
                  const PhotoUploadSection(),
                  const SizedBox(height: 20),
                  DateField(controller: dateController),
                  const SizedBox(height: 20),
                  TimeField(controller: timeController),
                  const SizedBox(height: 20),
                  ActivityDurationField(controller: durationController),
                  const SizedBox(height: 20),
                  PriceField(controller: priceController),
                  const SizedBox(height: 20),
                  const SaveButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
