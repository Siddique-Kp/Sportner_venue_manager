import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/vendor_registration/model/login_error_model.dart';
import 'package:sportner_venue_manager/vendor_registration/repo/api_services.dart';
import 'package:sportner_venue_manager/utils/constants.dart';
import '../../utils/keys.dart';
import '../../utils/routes/navigations.dart';
import '../components/snackbar.dart';
import '../model/vendor_signup_model.dart';
import '../repo/api_status.dart';

class SignUpViewModel with ChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirfPassController = TextEditingController();

  bool _isShowPassword = true;
  bool _isShowConfPassword = true;
  bool _isLoading = false;
  SignUpError? _signUpError;
  VendorSignupModel? _vendorData;
  File? _image;

  bool get isShowPassword => _isShowPassword;
  bool get isShowConfPassword => _isShowConfPassword;
  bool get isLoading => _isLoading;
  VendorSignupModel get vendorData => _vendorData!;
  SignUpError get signUpError => _signUpError!;
  File? get image => _image;

  setshowPassword() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  setshowConfPassword() {
    _isShowConfPassword = !_isShowConfPassword;
    notifyListeners();
  }

  checkTextFieldisEmpty() {
    notifyListeners();
  }

  clearTextField() {
    userNameController.clear();
    phoneController.clear();
    passController.clear();
    confirfPassController.clear();
  }

  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  Future<VendorSignupModel?> setvendorData(VendorSignupModel vendorData) async {
    _vendorData = vendorData;
    return _vendorData;
  }

  setLoginError(SignUpError signUpError, context) async {
    _signUpError = signUpError;
    return errorResonses(_signUpError!, context);
  }

  getSignUpStatus(BuildContext context) async {
    final navigator = Navigator.of(context);
    setLoading(true);
    final response = await ApiServices.postMethod(
      Urls.kVENDORSIGNUP,
      vendorDatabody(),
      vendorSignupModelFromJson,
    );
    if (response is Success) {
      log("success");
      final data = await setvendorData(response.response as VendorSignupModel);
      final accessToken = data!.accessToken;
      clearTextField();
      setSignupStatus(accessToken!);
      navigator.pushNamedAndRemoveUntil(
          AppScreens.mainScreen, (route) => false);
    }
    if (response is Failure) {
      log("Failed");
      SignUpError loginError = SignUpError(
        code: response.code,
        message: response.errorResponse,
      );
      await setLoginError(loginError, context);
      clearPassword();
    }
    setLoading(false);
  }

  setSignupStatus(accessToken) async {
    final status = await SharedPreferences.getInstance();
    await status.setBool(GlobalKeys.vendorSignedUp, true);
    await status.setString(GlobalKeys.accesToken, accessToken);
  }

  clearPassword() {
    passController.clear();
    confirfPassController.clear();
  }

  Map<String, dynamic> vendorDatabody() {
    final body = VendorSignupModel(
      name: userNameController.text,
      mobile: phoneController.text,
      password: passController.text,
      image: _image!.uri.toString(),
    );
    return body.toJson();
  }

  errorResonses(SignUpError signUperror, BuildContext context) {
    final statusCode = signUperror.code;
    if (statusCode == 409) {
      return SnackBarWidget.snackBar(
          context, "vendor with this mobile number already exists");
    }
    return SnackBarWidget.snackBar(context, signUperror.message.toString());
  }

  // ---- Pick image from gallery
  Future imagePicker(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }

      final pickedImage = File(image.path);
      _image = pickedImage;
      notifyListeners();
      return _image;
    } on PlatformException {
      return SnackBarWidget.snackBar(context, "Something went wrong");
    }
  }
}
