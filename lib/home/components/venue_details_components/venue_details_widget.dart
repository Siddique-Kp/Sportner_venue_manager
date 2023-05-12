import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/view_model/home_view_model.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../model/vm_venue_data_model.dart';


class VenueDetailsBody extends StatelessWidget {
  final int index;
  const VenueDetailsBody({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final venueDataList = context.watch<HomeViewModel>().vmVenueDataList;
    final venueData = venueDataList[index];
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizes.kHeight10,
        _venueImageContainer(size, venueData),
        AppSizes.kHeight10,
        _venueInfoWidget(venueData),
        AppSizes.kHeight5,
        _venuePlace(venueData),
        AppSizes.kHeight10,
        _venueDiscription(venueData),
        AppSizes.kHeight20,
        _venueSlotsWidget(venueData),
        AppSizes.kHeight20,
      ],
    );
  }

  

  Column _venueSlotsWidget(VmVenueDataModel venueData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Slots",
          style: AppTextStyles.textH4,
        ),
        const Divider(thickness: 1),
        GridView.builder(
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          shrinkWrap: true,
          itemCount: venueData.slots!.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                _showSlotsBottomSheet(context, venueData.slots![index]);
              },
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: AppColors.lightgrey,
                ),
                child: Center(
                  child: Text(
                    venueData.slots![index].day!.toUpperCase(),
                    style: AppTextStyles.textH5,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _venueDiscription(VmVenueDataModel venueData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: AppTextStyles.textH4,
        ),
        const Divider(thickness: 1),
        Text(
          venueData.description!,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        AppSizes.kHeight5,
        Row(
          children: [
            const Icon(Icons.phone, size: 17),
            AppSizes.kWidth5,
            Text(
              venueData.mobile.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            )
          ],
        )
      ],
    );
  }

  Row _venuePlace(VmVenueDataModel venueData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on,
          size: 17,
          color: AppColors.grey,
        ),
        Text(
          "${venueData.place},${venueData.district}",
          style: AppTextStyles.textH4grey,
        ),
      ],
    );
  }

  Row _venueInfoWidget(VmVenueDataModel venueData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          venueData.venueName!,
          style: AppTextStyles.textH2,
        ),
        Column(
          children: [
            Text("Price: ₹${venueData.actualPrice}",
                style: const TextStyle(
                  color: AppColors.appColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                )),
            Text(
              "Discount : ${venueData.discountPercentage}%",
              style: const TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _venueImageContainer(Size size, VmVenueDataModel venueData) {
    return Container(
      height: size.height * 0.20,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          image: NetworkImage(venueData.image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _showSlotsBottomSheet(BuildContext context, Slot venueDataSlot) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(20),
          child: venueDataSlot.slots!.isEmpty
              ? Wrap(
                  children: [
                    Center(
                      child: Text(
                        "No Slots",
                        style: AppTextStyles.textH4,
                      ),
                    ),
                  ],
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3,
                  ),
                  shrinkWrap: true,
                  itemCount: venueDataSlot.slots!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColors.lightgrey,
                      ),
                      child: Center(
                        child: Text(venueDataSlot.slots![index]),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
