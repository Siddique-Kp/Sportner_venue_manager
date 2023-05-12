import 'package:flutter/material.dart';
import 'create_venue_view_model.dart';
import 'home_view_model.dart';

class EditVenueViewModel with ChangeNotifier {
  setEditVenueValues({
    required CreateVenueViewModel createViewModel,
    required HomeViewModel venueViewModel,
    required int index,
    required bool isEditVenue,
  }) {
    if (isEditVenue) {
      createViewModel.venueNameCntrllr.text =
          venueViewModel.vmVenueDataList[index].venueName!;
      createViewModel.venueMobileCntrllr.text =
          venueViewModel.vmVenueDataList[index].mobile.toString();
      createViewModel.venueAddressCntrllr.text =
          venueViewModel.vmVenueDataList[index].place!;
      createViewModel
          .getDistrict(venueViewModel.vmVenueDataList[index].district!);
      createViewModel.venueDescriptionCntrllr.text =
          venueViewModel.vmVenueDataList[index].description!;
                   
      createViewModel.venueDocument?.path.split("/").last =
          venueViewModel.vmVenueDataList[index].image!;
    }
  }
}
