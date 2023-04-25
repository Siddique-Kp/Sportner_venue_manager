import 'package:flutter/material.dart';

import '../../../utils/global_colors.dart';

class WeeksByDay {
  final String weekName;
  final GestureTapCallback? onTap;

  WeeksByDay({
    required this.weekName,
    required this.onTap,
  });

  static List<WeeksByDay> days = [
    WeeksByDay(
      weekName: "Sunday",
      onTap: () {},
    ),
    WeeksByDay(
      weekName: "Monday",
      onTap: () {},
    ),
    WeeksByDay(
      weekName: "Thuesday",
      onTap: () {},
    ),
    WeeksByDay(
      weekName: "Wednesday",
      onTap: () {},
    ),
    WeeksByDay(
      weekName: "Thursday",
      onTap: () {},
    ),
    WeeksByDay(
      weekName: "Friday",
      onTap: () {},
    ),
    WeeksByDay(
      weekName: "Saturday",
      onTap: () {},
    ),
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

  static timeSlotBottomSheet(BuildContext context) {
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
              return CheckboxListTile(
                title:  Text(WeeksByDay.timeSlotList[index]),
                value: false,
                onChanged: (newValue) {},
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          ),
        );
      },
    );
  }
}
