import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors/colors.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  final int currentIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      // unselectedItemColor: Colors.grey.shade600,
      // type: BottomNavigationBarType.fixed, // ثابت لعرض جميع العناصر
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
            'assets/images/home.svg',
            // ignore: deprecated_member_use
            color: const Color(0xFF414141),
            height: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/heart.svg',
            // ignore: deprecated_member_use
            color: const Color(0xFF414141),
            height: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/clipboard-tick.svg',
            // ignore: deprecated_member_use
            color: const Color(0xFF414141),
            height: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/messages.svg',
            // ignore: deprecated_member_use
            color: const Color(0xFF414141),
            height: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/user.svg',
            // ignore: deprecated_member_use
            color: const Color(0xFF414141),
            height: 24,
          ),
          label: '',
        ),
      ],
    );
  }
}
