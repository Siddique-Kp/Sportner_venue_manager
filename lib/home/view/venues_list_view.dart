import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/home/components/venues_list_components/vendor_turf_cartd.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/routes/navigations.dart';

class VenuesListView extends StatelessWidget {
  const VenuesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(79, 214, 214, 214),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your Venues"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: const [
            AppSizes.kHeight20,
            VendorTurfCard(),
            SizedBox(height: 70)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppScreens.createVenuefrstScreen);
        },
        backgroundColor: AppColors.appColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
