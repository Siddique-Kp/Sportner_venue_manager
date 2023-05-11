import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/home/model/booking_data_model.dart';
import '../../utils/constants.dart';
import '../../utils/keys.dart';
import '../../repo/api_services.dart';
import '../../repo/api_status.dart';

class BookingViewModel with ChangeNotifier {
  BookingViewModel() {
    getBookingDatas();
  }

  List<BookingDataModel> _bookingDataList = [];
  List<BookingDataModel> _allbookingList = [];
  final List<BookingDataModel> _pendingbookings = [];
  final List<BookingDataModel> _completedBookings = [];
  int? _errorCode;
  int _totalEarnings = 0;
  bool _isLoading = false;

  List<BookingDataModel> get bookingDataList => _bookingDataList;
  List<BookingDataModel> get allbookingList => _allbookingList;
  List<BookingDataModel> get pendingbookings => _pendingbookings;
  List<BookingDataModel> get completedBookings => _completedBookings;
  int get totalEarnings => _totalEarnings;
  bool get isLoading => _isLoading;
  int? get errorCode => _errorCode;

  getBookingDatas() async {
    setLoading(true);
    final accessToken = await getAccessToken();
    final response = await ApiServices.dioGetMethod(
      url: Urls.kGetAllbooking,
      jsonDecod: bookingDataModelFromJson,
      headers: accessToken,
    );

    if (response is Success) {
      setLoading(false);
      log("success");
      setBookingDatas(response.response as List<BookingDataModel>);
    }

    if (response is Failure) {
      log("failed");
      setLoading(false);
      setErrorResponse(response);
    }
  }

  setBookingDatas(List<BookingDataModel> bookingData) {
    _bookingDataList = bookingData;
    _allbookingList = bookingDataList;
    setCompletedList();
    setPendingList();
    notifyListeners();
  }

  setSelectedPopUp(String value) {
    _allbookingList = [];
    if (value == "all") {
      _allbookingList = _bookingDataList;
    } else if (value == "pending") {
      _allbookingList = _pendingbookings;
    } else if (value == "completed") {
      _allbookingList = _completedBookings;
    }
    notifyListeners();
  }

  setCompletedList() {
    _completedBookings.clear();
    for (var element in _bookingDataList) {
      final isCompleted = isBookingExpired(element);
      if (isCompleted) {
        _completedBookings.add(element);
      }
    }
    notifyListeners();
  }

  setPendingList() {
    _pendingbookings.clear();
    for (var element in _bookingDataList) {
      final isCompleted = isBookingExpired(element);
      if (!isCompleted) {
        _pendingbookings.add(element);
      }
    }
    notifyListeners();
  }

  setErrorResponse(Failure error) {
    _errorCode = error.code;
    notifyListeners();
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Convert to 12 hours
  String convertTo12HourFormat(String time24) {
    if (time24 == "HH:MM") {
      return time24;
    }
    DateTime time = DateFormat('HH:mm').parse(time24);

    String time12 = DateFormat('h:mm a').format(time);

    return time12;
  }

  getTotalEarnings() {
    _totalEarnings = 0;
    for (var element in _bookingDataList) {
      if (element.refund != "processed") {
        _totalEarnings += element.price ?? 0;
        notifyListeners();
      }
    }
  }

  bool isBookingExpired(BookingDataModel bookedVenue) {
    final formatedDate = DateFormat('d,MMM,y').parse(bookedVenue.slotDate!);
    final parsedTimeOnly =
        DateFormat('HH:mm').parse(bookedVenue.slotTime!.split("-").first);

    final parsedDateTime = DateTime(
      formatedDate.year,
      formatedDate.month,
      formatedDate.day,
      parsedTimeOnly.hour,
      parsedTimeOnly.minute,
    );

    if (parsedDateTime.isBefore(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    final sharedpref = await SharedPreferences.getInstance();
    final accessToken = sharedpref.getString(GlobalKeys.accesToken);
    return accessToken;
  }
}
