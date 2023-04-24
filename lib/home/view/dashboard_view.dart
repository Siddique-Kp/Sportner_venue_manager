import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/textstyles.dart';
import '../../utils/global_colors.dart';
import '../components/dashboard_components/bookings_dashboard.dart';
import '../components/dashboard_components/earnings_dashboard.dart';
import '../components/dashboard_components/graph_widget.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.appColor,
              Color.fromARGB(202, 103, 211, 151),
              Color.fromARGB(255, 168, 214, 189),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizes.kHeight20,
                  Text(
                    "Dashboard",
                    style: AppTextStyles.textH1White,
                  ),
                  AppSizes.kHeight20,
                  const BookingDashboard(),
                  AppSizes.kHeight20,
                  const EarningDashboard(),
                  AppSizes.kHeight20,
                  BookingPieChart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
