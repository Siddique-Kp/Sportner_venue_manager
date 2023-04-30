import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/vendor_registration/components/snackbar.dart';
import 'package:sportner_venue_manager/vendor_registration/model/login_error_model.dart';
import 'package:sportner_venue_manager/vendor_registration/model/vendor_login_model.dart';
import 'package:sportner_venue_manager/repo/api_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/repo/api_services.dart';
import 'package:sportner_venue_manager/utils/keys.dart';
import '../../utils/constants.dart';
import '../../utils/routes/navigations.dart';

class LoginViewModel with ChangeNotifier {
  TextEditingController loginPhoneCntrllr = TextEditingController();
  TextEditingController loginPasswordCntrllr = TextEditingController();

  bool _isShowPassword = true;
  bool _isLoading = false;
  VendorLoginModel? _vendorData;
  LoginError? _loginError;

  bool get isShowPassword => _isShowPassword;
  bool get isLoading => _isLoading;
  VendorLoginModel get vendorData => _vendorData!;
  LoginError get loginError => _loginError!;

  setShowPassword() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  Future<VendorLoginModel?> setvendorData(VendorLoginModel vendorData) async {
    _vendorData = vendorData;
    return _vendorData;
  }

  setLoginError(LoginError loginError, context) async {
    _loginError = loginError;
    return errorResonses(_loginError!, context);
  }

  getLoginStatus(BuildContext context) async {
    final navigator = Navigator.of(context);
    setLoading(true);
    final response = await ApiServices.postMethod(
      url: Urls.kVENDORSIGNIN,
      body: vendorDataBody(),
      function: vendorLoginModelFromJson,
    );

    if (response is Success) {
      final data = await setvendorData(response.response as VendorLoginModel);
      final accessToken = data!.accessToken;
      log(accessToken.toString());
      clearController();
      await setLoginStatus(accessToken!);
      navigator.pushNamedAndRemoveUntil(
          AppScreens.mainScreen, (route) => false);
    }

    if (response is Failure) {
      await setLoading(false);
      clearPassword();
      LoginError loginError = LoginError(
        code: response.code,
        message: response.errorResponse,
      );
      await setLoginError(loginError, context);
    }
    setLoading(false);
  }

  clearController() {
    loginPhoneCntrllr.clear();
    loginPasswordCntrllr.clear();
  }

  clearPassword() {
    loginPasswordCntrllr.clear();
  }

  setLoginStatus(String accessToken) async {
    final status = await SharedPreferences.getInstance();
    await status.setBool(GlobalKeys.vendorLoggedIN, true);
    await status.setString(GlobalKeys.accesToken, accessToken);
  }

  Map<String, dynamic> vendorDataBody() {
    final body = VendorLoginModel(
      mobile: loginPhoneCntrllr.text,
      password: loginPasswordCntrllr.text,
    );

    return body.toJson();
  }

  errorResonses(LoginError loginError, BuildContext context) {
    final statusCode = loginError.code;
    if (statusCode == 401) {
      return SnackBarWidget.snackBar(context, "Invalid username or password");
    }
    return SnackBarWidget.snackBar(context, loginError.message.toString());
  }
}
