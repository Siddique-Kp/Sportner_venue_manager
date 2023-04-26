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

  Completer<GoogleMapController> get mapController => _mapController;
  GoogleMapController? get googleMapController => _googleMapController;

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
}
