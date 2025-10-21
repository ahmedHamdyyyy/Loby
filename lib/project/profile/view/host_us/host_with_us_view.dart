import 'package:flutter/material.dart';

import '../../../../core/localization/l10n_ext.dart';
import 'widget_host_with.dart';

class HostWithUsViewVendor extends StatelessWidget {
  const HostWithUsViewVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const HostHeader(),
            const SizedBox(height: 14),
            const HostTitle(),
            const SizedBox(height: 150),
            const HostDescription(),
            RegisterButton(
              onPressed: () {
                // Handle registration logic
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.redirectingToRegistration)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
