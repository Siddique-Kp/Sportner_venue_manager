import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/textstyles.dart';
import 'separator.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) => AppSizes.kHeight10,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6)),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    _cardTopSide(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SeparatorWidget(),
                    ),
                    _cardBottomSide(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Expanded _cardBottomSide() {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.blueAccent,
                size: 20,
              ),
              Text(
                "Siddique",
                style: AppTextStyles.textH4,
              ),
            ],
          ),
          const Text(
            "₹1000",
            style: TextStyle(
              color: AppColors.appColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Expanded _cardTopSide() {
    return Expanded(
      flex: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _timeContainer(time: "05:30", status: "From"),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Icon(Icons.sports_soccer),
                  Text(
                    "5 v 5",
                    style: AppTextStyles.textH4,
                  ),
                ],
              ),
              Text(
                "13 Mar,2023",
                style: AppTextStyles.textH5,
              ),
            ],
          ),
          _timeContainer(status: "To", time: "06:30"),
        ],
      ),
    );
  }

  Column _timeContainer({required String time, required String status}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: AppTextStyles.textH1,
        ),
        Container(
          height: 20,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            color: const Color.fromARGB(184, 189, 189, 189),
          ),
          child: Center(
            child: Text(
              status,
              style: AppTextStyles.textH5,
            ),
          ),
        ),
      ],
    );
  }
}
