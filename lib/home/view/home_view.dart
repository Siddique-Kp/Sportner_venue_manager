import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/venues_list_components/vendor_turf_cartd.dart';
import 'package:sportner_venue_manager/home/model/vm_venue_data_model.dart';
import 'package:sportner_venue_manager/home/view_model/home_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/routes/navigations.dart';

import '../components/venues_list_components/shimmer_card.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(116, 214, 214, 214),
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
      body: FutureBuilder<List<VmVenueDataModel>?>(
        future: context.read<HomeViewModel>().getVmVenueDatas(),
        builder: (context, snapshot) {
          final vmVenueDataList =
              context.watch<HomeViewModel>().vmVenueDataList;
          if (snapshot.connectionState == ConnectionState.waiting) {
            log("connectionstate");
            return const Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ShimmerVenueCard(),
            ));
          }
          if (snapshot.data == null) {
            log("data null");
            return const Center(
              child: Text("We cannot find any venue"),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                AppSizes.kHeight20,
                VendorTurfCard(vmVenueDataList: vmVenueDataList),
                const SizedBox(height: 70)
              ],
            ),
          );
        },
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
