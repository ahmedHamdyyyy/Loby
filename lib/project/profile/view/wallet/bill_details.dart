import 'package:flutter/material.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/widget/widgets.dart';
import 'widget_wellet.dart';

class BillDetails extends StatelessWidget {
  const BillDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPop(context, 'Bill Details', AppColors.primaryColor),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [BillDetailsHeader(), SizedBox(height: 16), BillDetailsCard()],
      ),
    );
  }
}
