import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportner_venue_manager/vendor_registration/components/snackbar.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/sign_up_view_model.dart';
import 'package:sportner_venue_manager/utils/keys.dart';
import '../../utils/routes/navigations.dart';
import '../model/firebase_exeptions.dart';

class FirebaseAuthViewModel with ChangeNotifier {
  final googleSigin = GoogleSignIn();
  GoogleSignInAccount? _user;
  bool _isLoadingOtp = false;
  String _verifyOTP = '';
  String otpValue = '';
  int? _otpResendToken;

  bool get isLoadingOtp => _isLoadingOtp;
  GoogleSignInAccount get user => _user!;
  String get verifyOTP => _verifyOTP;
  int get otpResendToken => _otpResendToken!;

  Future firebaseGoogleAuth(context) async {
    final navigator = Navigator.of(context);
    try {
      final googleUser = await googleSigin.signIn();

      if (googleUser == null) {
        return;
      }
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      navigator.pushReplacementNamed(AppScreens.mainScreen);
      final sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(GlobalKeys.vendorLoggedWithGoogle, true);
    } on PlatformException catch (e) {
      log(e.code);
      SnackBarWidget.snackBar(context, "No internet connection");
    } on FirebaseAuthException catch (e) {
      log("Google firebase error");
      FirebaseExpeptions.cases(e, context);
    }
    notifyListeners();
  }

  setOtpLoading(bool loadingOtp) {
    _isLoadingOtp = loadingOtp;
    notifyListeners();
  }

  fireBasePhoneAuth(BuildContext context) async {
    final signUpViewModel = context.read<SignUpViewModel>();
    if (signUpViewModel.image == null) {
      return SnackBarWidget.snackBar(context, "Please Choose Document");
    }
    setOtpLoading(true);
    String countryCode = "+91";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:
          countryCode + context.read<SignUpViewModel>().phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) {
        log("Credential");
      },
      verificationFailed: (FirebaseAuthException error) {
        log("Error");
        setOtpLoading(false);
        FirebaseExpeptions.cases(error, context);
      },
      codeSent: (String verificationId, int? resendToken) {
        log("code sent");
        _otpResendToken = resendToken;
        _verifyOTP = verificationId;
        Navigator.pushNamed(context, AppScreens.otpScreen);
        setOtpLoading(false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("time out");
      },
    );
    notifyListeners();
  }

  setOtp(String verificationCode) {
    otpValue = verificationCode;
    notifyListeners();
  }

  clearOTP() {
    otpValue = '';
    notifyListeners();
  }

  firbaseAuthenticationWithOTP(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final signUpViewModel = context.read<SignUpViewModel>();
    setOtpLoading(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verifyOTP,
        smsCode: otpValue,
      );
      await auth.signInWithCredential(credential);
      await signUpViewModel.getSignUpStatus(context);
      setOtpLoading(false);
    } on SocketException {
      log("No internet otp page");
      SnackBarWidget.snackBar(context, "No internet connection");
    } on PlatformException {
      SnackBarWidget.snackBar(context, "No internet connection");
    } on FirebaseAuthException catch (error) {
      log("Firebase error otp page");

      FirebaseExpeptions.cases(error, context);
    }
    setOtpLoading(false);
  }

  resentOTPtoPhone(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String countryCode = "+91";

    await auth.verifyPhoneNumber(
      phoneNumber:
          countryCode + context.read<SignUpViewModel>().phoneController.text,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        _verifyOTP = verificationId;
        _otpResendToken = forceResendingToken;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      forceResendingToken: _otpResendToken,
      timeout: const Duration(seconds: 60),
    );
  }

  // ----------- vendor Login status

  vendorLoginStatus(context) async {
    final navigator = Navigator.of(context);
    final sharedPrefer = await SharedPreferences.getInstance();
    final googleSigup = sharedPrefer.getBool(GlobalKeys.vendorLoggedWithGoogle);
    final vendorLoggedin = sharedPrefer.getBool(GlobalKeys.vendorLoggedIN);
    final vendorSignedUp = sharedPrefer.getBool(GlobalKeys.vendorSignedUp);
    if (googleSigup == true) {
      sharedPrefer.remove(GlobalKeys.vendorLoggedWithGoogle);
      await firebaseGoogleLogout();
      navigator.pushNamedAndRemoveUntil(
          AppScreens.loginScreen, (route) => false);
    } else if (vendorLoggedin == true) {
      sharedPrefer.remove(GlobalKeys.vendorLoggedIN);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          AppScreens.loginScreen, (route) => false);
    } else if (vendorSignedUp == true) {
      sharedPrefer.remove(GlobalKeys.vendorSignedUp);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          AppScreens.loginScreen, (route) => false);
    }
  }

  firebaseGoogleLogout() async {
    await googleSigin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
