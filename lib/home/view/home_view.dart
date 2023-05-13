import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/venues_list_components/shimmer_card.dart';
import 'package:sportner_venue_manager/home/components/venues_list_components/vendor_turf_cartd.dart';
import 'package:sportner_venue_manager/home/view/create_venue_view.dart';
import 'package:sportner_venue_manager/home/view_model/create_venue_view_model.dart';
import 'package:sportner_venue_manager/home/view_model/home_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/routes/navigations.dart';
import '../../vendor_registration/view_model/firebase_auth_view_model.dart';
import '../components/error_data_widget.dart';
import '../components/normal_alert_box.dart';
import '../view_model/bottom_navbar_view_model.dart';

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
        actions: [
          IconButton(
            color: AppColors.white,
            onPressed: () async {
              NormalAlertBox.alertBox(
                context: context,
                title: "Log out!",
                content: "Do you want to logout",
                onPressed: () {
                  context
                      .read<FirebaseAuthViewModel>()
                      .vendorLoginStatus(context);
                  context.read<BottomNavViewModel>().changeBottomNavindex(0);
                },
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: vmVenueViewModel.errorCode == 404
          ? const NoInternetWidget()
          : vmVenueViewModel.isLoading
              ? const VenueLoadingCard()
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
                  ),
                ),
      floatingActionButton: vmVenueViewModel.errorCode == 404
          ? null
          : FloatingActionButton(
              onPressed: () {
                context.read<CreateVenueViewModel>().clearAllDatas();
                Navigator.push(
                  context,
                  AppScreens.animatedRoute(
                    route: CreateVenueView(),
                    fade: false
                  ),
                );
              },
              backgroundColor: AppColors.appColor,
              child: const Icon(Icons.add),
            ),
    );
  }
}
