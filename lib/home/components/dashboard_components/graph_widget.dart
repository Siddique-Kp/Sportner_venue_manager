import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/textstyles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BookingPieChart extends StatelessWidget {
  final List<BookingData> bookingData = [];
  final int onlineEarning;
  final int offlineEarning;

  BookingPieChart({
    super.key,
    required this.onlineEarning,
    required this.offlineEarning,
  }) {
    double amount1 = onlineEarning.toDouble();
    double amount2 = offlineEarning.toDouble();
    double totalAmount = amount1 + amount2;
    double onlinePercent = ((amount1 / totalAmount) * 100).floorToDouble();
    double offlinePercent = ((amount2 / totalAmount) * 100).floorToDouble();

    // Add booking data to the list
    bookingData.add(BookingData('Online Booking', onlinePercent, Colors.green));
    bookingData
        .add(BookingData('Offline Booking', offlinePercent, Colors.blue));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 10,
                  ),
                  AppSizes.kWidth5,
                  Text(
                    "Online bookings",
                    style: AppTextStyles.textH4,
                  )
                ],
              ),
              AppSizes.kHeight10,
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 10,
                  ),
                  AppSizes.kWidth5,
                  Text(
                    "Offline bookings",
                    style: AppTextStyles.textH4,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 230.h,
            width: 230.w,
            child: SfCircularChart(
              series: <CircularSeries>[
                PieSeries<BookingData, String>(
                  dataSource: bookingData,
                  pointColorMapper: (BookingData data, _) => data.color,
                  xValueMapper: (BookingData data, _) => data.category,
                  yValueMapper: (BookingData data, _) => data.percentage,
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(fontWeight: FontWeight.w600),
                    labelPosition: ChartDataLabelPosition.inside,
                  ),
                  enableTooltip: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingData {
  final String category;
  final double percentage;
  final Color color;

  BookingData(
    this.category,
    this.percentage,
    this.color,
  );

  String get formattedPercentage => percentage.toStringAsFixed(1);
}
