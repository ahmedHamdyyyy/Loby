import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/images/image_assets.dart';

Positioned iconImageTaxtVendor() => const Positioned(
  top: 50,
  left: 20,
  child: Row(
    children: [
      CircleAvatar(radius: 30, backgroundImage: AssetImage(ImageAssets.profileImage)),
      SizedBox(width: 8), // مسافة بين الأيقونة والنص
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Mostafa Abdalah", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
          Text("Welcome to our App", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
        ],
      ),
    ],
  ),
);

Widget buildBottomNavigationBarVendor({int currentIndex = 0, Function(int)? onTap}) => BottomNavigationBar(
  backgroundColor: Colors.white,
  selectedItemColor: Colors.red,
  unselectedItemColor: Colors.grey.shade600,
  type: BottomNavigationBarType.fixed,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  selectedFontSize: 12,
  unselectedFontSize: 12,
  elevation: 8,
  currentIndex: currentIndex,
  onTap: onTap,
  items: [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ImageAssets.home,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        ImageAssets.home,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      ),
      label: "Home",
    ),
    //  BottomNavigationBarItem(
    //   icon: SvgPicture.asset(
    //     ImageAssets.billIcon,
    //     width: 24,
    //     height: 24,
    //     colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
    //   ),
    //   activeIcon: SvgPicture.asset(
    //     ImageAssets.billIcon,
    //     width: 24,
    //     height: 24,
    //     colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
    //   ),
    //   label: "Activities",
    // ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ImageAssets.clipboardTick,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        ImageAssets.clipboardTick,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      ),
      label: "Bookings",
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ImageAssets.messages,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        ImageAssets.messages,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      ),
      label: "Messages",
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ImageAssets.userIcon,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        ImageAssets.userIcon,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
      ),
      label: "Profile",
    ),
  ],
);
