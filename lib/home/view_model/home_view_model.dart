import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/home/model/vm_venue_data_model.dart';
import 'package:sportner_venue_manager/utils/constants.dart';
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
  int? get errorCode => _errorCode;

  bool get isLoading => _isLoading;

  getVmVenueDatas() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));

    final accessToken = await AccessToken.getAccessToken();

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

  getBlockVenue(String venueId) async {
    final accessToken = await AccessToken.getAccessToken();

    final response = await ApiServices.dioPutMethod(
      url: Urls.kBlockVenue,
      body: {"id": venueId},
      headers: accessToken,
    );

    if (response is Success) {
      log("success");
      setBlockVenue(venueId);
    }
    if (response is Failure) {
      log("failed");
      log(response.errorResponse.toString());
    }
  }

  setVmVenueDatas(List<VmVenueDataModel> vmVenueDataList) {
    _vmVenueDataList = vmVenueDataList;
    log(_vmVenueDataList[0].isBlocked.toString());
    notifyListeners();
  }

  setBlockVenue(String venueId) {
    final venueData = _vmVenueDataList.any((element) => element.id == venueId);
    if (venueData) {
      final index =
          _vmVenueDataList.indexWhere((element) => element.id == venueId);

      _vmVenueDataList[index].vmIsBlocked =
          !_vmVenueDataList[index].vmIsBlocked!;
    }
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
}
