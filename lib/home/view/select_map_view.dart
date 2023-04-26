import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/create_venue_components/google_map_widget.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';

import '../view_model/google_map_view_model.dart';

class SelectMapView extends StatelessWidget {
  const SelectMapView({super.key});

  @override
  Widget build(BuildContext context) {
    final googleMapViewModel = context.watch<GoogleMapViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Google Map"),
      ),
      body: const GoogleMapWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          googleMapViewModel.googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 14.5,
                target: LatLng(
                  googleMapViewModel.currentLocation!.latitude!,
                  googleMapViewModel.currentLocation!.longitude!,
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
