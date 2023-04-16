import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';

import '../../vendor_registration/view_model/firebase_auth_view_model.dart';

class AppbarWidget extends StatelessWidget {
  final String title;
  final bool isNormalAppbar;

  const AppbarWidget({
    super.key,
    required this.title,
     this.isNormalAppbar = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: false,
      leading: isNormalAppbar
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))
          : AppSizes.kHeight10,
      title: Text(title),
      actions: !isNormalAppbar?[
           IconButton(
              onPressed: () async {
                context.read<FirebaseAuthViewModel>().vendorLoginStatus(context);
              },
              icon: const Icon(Icons.logout))
      ]:null,
    );
  }
}
