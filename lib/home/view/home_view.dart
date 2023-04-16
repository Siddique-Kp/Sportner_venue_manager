import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/bookings_components/online_booking_widget.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/firebase_auth_view_model.dart';

import '../components/bookings_components/offline_booking_widget.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bookings"),
          actions: [
            IconButton(
                onPressed: () async {
                  context
                      .read<FirebaseAuthViewModel>()
                      .vendorLoginStatus(context);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children:const [
               OnlineBookingWidget(),
              AppSizes.kHeight30,
               OfflineBookingWidget(),
            ],
          ),
        ));
  }
}




