import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/vendor_registration/components/otp_textfield.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/firebase_auth_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/textstyles.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/sign_up_view_model.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  static String verify = "";

  @override
  Widget build(BuildContext context) {
    final otpValue = Provider.of<FirebaseAuthViewModel>(context).otpValue;
    final mobileNumber = Provider.of<SignUpViewModel>(context).phoneController;
    final signUpViewModel = context.watch<SignUpViewModel>();
    final firebaseViewModel = context.watch<FirebaseAuthViewModel>();
    final splitOtp = otpValue.split('');
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<FirebaseAuthViewModel>(context, listen: false).clearOTP();
          return true;
        },
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SafeArea(
              child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MySize.kHeight30,
                    Text(
                      "OTP Verification",
                      style: MyTextStyles.loginHeadingStyle,
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 180,
                        child: Image.asset("assets/otp_pic.png"),
                      ),
                    ),
                    Text(
                      "Enter the verification code we just sent you\non mobile +91${mobileNumber.text}",
                      style: const TextStyle(
                        color: MyColors.klightBlackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    MySize.kHeight30,
                    const OtpTextfieldWidget(),
                    MySize.kHeight30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "Resend code",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: MyColors.kButtonColor,
                          ),
                        )
                      ],
                    ),
                    MySize.kHeight40,
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: splitOtp.length != 6
                            ? null
                            : () {
                                context
                                    .read<FirebaseAuthViewModel>()
                                    .firbaseAuthenticationWithOTP(context);
                              },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                        ),
                        child: firebaseViewModel.isLoadingOtp
                            ? const CircularProgressIndicator(
                                color: MyColors.kWhiteColor,
                                strokeWidth: 2,
                              )
                            : const Text(
                                "Verify",
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
