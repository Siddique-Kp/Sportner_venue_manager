import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import '../components/create_venue_components/select_time_slot_components.dart';

class CreateVenueThirdView extends StatelessWidget {
  const CreateVenueThirdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new venue"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizes.kHeight20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select location"),
                    AppSizes.kHeight10,
                    Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.grey,
                    )
                  ],
                ),
                AppSizes.kHeight30,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select slot"),
                    AppSizes.kHeight20,
                    SizedBox(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 3,
                        ),
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              WeeksByDay.timeSlotBottomSheet(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.lightgrey,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(WeeksByDay.days[index].weekName),
                                    AppSizes.kWidth10,
                                    const Icon(Icons.expand_more),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 45,
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () {},
                      child: const Text("SUBMIT"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
