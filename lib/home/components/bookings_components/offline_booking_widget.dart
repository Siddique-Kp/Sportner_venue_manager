import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/home/components/bookings_components/booking_list_widget.dart';

import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class OfflineBookingWidget extends StatelessWidget {
  const OfflineBookingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Offline Bookings",
              style: AppTextStyles.textH2,
            ),
            TextButton(
              onPressed: () {},
              child: const Text("View all"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Name", style: AppTextStyles.textH4),
            Text("Price", style: AppTextStyles.textH4)
          ],
        ),
        const Divider(thickness: 1.5),
        AppSizes.kHeight5,
        const BookingListWidget()
      ],
    );
  }
}
