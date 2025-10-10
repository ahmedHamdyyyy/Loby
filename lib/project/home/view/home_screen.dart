import 'package:Luby/config/constants/constance.dart';
import 'package:Luby/project/profile/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../locator.dart';
import '../../../core/utils/utile.dart';
import '../../activities/logic/cubit.dart';
import '../../activities/view/screens/activity_screen.dart';
import '../../activities/view/widgets/activetes_list.dart';
import '../../notifications/view/notifications_screen.dart';
import '../../profile/view/account_info/account_after_save.dart';
import '../../properties/logic/cubit.dart';
import '../../properties/view/properties_list.dart';
import '../../properties/view/property_types_screen.dart';
import 'vendor_type_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

VendorRole _vendorRole = VendorRole.non;
bool _isVerified = false;

class _HomeScreenState extends State<HomeScreen> {
  void _updateVendorRole(String role, bool verified) {
    _vendorRole = VendorRole.values.firstWhere((e) => e.name == role, orElse: () => VendorRole.non);
    _isVerified = verified;
    if (_vendorRole == VendorRole.property) {
      getIt<PropertiesCubit>().getProperties();
    } else if (_vendorRole == VendorRole.activity) {
      getIt<ActivitiesCubit>().getActivities();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => getIt<PropertiesCubit>().getProperties(),
      child: Scaffold(
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
                        BlocConsumer<ProfileCubit, ProfileState>(
                          listener: (context, state) {
                            if (state.fetchUserStatus == Status.success) {
                              _updateVendorRole(state.user.role, state.user.isVerified);
                            }
                          },
                          builder: (context, state) {
                            if (state.fetchUserStatus == Status.loading) {
                              return const CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.white24,
                                child: CircularProgressIndicator(),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountScreen()));
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                child:
                                    state.user.profilePicture.isEmpty
                                        ? Image.asset(ImageAssets.profileImage, width: 56, height: 56, fit: BoxFit.cover)
                                        : Image.network(
                                          state.user.profilePicture,
                                          width: 56,
                                          height: 56,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, _, _) {
                                            return Image.asset(
                                              ImageAssets.profileImage,
                                              width: 56,
                                              height: 56,
                                              fit: BoxFit.cover,
                                            );
                                          },
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
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              final String fullName = "${state.user.firstName} ${state.user.lastName}".trim();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fullName.isEmpty ? "Guest User" : fullName,
                                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Welcom to our App",
                                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NotificationsScreenVendor()),
                            );
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
                              BlocConsumer<ProfileCubit, ProfileState>(
                                listener: (context, state) {
                                  if (state.chooseVendorRole == Status.loading) {
                                    Utils.loadingDialog(context);
                                  } else if (state.chooseVendorRole == Status.error) {
                                    Navigator.pop(context);
                                    Utils.errorDialog(context, state.callback);
                                  } else if (state.chooseVendorRole == Status.success) {
                                    Navigator.pop(context);
                                    _updateVendorRole(state.user.role, state.user.isVerified);
                                    if (_vendorRole == VendorRole.property) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const PropertyTypesScreen()),
                                      );
                                    } else if (_vendorRole == VendorRole.activity) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ActivityScreen(activityId: '')),
                                      );
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      backgroundColor: AppColors.primaryColor,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      minimumSize: const Size(double.infinity, 48),
                                    ),
                                    onPressed: () async {
                                      if (state.fetchUserStatus == Status.loading) return;
                                      if (!state.user.isVerified) {
                                        Utils.errorDialog(
                                          context,
                                          "Your email is not verified please wait until it is verified then try again.",
                                        );
                                        return;
                                      }
                                      switch (_vendorRole) {
                                        case VendorRole.non:
                                          final vendorRole = await showDialog<VendorRole?>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => const VendorTypeDialog(),
                                          );
                                          if (vendorRole == null) break;
                                          getIt<ProfileCubit>().chooseVendorRole(vendorRole);
                                          break;
                                        case VendorRole.property:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const PropertyTypesScreen()),
                                          );
                                          break;
                                        case VendorRole.activity:
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const ActivityScreen(activityId: '')),
                                          );
                                          break;
                                      }
                                    },
                                    child:
                                        state.fetchUserStatus == Status.loading
                                            ? const CircularProgressIndicator()
                                            : Text(
                                              "Start",
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                  );
                                },
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
              if (_vendorRole == VendorRole.property)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your properties",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                      ),
                      const PropertiesListView(),
                    ],
                  ),
                )
              else if (_vendorRole == VendorRole.activity)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your activities",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                      ),
                      const ActivitiesListView(),
                    ],
                  ),
                )
              else
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!_isVerified) IconButton(onPressed: getIt<ProfileCubit>().fetchUser, icon: Icon(Icons.refresh)),
                        Text('Select Your Role Now!'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Column textVendorNow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Be a vendor now !",
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
      ),
      const SizedBox(height: 20),
      Text(
        "Lorem ipsum dolor sit amet, consecr text adipiscing edit text hendrerit triueas dfay lorem ipsum dolor sit amet, consecr text \nDiam habitant .",
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
      ),
      const SizedBox(height: 20),
      Text(
        "App Commission",
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
      ),
      const SizedBox(height: 10),
      Text(
        "The first party's commission for every reservation made by the second party is 14% of the rent (not including value added tax).",
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.grayTextColor),
      ),
    ],
  );
}
