import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/model/vm_venue_data_model.dart';

import '../../../utils/global_colors.dart';
import '../../view_model/create_venue_view_model.dart';

class TimeSlotByDays {
  static List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  static List<String> timeSlotList = [
    "00:00-01:00",
    "01:00-02:00",
    "02:00-03:00",
    "03:00-04:00",
    "04:00-05:00",
    "05:00-06:00",
    "06:00-07:00",
    "07:00-08:00",
    "08:00-09:00",
    "09:00-10:00",
    "10:00-11:00",
    "11:00-12:00",
    "12:00-13:00",
    "13:00-14:00",
    "14:00-15:00",
    "15:00-16:00",
    "16:00-17:00",
    "17:00-18:00",
    "18:00-19:00",
    "19:00-20:00",
    "20:00-21:00",
    "21:00-22:00",
    "22:00-23:00",
    "23:00-00:00",
  ];

//  static List<Slot> slots = [
//     {"day": "Sunday", "slots": []},
//     {"day": "Monday", "slots": []},
//     {"day": "Tuesday", "slots": []},
//     {"day": "Wednesday", "slots": []},
//     {"day": "Thursday", "slots": []},
//     {"day": "Friday", "slots": []},
//     {"day": "Saturday", "slots": []},
//   ];

  static timeSlotBottomSheet(BuildContext context, String days, int dayIndex) {
    return showModalBottomSheet(
      shape: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 500,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 45,
            ),
            itemCount: 24,
            itemBuilder: (BuildContext context, int index) {
              final checkBoxValue = context
                  .watch<CreateVenueViewModel>()
                  .dayCheckboxValues[days]![index];
              return CheckboxListTile(
                title: Text(TimeSlotByDays.timeSlotList[index]),
                value: checkBoxValue,
                onChanged: (value) {
                  context
                      .read<CreateVenueViewModel>()
                      .setSelectedTime(value!, days, index);
                  context.read<CreateVenueViewModel>().setTimeSlot(
                        TimeSlotByDays.timeSlotList[index],
                        value,
                        days,
                        dayIndex,
                      );
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          ),
        );
      },
    );
  }
}
