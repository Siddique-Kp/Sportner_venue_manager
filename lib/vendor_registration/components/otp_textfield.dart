import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/firebase_auth_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';

class OtpTextfieldWidget extends StatelessWidget {
  const OtpTextfieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      fieldWidth: 45,
      borderColor: MyColors.kButtonColor,
      focusedBorderColor: MyColors.kButtonColor,
      cursorColor: MyColors.klightBlackColor,
      onCodeChanged: (String code) {
        Provider.of<FirebaseAuthViewModel>(context, listen: false).setOtp(code);
      },
      onSubmit: (String verificationCode) {
        Provider.of<FirebaseAuthViewModel>(context, listen: false)
            .setOtp(verificationCode);
      },
    );
  }
}
