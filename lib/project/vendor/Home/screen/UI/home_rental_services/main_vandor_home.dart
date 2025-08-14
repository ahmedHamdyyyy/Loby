import 'package:flutter/material.dart';

import '../../../../../../locator.dart';
import '../../../../activities/view/screens/activetes_screen.dart';
import '../../../../properties/cubit/cubit.dart';
import '../../../../properties/view/properties_screen.dart';
import '../../../../user/cubit/cubit.dart';
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
  final _pages = [
    const PropertiesScreen(),
    ActivitiesScreen(),
    const NoResurvationvendor(),
    const NoChatVendor(),
    const AccountScreen(),
  ];
  int currentIndex = 0;
  void updateCurrentIndex(int index) => setState(() => currentIndex = index);

  @override
  void initState() {
    super.initState();
    // getIt<UserCubit>().getCachedUser();
    getIt<UserCubit>().fetchUser();
    getIt<PropertiesCubit>().getProperties();
    //getIt<HomeCubit>().loadUserProfile();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _pages[currentIndex],
    bottomNavigationBar: buildBottomNavigationBarVendor(currentIndex: currentIndex, onTap: updateCurrentIndex),
  );
}
