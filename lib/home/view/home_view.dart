import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/venues_list_components/shimmer_card.dart';
import 'package:sportner_venue_manager/home/components/venues_list_components/vendor_turf_cartd.dart';
import 'package:sportner_venue_manager/home/view_model/home_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/routes/navigations.dart';
import '../components/error_data_widget.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final vmVenueViewModel = context.watch<HomeViewModel>();
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
      body: vmVenueViewModel.errorResponseModel?.code == 404
          ? const NoInternetWidget()
          : vmVenueViewModel.isLoading
              ? const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: ShimmerVenueCard(),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return context.read<HomeViewModel>().getVmVenueDatas();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: [
                        AppSizes.kHeight20,
                        VendorTurfCard(
                          vmVenueDataList: vmVenueViewModel.vmVenueDataList,
                        ),
                        const SizedBox(height: 70)
                      ],
                    ),
                  )),
      floatingActionButton: vmVenueViewModel.errorResponseModel?.code == 404
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppScreens.createVenuefrstScreen);
              },
              backgroundColor: AppColors.appColor,
              child: const Icon(Icons.add),
            ),
    );
  }
}
