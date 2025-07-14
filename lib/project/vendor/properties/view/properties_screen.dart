import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../locator.dart';
import '../../Home/cubit/home_cubit.dart';
import '../../Home/cubit/home_state.dart';
import '../../Home/screen/UI/home_rental_services/all_wideget_home.dart';
import '../../Home/screen/UI/notifications/notifications_screen.dart';
import '../cubit/cubit.dart';
import 'properties_list.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({super.key});
  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(ImageAssets.backgroundProfile), fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state.status == HomeStatus.loading) {
                          return const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white24,
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                          child: state.user.profilePicture.isEmpty
                              ? Image.asset(ImageAssets.profileImage, width: 56, height: 56, fit: BoxFit.cover)
                              : Image.network(
                                  state.user.profilePicture,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) =>
                                      Image.asset(ImageAssets.profileImage, width: 56, height: 56, fit: BoxFit.cover),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      width: 56,
                                      height: 56,
                                      color: Colors.grey[300],
                                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                    );
                                  },
                                ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        final String fullName = "${state.user.firstName} ${state.user.lastName}".trim();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName.isEmpty ? "Guest User" : fullName,
                              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Welcome to our App",
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ],
                        );
                      },
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreenVendor()));
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor,
                          shape: BoxShape.rectangle,
                        ),
                        child: SvgPicture.asset(ImageAssets.notificationsIcon, width: 30, height: 30),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 112),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 10, spreadRadius: 2)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textVendorNow(),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: AppColors.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () => showDialog(context: context, builder: (context) => const VendorTypeDialog()),
                              child: Text(
                                "Start",
                                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your properties",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                ),
                BlocProvider.value(value: getIt<PropertiesCubit>()..getProperties(), child: const PropertiesListView()),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  }
Column textVendorNow() {
    return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Be a vendor now !",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay lorem ipsum dolor sit amet, consecr text \nDiam habitant .",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grayTextColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "App Commission",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "The first party's commission for every reservation made by the second party is 14% of the rent (not including value added tax).",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grayTextColor,
                              ),
                            ),
                          ],
                        );
  }
