import 'package:Luby/locator.dart';
import 'package:Luby/project/vendor/properties/view/edite_property_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/images/image_assets.dart';
import '../../models/property_model.dart';
import '../cubit/cubit.dart';

class PropertiesListView extends StatelessWidget {
  const PropertiesListView({super.key});

  @override
  Widget build(BuildContext context) => BlocSelector<PropertiesCubit, PropertiesState, List<CustomPropertyModel>>(
    selector: (state) => state.properties,
    builder: (context, properties) {
      if (properties.isEmpty) return const Center(child: Text('No Added Items Here...'));
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider.value(
                            value: getIt<PropertiesCubit>(),
                            child: PropertyScreen(propertyId: properties[index].id),
                          ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    height: 200,
                    image: property.image,
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
                  Text(property.type, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider.value(
                                value: getIt<PropertiesCubit>(),
                                child: PropertyScreen(propertyId: properties[index].id),
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
                                    getIt<PropertiesCubit>().deleteProperty(properties[index].id);
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
