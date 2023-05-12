import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/booking_view_model.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class EarningDashboard extends StatelessWidget {
  const EarningDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bookingViewModel = context.watch<BookingViewModel>();
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 70,
                width: 190,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Online Earnings",
                        style: AppTextStyles.textH4grey,
                      ),
                      Text(
                        "₹ ${bookingViewModel.onlineEarnings}.0",
                        style: AppTextStyles.textH3,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 190,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Offline Earnings",
                        style: AppTextStyles.textH4grey,
                      ),
                      Text(
                        "₹ ${bookingViewModel.offlineEarnings}.0",
                        style: AppTextStyles.textH3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150,
            width: 130,
            decoration: BoxDecoration(
                color: AppColors.white, borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_balance_wallet,
                    size: 35,
                    color: Colors.green,
                  ),
                  AppSizes.kHeight30,
                  Text("Total Earnings", style: AppTextStyles.textH4grey),
                  AppSizes.kHeight10,
                  Text("₹ ${bookingViewModel.totalEarnings}.0", style: AppTextStyles.textH3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
