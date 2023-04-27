import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/shimmer_widget.dart';
import 'package:sportner_venue_manager/home/view_model/create_venue_view_model.dart';
import 'package:sportner_venue_manager/home/view_model/google_map_view_model.dart';

class GoogleMapWidget extends StatelessWidget {
  final double height;
  const GoogleMapWidget({super.key, this.height = 150});

  @override
  Widget build(BuildContext context) {
    final googleMapViewModel = context.watch<GoogleMapViewModel>();
    final createVenueViewModel = context.read<CreateVenueViewModel>();
    try {
      return googleMapViewModel.currentLocation == null
          ? ShimmerWidget.rectangle(width: double.infinity, height: height)
          : GoogleMap(
              zoomControlsEnabled: false,
              // myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  googleMapViewModel.currentLocation!.latitude!,
                  googleMapViewModel.currentLocation!.longitude!,
                ),
                zoom: 14.5,
              ),
              onMapCreated: (controller) {
                googleMapViewModel.getControllervalue(controller);
              },
              markers: {
                Marker(
                  markerId: const MarkerId("CurrentLocation"),
                  position: LatLng(
                    googleMapViewModel.currentLocation!.latitude!,
                    googleMapViewModel.currentLocation!.longitude!,
                  ),
                ),
                if (googleMapViewModel.selectedMarker != null)
                  googleMapViewModel.selectedMarker!,
              },
              onLongPress: (latlong) {
                googleMapViewModel.addMarker(latlong, googleMapViewModel);
                createVenueViewModel.getSelectedLocation(latlong);
              },
            );
    } catch (error, stackTrace) {
      FlutterErrorDetails details =
          FlutterErrorDetails(exception: error, stack: stackTrace);
      FlutterError.reportError(details);
      return const Center(child: Text("Something Went Wrong"));
    }
  }
}
