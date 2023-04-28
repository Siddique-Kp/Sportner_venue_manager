import 'dart:developer';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/home/model/create_venue_model.dart';
import 'package:sportner_venue_manager/home/model/sports_data_model.dart';
import 'package:sportner_venue_manager/repo/api_services.dart';
import 'package:sportner_venue_manager/repo/api_status.dart';
import 'package:sportner_venue_manager/utils/constants.dart';
import 'package:sportner_venue_manager/utils/keys.dart';
import '../../vendor_registration/components/snackbar.dart';

class CreateVenueViewModel with ChangeNotifier {
  CreateVenueViewModel() {
    getCurrentLocation();
  }

  final venueNameCntrllr = TextEditingController();
  final venueMobileCntrllr = TextEditingController();
  final venueAddressCntrllr = TextEditingController();
  final venueDescriptionCntrllr = TextEditingController();
  final venuePriceCntrllr = TextEditingController();
  final venueDiscountCntrllr = TextEditingController();
  String _districtName = 'Select District';
  LocationData? currentLocation;
  LatLng? selectedLocation;

  SportsDataModel? _sportsData;
  bool _isLoadingSport = false;
  final List<bool> _checkBoxValue = List.filled(24, false);
  File? _venueDocument;
  String? venueDocClodinary;
  File? _venueImage;
  String? venueImageCloudinary;
  final List<int> _selectedSportIndex = [];
  final List<SportFacility> _selectedFacility = [];
  FacilityDetail? _facility;
  FacilityDetail? _defaultFacility;

  String get districtName => _districtName;
  SportsDataModel? get sportsData => _sportsData;
  bool get isLoadingSport => _isLoadingSport;
  List<bool> get checkBoxValue => _checkBoxValue;
  File? get venueDocument => _venueDocument;
  File? get venueImage => _venueImage;
  List<int> get selectedSportIndex => _selectedSportIndex;
  List<SportFacility> get selectedFacility => _selectedFacility;
  FacilityDetail? get facility => _facility;
  FacilityDetail? get defaultFacility => _defaultFacility;

  getDistrict(String district) {
    _districtName = district;
    notifyListeners();
  }

  /// GET AVAILABLE SPORTS DATA FROM SERVER

  getAllSports() async {
    _setLoading(true);

    final accessToken = await getAccessToken();

    final response = await ApiServices.getMethod(
        url: Urls.kGetAllSports,
        headers: {"Authorization": accessToken!},
        jsonDecod: sportsDataModelFromJson);

    if (response is Success) {
      log(response.response.toString());
      setAllSports(response.response as SportsDataModel);
    }
    if (response is Failure) {
      log("FAiled");
    }
  }

  setAllSports(SportsDataModel allSports) {
    _sportsData = allSports;
    notifyListeners();
  }

  _setLoading(bool loading) {
    _isLoadingSport = loading;
  }

  Future<String?> getAccessToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    final accessToken = sharedPref.getString(GlobalKeys.accesToken);
    return accessToken;
  }

  setSelectSport(int index, SportsDataModel? allSports, FacilityDetail defaultFacility) {
    if (!_selectedSportIndex.contains(index)) {
      _selectedSportIndex.add(index);
      if (!_selectedFacility
          .any((sf) => sf.sportId == allSports!.response![index].id)) {
        _selectedFacility.add(SportFacility(
          sport: allSports!.response![index].sport,
          sportId: allSports.response![index].id,
          facility: defaultFacility.facility
        ));
      }
    } else {
      _selectedSportIndex.remove(index);
      final facilityToRemove = _selectedFacility.firstWhere(
        (sf) => sf.sportId == allSports!.response![index].id,
      );

      _selectedFacility.remove(facilityToRemove);
    }
    notifyListeners();
  }

  setDefaultFacility(FacilityDetail defaultFacility) {
    _facility = defaultFacility;
    notifyListeners();
  }

  setSelectedFacility(FacilityDetail facility, String sportId) {
    _facility = facility;
    if (_selectedFacility.any((sf) => sf.sportId == sportId)) {
      final index =
          _selectedFacility.indexWhere((sportF) => sportF.sportId == sportId);
      _selectedFacility[index].facility = facility.facility;
    }
    notifyListeners();
  }


  ///  PICK THE IMAGES OF TURF AND SEND TO CLOUDINARY

  final cloudinary = Cloudinary.signedConfig(
    apiKey: "379449483728479",
    apiSecret: "P84yD201T01-JblVWczdP-1GB_Q",
    cloudName: "dkd1urq1v",
  );

  documentPicker(context) async {
    _venueDocument = await imagePicker(context);
    if (_venueDocument != null) {
      venueDocClodinary = cloudinaryImage(_venueDocument!);
    }
  }

  venueImagePicker(context) async {
    _venueImage = await imagePicker(context);
    if (_venueImage != null) {
      venueImageCloudinary = cloudinaryImage(_venueImage!);
    }
  }

  Future<File?> imagePicker(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }

      final pickedImage = File(image.path);
      // _venueDocument = pickedImage;
      notifyListeners();
      return pickedImage;
    } on PlatformException {
      return SnackBarWidget.snackBar(context, "Something went wrong");
    }
  }

  cloudinaryImage(File file) async {
    final response = await cloudinary.upload(
      file: file.path,
      fileBytes: file.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
    );
    if (response.isSuccessful) {
      return response.secureUrl;
    }
  }

  /// GET MAP LONGITUDE AND LATITUDE

  getCurrentLocation() async {
    Location location = Location();

    await location.getLocation().then((location) {
      currentLocation = location;
      notifyListeners();
    });
  }

  getSelectedLocation(LatLng? location) {
    selectedLocation = location;
    notifyListeners();
  }

  /// SET SELECTED TIME SLOT

  Map<String, List<bool>> dayCheckboxValues = {
    'Sunday': List.filled(24, false),
    'Monday': List.filled(24, false),
    'Tuesday': List.filled(24, false),
    'Wednesday': List.filled(24, false),
    'Thursday': List.filled(24, false),
    'Friday': List.filled(24, false),
    'Saturday': List.filled(24, false),
  };

  List<Slot> allSlotsOfDay = [
    Slot(day: "Sunday", slots: []),
    Slot(day: "Monday", slots: []),
    Slot(day: "Tuesday", slots: []),
    Slot(day: "Wednesday", slots: []),
    Slot(day: "Thursday", slots: []),
    Slot(day: "Friday", slots: []),
    Slot(day: "Saturday", slots: [])
  ];

  setSelectedTime(bool checkBoxValue, String days, int index) {
    dayCheckboxValues[days]?[index] = checkBoxValue;
    notifyListeners();
  }

  setTimeSlot(
    String selectedSlot,
    bool checkBoxValue,
    String day,
    int dayIndex,
  ) {
    if (!checkBoxValue) {
      if (allSlotsOfDay[dayIndex].slots!.contains(selectedSlot)) {
        allSlotsOfDay[dayIndex].slots!.remove(selectedSlot);
      }
    } else {
      if (!allSlotsOfDay[dayIndex].slots!.contains(selectedSlot)) {
        allSlotsOfDay[dayIndex].slots!.add(selectedSlot);
      }
    }
  }


  /// PASSING ALL THE DATA TO THE SERVER

  createVenueBody() {
    final createVenueBody = CreateVenueModel(
      venueName: venueNameCntrllr.text.trim(),
      mobile: int.parse(venueMobileCntrllr.text.trim()),
      place: venueAddressCntrllr.text.trim(),
      district: _districtName,
      description: venueDescriptionCntrllr.text.trim(),
      document: venueDocClodinary,
      actualPrice: int.parse(venuePriceCntrllr.text.trim()),
      discountPercentage: int.parse(venueDiscountCntrllr.text.trim()),
      image: venueImageCloudinary,
      sportFacility:_selectedFacility ,
      lat:selectedLocation?.latitude ?? currentLocation?.latitude,
      lng: selectedLocation?.longitude ?? currentLocation?.longitude,
      slots: allSlotsOfDay,
    );

    return createVenueBody.toJson();
  }



  createVenueApiService(){
    
  }
}
