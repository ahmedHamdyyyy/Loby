import 'package:flutter/material.dart';

import 'all_properts_widget.dart';

class LocationConfirmationScreen extends StatelessWidget {
  const LocationConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(children: [MapBackground(), LocationSearchBar(), MapMarker(), LocationConfirmationPanel()]),
    );
  }
}
