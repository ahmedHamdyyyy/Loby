import 'package:flutter/material.dart';

import '../../../../locator.dart';
import '../../conversations/view/no_chat.dart';
import '../../profile/logic/cubit.dart';
import '../../profile/view/account_info/account.dart';
import '../../properties/view/properties_screen.dart';
import '../../reservation/view/noResurvation.dart';
import 'widget.dart';

class MainVendorHome extends StatefulWidget {
  const MainVendorHome({super.key});
  @override
  State<MainVendorHome> createState() => _MainVendorHomeState();
}

class _MainVendorHomeState extends State<MainVendorHome> {
  final _pages = [const PropertiesScreen(), const NoResurvationvendor(), const NoChatVendor(), const AccountScreen()];
  int currentIndex = 0;
  void updateCurrentIndex(int index) => setState(() => currentIndex = index);

  @override
  void initState() {
    super.initState();
    getIt<ProfileCubit>().fetchUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _pages[currentIndex],
    bottomNavigationBar: buildBottomNavigationBarVendor(currentIndex: currentIndex, onTap: updateCurrentIndex),
  );
}
