import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/constance.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../config/widget/widget.dart';
import '../../../../core/utils/utile.dart';
import '../../../../locator.dart';
import '../../logic/cubit.dart';
import '../screens/activity_screen.dart';

class ActivitiesListView extends StatelessWidget {
  const ActivitiesListView({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<ActivitiesCubit, ActivitiesState>(
    listener: (context, state) {
      switch (state.deleteStatus) {
        case Status.loading:
          Utils.loadingDialog(context);
        case Status.success:
          Navigator.pop(context);
          showToast(text: 'Activity Deleted Successfully', stute: ToustStute.success);
          break;
        case Status.error:
          Navigator.pop(context);
          showToast(text: state.msg, stute: ToustStute.error);
          break;
        case Status.initial:
          break;
      }
    },
    builder: (context, state) {
      final activities = state.activities;
      if (activities.isEmpty) return const Center(child: Text('No Added Items Here...'));
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityScreen(activityId: activity.id)));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    height: 200,
                    image: activity.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/IMAG.png',
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/IMAG.png', height: 200, width: double.infinity, fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(activity.name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider.value(
                                value: getIt<ActivitiesCubit>(),
                                child: ActivityScreen(activityId: activities[index].id),
                              ),
                        ),
                      );
                    },
                    child: SvgPicture.asset(ImageAssets.editIcon, height: 20, width: 20),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              title: Text('Delete Property', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                              content: Text('Are you sure you want to delete this property?', style: GoogleFonts.poppins()),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel', style: GoogleFonts.poppins()),
                                ),
                                TextButton(
                                  onPressed: () {
                                    getIt<ActivitiesCubit>().deleteActivity(activity.id);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete', style: GoogleFonts.poppins(color: Colors.red)),
                                ),
                              ],
                            ),
                      );
                    },
                    child: SvgPicture.asset(ImageAssets.deleteIcon, height: 20, width: 20),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      );
    },
  );
}
