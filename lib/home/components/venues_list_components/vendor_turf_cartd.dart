import 'package:flutter/material.dart';

import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';

class VendorTurfCard extends StatelessWidget {
  const VendorTurfCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) => AppSizes.kHeight20,
        itemBuilder: (context, index) {
          return SizedBox(
            height: size.height*0.32,
            child: Stack(
              children: [
                 Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Card(
                    child: SizedBox(
                      height:size.height*0.265,
                      width: double.infinity,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: size.height*0.18,
                        width: size.width*0.833,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://essalar.in/wp-content/uploads/2020/01/sports_flooring_1.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            AppSizes.kHeight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Liverpool soccer",
                                    style: AppTextStyles.textH3),
                                Text("INR 1000", style: AppTextStyles.textH3)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Kozhikode", style: AppTextStyles.textH4),
                                Text("Onwards", style: AppTextStyles.textH4)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                 Positioned(
                  bottom: 0,
                  left: size.width*0.075,
                  child:const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 225, 225, 225),
                    child: Icon(
                      Icons.sports_soccer,
                      color: AppColors.black,
                    ),
                  ),
                ),
                 Positioned(
                  bottom: 0,
                  left: size.width*0.20,
                  child:const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 225, 225, 225),
                    child: Icon(
                      Icons.sports_cricket,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 225, 225, 225),
                    child: Icon(
                      Icons.edit,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
