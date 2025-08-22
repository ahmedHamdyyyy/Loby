import 'package:flutter/material.dart';

import '../../../../locator.dart';
import '../../../config/constants/constance.dart';
import '../../../core/services/cach_services.dart';
import '../../activities/logic/cubit.dart';
import '../../conversations/view/no_chat.dart';
import '../../profile/logic/cubit.dart';
import '../../profile/view/account_info/account.dart';
import '../../properties/logic/cubit.dart';
import '../../properties/view/properties_screen.dart';
import '../../reservation/view/noResurvation.dart';
import 'widget.dart';

class MainVendorHome extends StatefulWidget {
  const MainVendorHome({super.key});
  @override
  State<MainVendorHome> createState() => _MainVendorHomeState();
}

class _MainVendorHomeState extends State<MainVendorHome> {
  final _pages = [const HomeScreen(), const NoResurvationvendor(), const NoChatVendor(), const AccountScreen()];
  int currentIndex = 0;
  void updateCurrentIndex(int index) => setState(() => currentIndex = index);

  @override
  void initState() {
    super.initState();
    getIt<ProfileCubit>().fetchUser();
    final role = getIt<CacheService>().storage.getString(AppConst.vendorRole);
    final vendorRole = VendorRole.values.firstWhere((e) => e.name == role, orElse: () => VendorRole.non);
    if (vendorRole == VendorRole.property) {
      getIt<PropertiesCubit>().getProperties();
    } else if (vendorRole == VendorRole.activity) {
      getIt<ActivitiesCubit>().getActivities();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _pages[currentIndex],
    bottomNavigationBar: buildBottomNavigationBarVendor(currentIndex: currentIndex, onTap: updateCurrentIndex),
  );
}
