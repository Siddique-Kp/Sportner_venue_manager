import 'dart:developer';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/home/model/sports_data_model.dart';
import 'package:sportner_venue_manager/repo/api_services.dart';
import 'package:sportner_venue_manager/repo/api_status.dart';
import 'package:sportner_venue_manager/utils/constants.dart';
import 'package:sportner_venue_manager/utils/keys.dart';
import '../../vendor_registration/components/snackbar.dart';

class CreateVenueViewModel with ChangeNotifier {
  final venueNameCntrllr = TextEditingController();
  final venueMobileCntrllr = TextEditingController();
  final venueAddressCntrllr = TextEditingController();
  final venueDescriptionCntrllr = TextEditingController();
  final venuePriceCntrllr = TextEditingController();
  final venueDiscountCntrllr = TextEditingController();
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "379449483728479",
    apiSecret: "P84yD201T01-JblVWczdP-1GB_Q",
    cloudName: "dkd1urq1v",
  );

  SportsDataModel? _sportsData;
  bool _isLoading = false;
  File? _venueDocument;
  File? _venueImage;

  SportsDataModel? get sportsData => _sportsData;
  bool get isLoading => _isLoading;
  File? get venueDocument => _venueDocument;
  File? get venueImage => _venueImage;

//---------- get sports data
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
    _isLoading = loading;
  }

  Future<String?> getAccessToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    final accessToken = sharedPref.getString(GlobalKeys.accesToken);

    return accessToken;
  }

  // ---- Pick image from gallery

  documentPicker(context) async {
    _venueDocument = await imagePicker(context);
    cloudinaryImage(_venueDocument!);
  }

  venueImagePicker(context) async {
    _venueImage = await imagePicker(context);
    cloudinaryImage(_venueImage!);
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
        progressCallback: (count, total) {
          print('Uploading image from file with progress: $count/$total');
        });
    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
      return response.secureUrl;
    }
  }
}
