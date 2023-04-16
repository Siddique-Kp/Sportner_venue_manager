import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view/dashboard_view.dart';
import 'package:sportner_venue_manager/home/view/venues_list_view.dart';

import '../../utils/global_colors.dart';
import '../view_model/bottom_navbar_view_model.dart';
import 'home_view.dart';


class BottomBarView extends StatelessWidget {
  BottomBarView({super.key});

  final List views = [
    const HomeScreenView(),
    const VenuesListView(),
    const DashBoardView(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    final bottomBarVieModel = Provider.of<BottomNavViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: views[bottomBarVieModel.bottomBarIndex],
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: bottomBarVieModel.bottomOnChanged,
        currentIndex: bottomBarVieModel.bottomBarIndex,
        iconSize: 24,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        backgroundColor: AppColors.white,
        elevation: 5,
        selectedItemColor: AppColors.appColor,
        unselectedItemColor: AppColors.grey,
        items: const [
          BottomNavigationBarItem(
            label: "Bookings",
            icon: Icon(
              Icons.home_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: "Venue",
            icon: Icon(
              CupertinoIcons.sportscourt,
            ),
          ),
          BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(
              Icons.donut_small_sharp,
            ),
          ),
        ],
      ),
    );
  }
}
