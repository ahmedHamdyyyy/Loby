import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../core/services/location_service.dart';
import '../../../../models/address.dart';
import '../../../core/localization/l10n_ext.dart';

class LocationConfirmationScreen extends StatefulWidget {
  const LocationConfirmationScreen({super.key, required this.address});
  final Address address;
  @override
  State<LocationConfirmationScreen> createState() => _LocationConfirmationScreenState();
}

class _LocationConfirmationScreenState extends State<LocationConfirmationScreen> {
  GoogleMapController? _mapController;
  LatLng _selectedLocation = const LatLng(24.7136, 46.6753);
  String _selectedAddress = '', _selectedCity = '', _selectedState = '', _selectedCountry = '';
  bool _isLoadingAddress = false, _isMapReady = false, _isDraggingMarker = false;
  final TextEditingController _searchController = TextEditingController();
  List<Location> _searchResults = [];
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _initializeMap() async {
    setState(() => _isLoadingAddress = true);
    if (widget.address == Address.initial) {
      _selectedLocation = await LocationService().getCurrentLocation() ?? const LatLng(24.7136, 46.6753);
    } else {
      _selectedLocation = LatLng(widget.address.latitude, widget.address.longitude);
    }
    await _updateLocationDetails(_selectedLocation);
    setState(() => _isLoadingAddress = false);
  }

  Future<void> _updateLocationDetails(LatLng location) async {
    try {
      final placeDetails = await LocationService().getPlaceDetails(location);
      if (mounted) {
        setState(() {
          _selectedLocation = location;
          _selectedCity = placeDetails['locality'] ?? placeDetails['subLocality'] ?? '';
          _selectedState = placeDetails['administrativeArea'] ?? '';
          _selectedCountry = placeDetails['country'] ?? '';
          _selectedAddress = _buildFormattedAddress();
          _isLoadingAddress = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _selectedLocation = location;
          _selectedAddress = '${location.latitude.toStringAsFixed(6)}, ${location.longitude.toStringAsFixed(6)}';
          _selectedCity = '';
          _selectedState = '';
          _selectedCountry = '';
          _isLoadingAddress = false;
        });
      }
    }
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    try {
      final results = await LocationService().searchLocation(query);
      if (mounted) setState(() => _searchResults = results);
    } catch (e) {
      if (mounted) setState(() => _searchResults = []);
    }
  }

  Future<void> _selectSearchResult(Location location) async {
    final latLng = LatLng(location.latitude, location.longitude);
    setState(() {
      _selectedLocation = latLng;
      _searchResults = [];
      _searchController.clear();
      _searchFocusNode.unfocus();
      _isLoadingAddress = true;
    });

    await _updateLocationDetails(latLng);
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15.0));
  }

  Future<String> _getPlaceNameFromLocation(Location location) async {
    try {
      final placeDetails = await LocationService().getPlaceDetails(LatLng(location.latitude, location.longitude));

      List<String> nameParts = [];
      if (placeDetails['locality']?.isNotEmpty ?? false) {
        nameParts.add(placeDetails['locality']!);
      } else if (placeDetails['subLocality']?.isNotEmpty ?? false) {
        nameParts.add(placeDetails['subLocality']!);
      }

      if (placeDetails['administrativeArea']?.isNotEmpty ?? false) {
        nameParts.add(placeDetails['administrativeArea']!);
      }

      if (placeDetails['country']?.isNotEmpty ?? false) {
        nameParts.add(placeDetails['country']!);
      }

      if (nameParts.isNotEmpty) {
        return nameParts.join(', ');
      }

      return '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
    } catch (e) {
      return '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
    }
  }

  String _buildFormattedAddress() {
    List<String> addressParts = [];
    if (_selectedCity.isNotEmpty) addressParts.add(_selectedCity);
    if (_selectedState.isNotEmpty) addressParts.add(_selectedState);
    if (_selectedCountry.isNotEmpty) addressParts.add(_selectedCountry);

    if (addressParts.isEmpty) {
      return '${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}';
    }

    return addressParts.join(', ');
  }

  String _buildLocationSummary() {
    List<String> locationParts = [];
    if (_selectedCity.isNotEmpty) locationParts.add(_selectedCity);
    if (_selectedState.isNotEmpty) locationParts.add(_selectedState);
    if (_selectedCountry.isNotEmpty) locationParts.add(_selectedCountry);
    return locationParts.isNotEmpty ? locationParts.join(', ') : '';
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() => _isMapReady = true);
  }

  void _onCameraMove(CameraPosition position) {
    if (!_isDraggingMarker) {
      setState(() => _selectedLocation = position.target);
    }
  }

  void _onCameraIdle() async {
    if (_mapController != null && !_isDraggingMarker) {
      setState(() => _isLoadingAddress = true);
      await _updateLocationDetails(_selectedLocation);
    }
  }

  void _confirmLocation() {
    String finalAddress = _selectedAddress;
    if (finalAddress.isEmpty) {
      finalAddress = '${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}';
    }
    String cleanCity = _selectedCity.trim();
    String cleanState = _selectedState.trim();
    String cleanCountry = _selectedCountry.trim();
    final address = Address(
      formattedAddress: finalAddress,
      city: cleanCity,
      state: cleanState,
      country: cleanCountry,
      latitude: _selectedLocation.latitude,
      longitude: _selectedLocation.longitude,
    );
    Navigator.pop(context, address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard and search results when tapping on map
          _searchFocusNode.unfocus();
          if (_searchResults.isNotEmpty) {
            setState(() {
              _searchResults = [];
            });
          }
        },
        child: Stack(
          children: [
            // Google Maps
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: _selectedLocation, zoom: 15.0),
              onCameraMove: _onCameraMove,
              onCameraIdle: _onCameraIdle,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              markers: {
                Marker(
                  markerId: const MarkerId('selected_location'),
                  position: _selectedLocation,
                  draggable: true,
                  onDragStart: (position) {
                    setState(() => _isDraggingMarker = true);
                  },
                  onDrag: (position) {
                    setState(() {
                      _selectedLocation = position;
                      _isLoadingAddress = true;
                    });
                  },
                  onDragEnd: (newPosition) async {
                    setState(() {
                      _selectedLocation = newPosition;
                      _isDraggingMarker = false;
                    });
                    await _updateLocationDetails(newPosition);
                  },
                ),
              },
            ),

            // Loading overlay
            if (!_isMapReady)
              Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor)),
                      const SizedBox(height: 16),
                      Text(
                        context.l10n.loadingMap,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Top search bar (placeholder for future search functionality)
            _buildSearchBar(),

            // My Location button
            _buildMyLocationButton(),

            // Bottom confirmation panel
            _buildConfirmationPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 10, offset: const Offset(0, 2))],
            ),
            child: Row(
              children: [
                SvgPicture.asset(ImageAssets.searchIcon, width: 24, height: 24, color: AppColors.grayColorIcon),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: (value) {
                      _searchLocation(value);
                    },
                    decoration: InputDecoration(
                      hintText: context.l10n.searchLocation,
                      hintStyle: GoogleFonts.poppins(
                        color: AppColors.grayTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: GoogleFonts.poppins(color: AppColors.primaryTextColor, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.clear, color: AppColors.grayColorIcon, size: 20),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchResults = [];
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ),
          if (_searchResults.isNotEmpty) _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      constraints: const BoxConstraints(maxHeight: 250),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _searchResults.length,
        separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          final location = _searchResults[index];
          return FutureBuilder<String>(
            future: _getPlaceNameFromLocation(location),
            builder: (context, snapshot) {
              final placeName =
                  snapshot.data ?? '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
              return ListTile(
                leading: Icon(Icons.location_on, color: AppColors.primaryColor),
                title: Text(
                  placeName,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryTextColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle:
                    snapshot.hasData
                        ? Text(
                          '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}',
                          style: GoogleFonts.poppins(fontSize: 12, color: AppColors.grayTextColor),
                        )
                        : null,
                trailing:
                    snapshot.connectionState == ConnectionState.waiting
                        ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                          ),
                        )
                        : null,
                onTap: () => _selectSearchResult(location),
                dense: true,
              );
            },
          );
        },
      ),
    );
  }

  // Widget _buildCenterMarker() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         SvgPicture.asset(
  //           ImageAssets.locationIcon,
  //           width: 48,
  //           height: 48,
  //           colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
  //         ),
  //         const SizedBox(height: 8),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(12),
  //             boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 8, offset: const Offset(0, 2))],
  //           ),
  //           child: Text(
  //             context.l10n.dragToSelectLocation,
  //             style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grayTextColor),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildMyLocationButton() {
    return Positioned(
      right: 20,
      top: 130,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () async {
            setState(() => _isLoadingAddress = true);
            final currentLocation = await LocationService().getCurrentLocation();
            if (currentLocation != null) {
              setState(() => _selectedLocation = currentLocation);
              await _updateLocationDetails(currentLocation);
              _mapController?.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 15.0));
            } else {
              setState(() => _isLoadingAddress = false);
              if (mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(context.l10n.locationPermissionDenied), backgroundColor: Colors.red));
              }
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.my_location, color: AppColors.primaryColor, size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmationPanel() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(245),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 20, offset: const Offset(0, -5))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Location address
            Row(
              children: [
                // ignore: deprecated_member_use
                SvgPicture.asset(ImageAssets.locationIcon, width: 24, height: 24, color: AppColors.primaryColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.selectedLocation,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _isLoadingAddress
                          ? Row(
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                context.l10n.gettingAddress,
                                style: GoogleFonts.poppins(
                                  color: AppColors.grayTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedAddress,
                                style: GoogleFonts.poppins(
                                  color: AppColors.primaryTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (_selectedCity.isNotEmpty || _selectedState.isNotEmpty || _selectedCountry.isNotEmpty)
                                const SizedBox(height: 4),
                              if (_selectedCity.isNotEmpty || _selectedState.isNotEmpty || _selectedCountry.isNotEmpty)
                                Text(
                                  _buildLocationSummary(),
                                  style: GoogleFonts.poppins(
                                    color: AppColors.grayTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                            ],
                          ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Use Current Location button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed:
                    _isLoadingAddress
                        ? null
                        : () async {
                          setState(() => _isLoadingAddress = true);
                          final currentLocation = await LocationService().getCurrentLocation();
                          if (currentLocation != null) {
                            setState(() => _selectedLocation = currentLocation);
                            await _updateLocationDetails(currentLocation);
                            _mapController?.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 15.0));
                          } else {
                            setState(() => _isLoadingAddress = false);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Location Permission Denied'),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                icon: Icon(Icons.my_location, color: _isLoadingAddress ? Colors.grey : AppColors.primaryColor),
                label: Text(
                  context.l10n.useCurrentLocation,
                  style: GoogleFonts.poppins(
                    color: _isLoadingAddress ? Colors.grey : AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: _isLoadingAddress ? Colors.grey : AppColors.primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoadingAddress ? null : _confirmLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isLoadingAddress ? Colors.grey : AppColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: Text(
                  context.l10n.confirmLocation,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
