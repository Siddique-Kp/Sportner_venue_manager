import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapViewModel with ChangeNotifier {
  GoogleMapViewModel() {
    getCurrentLocation();
  }

  LocationData? currentLocation;
  final Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? _googleMapController;
  Marker? _selectedMarker;

  Completer<GoogleMapController> get mapController => _mapController;
  GoogleMapController? get googleMapController => _googleMapController;
  Marker? get selectedMarker => _selectedMarker;

  setSelectedMarker(Marker? selectedPosition) {
    _selectedMarker = selectedPosition;
    notifyListeners();
  }

  getControllervalue(GoogleMapController controller) {
    _googleMapController = controller;
    notifyListeners();
  }

  getCurrentLocation() async {
    Location location = Location();

    await location.getLocation().then((location) {
      currentLocation = location;
      notifyListeners();
    });

    // location.onLocationChanged.listen(
    //   (newLocation) {
    //     currentLocation = newLocation;

    //     _googleMapController?.animateCamera(
    //       CameraUpdate.newCameraPosition(
    //         CameraPosition(
    //           zoom: 14.5,
    //           target: LatLng(
    //             newLocation.latitude!,
    //             newLocation.longitude!,
    //           ),
    //         ),
    //       ),
    //     );
    //     notifyListeners();
    //   },
    // );
  }

  addMarker(LatLng position, GoogleMapViewModel googleMapViewModel) {
    if (googleMapViewModel.selectedMarker != null) {
      setSelectedMarker(null);
    } else {
      final selectedLocation = Marker(
        markerId: const MarkerId("SelectedLocation"),
        infoWindow: const InfoWindow(title: "Selected Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: position,
      );
      setSelectedMarker(selectedLocation);
    }
  }
}
