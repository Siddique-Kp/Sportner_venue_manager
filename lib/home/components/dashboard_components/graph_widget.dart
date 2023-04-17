import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/textstyles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BookingPieChart extends StatelessWidget {
  final List<BookingData> bookingData = [
    BookingData('Online Booking', 60, Colors.green),
    BookingData('Offline Booking', 40, Colors.blue),
  ];

  BookingPieChart({super.key});

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
            height: 230,
            width: 230,
            child: SfCircularChart(
              
              series: <CircularSeries>[
                // Render pie chart
          
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
                  // Enable tooltip
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
}
