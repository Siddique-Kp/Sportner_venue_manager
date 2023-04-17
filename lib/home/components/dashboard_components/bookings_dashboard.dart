import 'package:flutter/material.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class BookingDashboard extends StatelessWidget {
  const BookingDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                    Icons.leaderboard_outlined,
                    size: 35,
                    color: Colors.blue,
                  ),
                  AppSizes.kHeight30,
                  Text("Total Bookings", style: AppTextStyles.textH4grey),
                  AppSizes.kHeight10,
                  Text("0 Bookings", style: AppTextStyles.textH3),
                ],
              ),
            ),
          ),
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
                        "Online Bookings",
                        style: AppTextStyles.textH4grey,
                      ),
                      Text(
                        "0 Bookings",
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
                        "Offline Bookings",
                        style: AppTextStyles.textH4grey,
                      ),
                      Text(
                        "0 Bookings",
                        style: AppTextStyles.textH3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}