import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/home/model/booking_data_model.dart';
import 'package:sportner_venue_manager/home/model/error_response_model.dart';
import '../../utils/constants.dart';
import '../../utils/keys.dart';
import '../../repo/api_services.dart';
import '../../repo/api_status.dart';

class BookingViewModel with ChangeNotifier {
  BookingViewModel() {
    getBookingDatas();
  }

  List<BookingDataModel> _bookingDataList = [];
  ErrorResponseModel? _errorData;
  bool _isLoading = false;

  List<BookingDataModel> get bookingDataList => _bookingDataList;
  bool get isLoading => _isLoading;
  ErrorResponseModel? get errorData => _errorData;

  getBookingDatas() async {
    setLoading(true);
    final accessToken = await getAccessToken();
    final response = await ApiServices.getMethod(
      url: Urls.kGetAllbooking,
      jsonDecod: bookingDataModelFromJson,
      headers: {"Authorization": accessToken!},
    );

    if (response is Success) {
      setLoading(false);
      log("success");
      setBookingDatas(response.response as List<BookingDataModel>);
    }

    if (response is Failure) {
      log("failed");
      setLoading(false);
      final errorResponse = ErrorResponseModel(
        code: response.code,
        message: response.errorResponse,
      );
      setErrorResponse(errorResponse);
    }
  }

  setBookingDatas(List<BookingDataModel> bookingDataList) {
    _bookingDataList = bookingDataList;
    notifyListeners();
  }

  setErrorResponse(ErrorResponseModel errorResp) {
    _errorData = errorResp;
    notifyListeners();
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<String?> getAccessToken() async {
    final sharedpref = await SharedPreferences.getInstance();
    final accessToken = sharedpref.getString(GlobalKeys.accesToken);
    return accessToken;
  }
}
