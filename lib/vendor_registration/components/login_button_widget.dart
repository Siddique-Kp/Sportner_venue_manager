import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/firebase_auth_view_model.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/login_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLogin = false,
  });

  final VoidCallback? onPressed;
  final String title;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final userLoginViewModel = context.watch<LoginViewModel>();
    final firebaseViewModel = context.watch<FirebaseAuthViewModel>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: const Color.fromARGB(255, 195, 195, 195),
        elevation: 0,
        backgroundColor: AppColors.kButtonColor,
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: userLoginViewModel.isLoading && isLogin ||
                  firebaseViewModel.isLoadingOtp && !isLogin
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.white,
                )
              : Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
        ),
      ),
    );
  }
}
