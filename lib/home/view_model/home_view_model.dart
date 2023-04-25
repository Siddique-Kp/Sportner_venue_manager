import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/home/model/vm_venue_data_model.dart';
import 'package:sportner_venue_manager/utils/constants.dart';
import 'package:sportner_venue_manager/utils/keys.dart';
import 'package:sportner_venue_manager/repo/api_services.dart';
import 'package:sportner_venue_manager/repo/api_status.dart';

class HomeViewModel with ChangeNotifier {
  List<VmVenueDataModel> _vmVenueDataList = [];
  bool _isLoading = false;

  List<VmVenueDataModel> get vmVenueDataList => _vmVenueDataList;
  bool get isLoading => _isLoading;

  Future<List<VmVenueDataModel>?> getVmVenueDatas() async {
    setLoading(false);
    final accessToken = await getAccessToken();
    final response = await ApiServices.getMethod(
      url: Urls.kGetAllVenues,
      jsonDecod: vmVenueDataModelFromJson,
      headers: {"Authorization": accessToken!},
    );

    if (response is Success) {
      setLoading(false);
      log("success");
      return setVmVenueDatas(response.response as List<VmVenueDataModel>);
    }

    if (response is Failure) {
      log("failed");
      return setLoading(false);
    }
    return null;
  }

  List<VmVenueDataModel> setVmVenueDatas(
      List<VmVenueDataModel> vmVenueDataList) {
    _vmVenueDataList = vmVenueDataList;
    return _vmVenueDataList;
  }

  setLoading(bool loading) {
    _isLoading = loading;
  }

  Future<String?> getAccessToken() async {
    final sharedpref = await SharedPreferences.getInstance();
    final accessToken = sharedpref.getString(GlobalKeys.accesToken);
    return accessToken;
  }
}
