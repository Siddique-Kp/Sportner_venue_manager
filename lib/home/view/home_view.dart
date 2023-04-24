import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/home/components/venues_list_components/vendor_turf_cartd.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/routes/navigations.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(116, 214, 214, 214),
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        centerTitle: true,
        elevation: 1,
        title: const Text(
          "Your Venues",
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
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
