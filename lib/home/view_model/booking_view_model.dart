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
  List<BookingDataModel> _bookingDataList = [];
  ErrorResponseModel? _errorResponseModel;
  bool _isLoading = false;

  List<BookingDataModel> get bookingDataList => _bookingDataList;
  bool get isLoading => _isLoading;

  Future<List<BookingDataModel>?> getBookingDatas() async {
    setLoading(false);
    final accessToken = await getAccessToken();
    final response = await ApiServices.getMethod(
      url: Urls.kGetAllbooking,
      jsonDecod: bookingDataModelFromJson,
      headers: {"Authorization": accessToken!},
    );

    if (response is Success) {
      setLoading(false);
      log("success");
    return  setBookingDatas(response.response as List<BookingDataModel>);
    }

    if (response is Failure) {
      log("failed");
      setLoading(false);
      final errorResponse = ErrorResponseModel(
        code: response.code,
        message: response.errorResponse,
      );
      return setErrorResponse(errorResponse);
    }
    return null;
  }

  List<BookingDataModel> setBookingDatas(
      List<BookingDataModel> bookingDataList) {
    _bookingDataList = bookingDataList;
    return _bookingDataList;
  }

  setErrorResponse(ErrorResponseModel errorResp) {
    _errorResponseModel = errorResp;
    notifyListeners();
    return _errorResponseModel!.code;
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
