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
import '../../utils/navigations.dart';
import '../model/firebase_exeptions.dart';
import '../view/otp_page_view.dart';

class FirebaseAuthViewModel with ChangeNotifier {
  final googleSigin = GoogleSignIn();
  GoogleSignInAccount? _user;
  bool _isLoadingOtp = false;
  String otpValue = '';

  bool get isLoadingOtp => _isLoadingOtp;
  GoogleSignInAccount get user => _user!;

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
      navigator.pushReplacementNamed(NavigatorClass.homeScreen);
      final sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(GlobalKeys.vendorLoggedWithGoogle, true);
    } on PlatformException catch (e) {
      log(e.code);
      SnackBarWidget.snackBar(context, "No internet connection");
    } on FirebaseAuthException catch (e) {
      FirebaseExpeptions.cases(e, context);
    }
    notifyListeners();
  }

  firebaseGoogleLogout() async {
    await googleSigin.disconnect();
    FirebaseAuth.instance.signOut();
  }

  setOtpLoading(bool loadingOtp) {
    _isLoadingOtp = loadingOtp;
    notifyListeners();
  }

  fireBasePhoneAuth(BuildContext context) async {
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

        OtpVerificationPage.verify = verificationId;
        Navigator.pushNamed(context, NavigatorClass.otpScreen);
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
        verificationId: OtpVerificationPage.verify,
        smsCode: otpValue,
      );
      await auth.signInWithCredential(credential);
      await signUpViewModel.getSignUpStatus(context);
      setOtpLoading(false);
    } on SocketException {
      log("No internet");
      SnackBarWidget.snackBar(context, "No internet connection");
    } on PlatformException {
      SnackBarWidget.snackBar(context, "No internet connection");
    } on FirebaseAuthException catch (error) {
      FirebaseExpeptions.cases(error, context);
    }
    setOtpLoading(false);
  }

  // ----------- user Login status

  userLoginStatus(context) async {
    final navigator = Navigator.of(context);
    final sharedPrefer = await SharedPreferences.getInstance();
    final googleSigup = sharedPrefer.getBool(GlobalKeys.vendorLoggedWithGoogle);
    final vendorLoggedin = sharedPrefer.getBool(GlobalKeys.vendorLoggedIN);
    final vendorSignedUp = sharedPrefer.getBool(GlobalKeys.vendorSignedUp);
    if (googleSigup == true) {
      sharedPrefer.remove(GlobalKeys.vendorLoggedWithGoogle);
      await firebaseGoogleLogout();
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    } else if (vendorLoggedin == true) {
      sharedPrefer.remove(GlobalKeys.vendorLoggedIN);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    } else if (vendorSignedUp == true) {
      sharedPrefer.remove(GlobalKeys.vendorSignedUp);
      sharedPrefer.remove(GlobalKeys.accesToken);
      navigator.pushNamedAndRemoveUntil(
          NavigatorClass.loginScreen, (route) => false);
    }
  }
}
