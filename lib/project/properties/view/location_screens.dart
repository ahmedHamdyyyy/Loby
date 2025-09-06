import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../core/services/location_service.dart';
import '../../../../models/address.dart';

class LocationConfirmationScreen extends StatefulWidget {
  const LocationConfirmationScreen({super.key, required this.address});
  final String address;
  @override
  State<LocationConfirmationScreen> createState() => _LocationConfirmationScreenState();
}

class _LocationConfirmationScreenState extends State<LocationConfirmationScreen> {
  GoogleMapController? _mapController;
  LatLng _selectedLocation = const LatLng(24.7136, 46.6753); // Default: Riyadh
  String _selectedAddress = '';
  String _selectedCity = '';
  String _selectedState = '';
  String _selectedCountry = '';
  String _street = '';
  String _subLocality = '';
  String _postalCode = '';
  // bool _isLoading = true;
  bool _isLoadingAddress = false;

  @override
  void initState() {
    super.initState();

    // Initialize with default address if available
    if (widget.address.isNotEmpty) _selectedAddress = widget.address;

    _initializeMap();
  }

  void _initializeMap() async {
    // Try to get current location first, fallback to default
    final currentLocation = await LocationService().getCurrentLocation();
    if (currentLocation != null) {
      setState(() => _isLoadingAddress = true);

      // Get detailed place information including city, state, country
      await _updateLocationDetails(currentLocation);
    } else if (widget.address.isNotEmpty) {
      // In a real app, you'd geocode the address here
      // For now, we'll use the default location
      setState(() {
        _selectedAddress = widget.address;
      });
      await _updateLocationDetails(_selectedLocation);
    } else {
      await _updateLocationDetails(_selectedLocation);
    }
    setState(() {
      // _isLoading = false;
    });
  }

  Future<void> _updateLocationDetails(LatLng location) async {
    try {
      final placeDetails = await LocationService().getPlaceDetails(location);

      setState(() {
        _selectedLocation = location;

        // Extract detailed address components
        _street = placeDetails['street'] ?? '';
        _subLocality = placeDetails['subLocality'] ?? '';
        _selectedCity = placeDetails['locality'] ?? placeDetails['subLocality'] ?? '';
        _selectedState = placeDetails['administrativeArea'] ?? '';
        _selectedCountry = placeDetails['country'] ?? '';
        _postalCode = placeDetails['postalCode'] ?? '';

        // Create a well-formatted address
        _selectedAddress = _buildFormattedAddress();
        _isLoadingAddress = false;
      });
    } catch (e) {
      setState(() {
        _selectedLocation = location;
        _selectedAddress = '${location.latitude.toStringAsFixed(6)}, ${location.longitude.toStringAsFixed(6)}';
        _selectedCity = '';
        _selectedState = '';
        _selectedCountry = '';
        _street = '';
        _subLocality = '';
        _postalCode = '';
        _isLoadingAddress = false;
      });
    }
  }

  String _buildFormattedAddress() {
    List<String> addressParts = [];

    // Add street if available
    if (_street.isNotEmpty) {
      addressParts.add(_street);
    }

    // Add sub-locality if available and different from street
    if (_subLocality.isNotEmpty && _subLocality != _street) {
      addressParts.add(_subLocality);
    }

    // Add city if available and different from sub-locality
    if (_selectedCity.isNotEmpty && _selectedCity != _subLocality) {
      addressParts.add(_selectedCity);
    }

    // Add state if available
    if (_selectedState.isNotEmpty) {
      addressParts.add(_selectedState);
    }

    // Add postal code if available
    if (_postalCode.isNotEmpty) {
      addressParts.add(_postalCode);
    }

    // Add country if available
    if (_selectedCountry.isNotEmpty) {
      addressParts.add(_selectedCountry);
    }

    // If we have address parts, join them with commas
    if (addressParts.isNotEmpty) {
      return addressParts.join(', ');
    }

    // Fallback to coordinates if no address components
    return '${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}';
  }

  String _buildLocationSummary() {
    List<String> locationParts = [];

    if (_selectedCity.isNotEmpty) {
      locationParts.add(_selectedCity);
    }

    if (_selectedState.isNotEmpty) {
      locationParts.add(_selectedState);
    }

    if (_selectedCountry.isNotEmpty) {
      locationParts.add(_selectedCountry);
    }

    return locationParts.join(', ');
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    // Update address immediately when map is created
    _updateAddressForCurrentLocation();
  }

  void _updateAddressForCurrentLocation() async {
    setState(() {
      _isLoadingAddress = true;
    });

    await _updateLocationDetails(_selectedLocation);
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _selectedLocation = position.target;
    });
  }

  void _onCameraIdle() async {
    // When the map stops moving, update the selected location
    if (_mapController != null) {
      _mapController!
          .getVisibleRegion()
          .then((bounds) async {
            final center = LatLng(
              (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
              (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
            );

            setState(() {
              _isLoadingAddress = true;
            });

            await _updateLocationDetails(center);
          })
          .catchError((error) {
            // Fallback to simple coordinate format
            setState(() {
              _selectedAddress =
                  '${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}';
              _selectedCity = '';
              _selectedState = '';
              _selectedCountry = '';
              _street = '';
              _subLocality = '';
              _postalCode = '';
              _isLoadingAddress = false;
            });
          });
    } else {}
  }

  void _confirmLocation() {
    // Create a comprehensive formatted address
    String finalAddress = _selectedAddress;
    if (finalAddress.isEmpty) {
      finalAddress = '${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}';
    }

    // Clean and format the address components
    String cleanCity = _selectedCity.trim();
    String cleanState = _selectedState.trim();
    String cleanCountry = _selectedCountry.trim();

    // If city is empty, try to use sub-locality
    if (cleanCity.isEmpty && _subLocality.isNotEmpty) {
      cleanCity = _subLocality.trim();
    }

    // Return the selected location and address to the previous screen
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
      body: Stack(
        children: [
          // Google Maps
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _selectedLocation, zoom: 15.0),
            onCameraMove: _onCameraMove,
            onCameraIdle: _onCameraIdle,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            markers: {
              Marker(
                markerId: const MarkerId('selected_location'),
                position: _selectedLocation,
                draggable: true,
                onDragEnd: (newPosition) async {
                  setState(() {
                    _isLoadingAddress = true;
                  });

                  await _updateLocationDetails(newPosition);
                },
              ),
            },
          ),

          // Top search bar
          _buildSearchBar(),

          // Center marker indicator
          _buildCenterMarker(),

          // Bottom confirmation panel
          _buildConfirmationPanel(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            SvgPicture.asset(ImageAssets.searchIcon, width: 24, height: 24, color: AppColors.grayColorIcon),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Search location',
                style: GoogleFonts.poppins(color: AppColors.grayTextColor, fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterMarker() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.locationIcon,
            width: 48,
            height: 48,
            colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Text(
              'Drag to select location',
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grayTextColor),
            ),
          ),
        ],
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
          color: Colors.white.withOpacity(0.95),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Location address
            Row(
              children: [
                SvgPicture.asset(ImageAssets.locationIcon, width: 24, height: 24, color: AppColors.primaryColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Location',
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
                                'Getting address...',
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
              child: OutlinedButton(
                onPressed: () async {
                  setState(() {
                    _isLoadingAddress = true;
                  });

                  final currentLocation = await LocationService().getCurrentLocation();
                  if (currentLocation != null) {
                    await _updateLocationDetails(currentLocation);
                    // Animate to current location
                    _mapController?.animateCamera(CameraUpdate.newLatLng(currentLocation));
                  } else {
                    setState(() {
                      _isLoadingAddress = false;
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(
                  'Use Current Location',
                  style: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Update Address button (for testing)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  _updateAddressForCurrentLocation();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.orange),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(
                  'Update Address',
                  style: GoogleFonts.poppins(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _confirmLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: Text(
                  'Confirm Location',
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
