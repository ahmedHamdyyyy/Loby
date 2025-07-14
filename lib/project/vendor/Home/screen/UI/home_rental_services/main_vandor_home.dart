import 'package:flutter/material.dart';

import '../../../../../../locator.dart';
import '../../../../properties/cubit/cubit.dart';
import '../../../../properties/view/properties_screen.dart';
import '../../../cubit/home_cubit.dart';
import '../../widget/widget.dart';
import '../Conversations/no_chat.dart';
import '../account/account_info/account.dart';
import '../reservation/noResurvation.dart';

class MainVendorHome extends StatefulWidget {
  const MainVendorHome({super.key});
  @override
  State<MainVendorHome> createState() => _MainVendorHomeState();
}

class _MainVendorHomeState extends State<MainVendorHome> {
  final _pages = [const PropertiesScreen(),
   const NoResurvationvendor(), const NoChatVendor(), const AccountScreen()];
  int _currentIndex = 0;
  void updateCurrentIndex(int index) => setState(() => _currentIndex = index);

  @override
  void initState() {
    super.initState();
    getIt<PropertiesCubit>().getProperties();
    getIt<HomeCubit>().loadUserProfile();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _pages[_currentIndex],
    bottomNavigationBar: buildBottomNavigationBarVendor(currentIndex: _currentIndex, onTap: updateCurrentIndex),
  );
}
