import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/home/view_model/home_view_model.dart';
import 'package:sportner_venue_manager/repo/api_status.dart';
import '../../repo/api_services.dart';
import '../../utils/constants.dart';
import '../../utils/keys.dart';
import 'create_venue_view_model.dart';

class EditVenueViewModel with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> editVenueApiService({
    required BuildContext context,
    required String venueId,
  }) async {
    bool isSuccess = false;
    setLoading(true);
    final editBody = context.read<CreateVenueViewModel>().createVenueBody();
    final accessToken = await getAccessToken();
    final response = await ApiServices.dioPutMethod(
      url: Urls.kUpdateVenue + venueId,
      body: editBody,
      headers: accessToken!,
    );

    if (response is Success) {
      log("edit venue success");
      isSuccess = true;
      await context.read<HomeViewModel>().getVmVenueDatas();
      setLoading(false);
    }

    if (response is Failure) {
      isSuccess = false;
      log("edit venue failed");
      setLoading(false);
    }
    return isSuccess;
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<String?> getAccessToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    final accessToken = sharedPref.getString(GlobalKeys.accesToken);
    return accessToken;
  }
}
