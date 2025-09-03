import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/colors/colors.dart';
import '../../../../config/images/image_assets.dart';
import '../../../../core/services/location_service.dart';

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
  bool _isLoading = true;
  bool _isLoadingAddress = false;

  @override
  void initState() {
    super.initState();
    print('LocationConfirmationScreen initState called');
    print('widget.address: ${widget.address}');
    
    // Initialize with default address if available
    if (widget.address.isNotEmpty) {
      _selectedAddress = widget.address;
      print('Initialized _selectedAddress with widget.address: $_selectedAddress');
    }
    
    _initializeMap();
  }

  void _initializeMap() async {
    print('Initializing map...');
    print('Initial _selectedAddress: $_selectedAddress');
    
    // Try to get current location first, fallback to default
    final currentLocation = await LocationService().getCurrentLocation();
    if (currentLocation != null) {
      print('Current location found: ${currentLocation.latitude}, ${currentLocation.longitude}');
      setState(() {
        _isLoadingAddress = true;
      });
      
      // Get address from current location using Reverse Geocoding
      final address = await LocationService().getAddressFromCoordinates(currentLocation);
      print('Address from current location: $address');
      
      setState(() {
        _selectedLocation = currentLocation;
        _selectedAddress = address;
        _isLoadingAddress = false;
      });
      print('Updated _selectedAddress to: $_selectedAddress');
    } else if (widget.address.isNotEmpty) {

      // In a real app, you'd geocode the address here
      // For now, we'll use the default location
      setState(() {
        _selectedAddress = widget.address;
      });
    } else {

      final address = await LocationService().getAddressFromCoordinates(_selectedLocation);
      setState(() {
        _selectedAddress = address;
      });
      print('Updated _selectedAddress to: $_selectedAddress');
    }
    setState(() {
      _isLoading = false;
    });
    print('Map initialization complete. Final _selectedAddress: $_selectedAddress');
  }

  void _onMapCreated(GoogleMapController controller) {
    print('=== MAP CREATED ===');
    _mapController = controller;
    
    // Update address immediately when map is created
    _updateAddressForCurrentLocation();
  }

  void _updateAddressForCurrentLocation() async {
    print('=== UPDATING ADDRESS FOR CURRENT LOCATION ===');
    print('Current _selectedLocation: ${_selectedLocation.latitude}, ${_selectedLocation.longitude}');
    
    setState(() {
      _isLoadingAddress = true;
    });
    
    try {
      final address = await LocationService().getAddressFromCoordinates(_selectedLocation);
      print('Got address: "$address"');
      
      setState(() {
        _selectedAddress = address;
        _isLoadingAddress = false;
      });
      print('Updated _selectedAddress to: "$_selectedAddress"');
    } catch (e) {
      print('Error getting address: $e');
      setState(() {
        _selectedAddress = '${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}';
        _isLoadingAddress = false;
      });
      print('Fallback: Updated _selectedAddress to: "$_selectedAddress"');
    }
  }

  void _onCameraMove(CameraPosition position) {
    print('=== CAMERA MOVING ===');
    print('New position: ${position.target.latitude}, ${position.target.longitude}');
    setState(() {
      _selectedLocation = position.target;
    });
    print('Updated _selectedLocation to: ${_selectedLocation.latitude}, ${_selectedLocation.longitude}');
  }

  void _onCameraIdle() async {
    print('=== CAMERA IDLE CALLED ===');
    // When the map stops moving, update the selected location
    if (_mapController != null) {
      print('Map controller is available, getting visible region...');
      _mapController!.getVisibleRegion().then((bounds) async {
        print('Got visible region bounds: $bounds');
        final center = LatLng(
          (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
          (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
        );
        print('Calculated center: ${center.latitude}, ${center.longitude}');
        
        setState(() {
          _isLoadingAddress = true;
        });
        print('Set _isLoadingAddress to true');
        
        // Get address from coordinates using Reverse Geocoding
        print('Getting address for coordinates: ${center.latitude}, ${center.longitude}');
        final address = await LocationService().getAddressFromCoordinates(center);
        print('Received address: "$address"');
        
        setState(() {
          _selectedLocation = center;
          _selectedAddress = address;
          _isLoadingAddress = false;
        });
        print('Updated _selectedAddress to: "$_selectedAddress"');
        print('Updated _selectedLocation to: ${_selectedLocation.latitude}, ${_selectedLocation.longitude}');
      }).catchError((error) {
        print('Error getting visible region: $error');
        // Fallback to simple coordinate format
        setState(() {
          _selectedAddress = '${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}';
          _isLoadingAddress = false;
        });
        print('Fallback: Updated _selectedAddress to: "$_selectedAddress"');
      });
    } else {
      print('Map controller is null, cannot get visible region');
    }
  }

  void _confirmLocation() {
  
    // Check if address is empty and provide fallback
    String finalAddress = _selectedAddress;
    if (finalAddress.isEmpty) {
      print('WARNING: _selectedAddress is empty, using coordinates as fallback');
      finalAddress = '${_selectedLocation.latitude.toStringAsFixed(6)}, ${_selectedLocation.longitude.toStringAsFixed(6)}';
    }
    
    // Return the selected location and address to the previous screen
    final result = {
      'latitude': _selectedLocation.latitude,
      'longitude': _selectedLocation.longitude,
      'address': finalAddress,
    };
    
 
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Maps
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 15.0,
            ),
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
                  
                  // Get address from new position using Reverse Geocoding
                  final address = await LocationService().getAddressFromCoordinates(newPosition);
                  setState(() {
                    _selectedLocation = newPosition;
                    _selectedAddress = address;
                    _isLoadingAddress = false;
                  });
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              ImageAssets.searchIcon,
              width: 24,
              height: 24,
              color: AppColors.grayColorIcon,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Search location',
                style: GoogleFonts.poppins(
                  color: AppColors.grayTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
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
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Drag to select location',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.grayTextColor,
              ),
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
                                  // Location address
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.locationIcon,
                            width: 24,
                            height: 24,
                            color: AppColors.primaryColor,
                          ),
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
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                AppColors.primaryColor,
                                              ),
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
                                    : Text(
                                        _selectedAddress,
                                        style: GoogleFonts.poppins(
                                          color: AppColors.primaryTextColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
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
                    // Get address from current location using Reverse Geocoding
                    final address = await LocationService().getAddressFromCoordinates(currentLocation);
                    setState(() {
                      _selectedLocation = currentLocation;
                      _selectedAddress = address;
                      _isLoadingAddress = false;
                    });
                    // Animate to current location
                    _mapController?.animateCamera(
                      CameraUpdate.newLatLng(currentLocation),
                    );
                  } else {
                    setState(() {
                      _isLoadingAddress = false;
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Use Current Location',
                  style: GoogleFonts.poppins(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Update Address',
                  style: GoogleFonts.poppins(
                    color: Colors.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Confirm Location',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
