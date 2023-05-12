import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/home/model/vm_venue_data_model.dart';
import 'package:sportner_venue_manager/utils/constants.dart';
import 'package:sportner_venue_manager/utils/keys.dart';
import 'package:sportner_venue_manager/repo/api_services.dart';
import 'package:sportner_venue_manager/repo/api_status.dart';


class HomeViewModel with ChangeNotifier {
  HomeViewModel() {
    getVmVenueDatas();
  }
  List<VmVenueDataModel> _vmVenueDataList = [];
  int? _errorCode;
  bool _isLoading = false;

  List<VmVenueDataModel> get vmVenueDataList => _vmVenueDataList;
  int? get errorCode =>_errorCode;

  bool get isLoading => _isLoading;

  getVmVenueDatas() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 3));

    final accessToken = await getAccessToken();

    final response = await ApiServices.dioGetMethod(
      url: Urls.kGetAllVenues,
      jsonDecod: vmVenueDataModelFromJson,
      headers: accessToken,
    );

    if (response is Success) {
      setLoading(false);
      log("success");
      setVmVenueDatas(response.response as List<VmVenueDataModel>);
    }

    if (response is Failure) {
      log("failed");
      setErrorResponse(response);
      setLoading(false);
    }
  }

  setVmVenueDatas(List<VmVenueDataModel> vmVenueDataList) {
    _vmVenueDataList = vmVenueDataList;
    notifyListeners();
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  setErrorResponse(Failure error) {
    _errorCode = error.code;
    notifyListeners();
  }

  Future<String?> getAccessToken() async {
    final sharedpref = await SharedPreferences.getInstance();
    final accessToken = sharedpref.getString(GlobalKeys.accesToken);
    return accessToken;
  }
}
