import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/home/components/glass_snack_bar.dart';
import 'package:sportner_venue_manager/home/components/warning_alert_box.dart';
import 'package:sportner_venue_manager/home/model/vm_venue_data_model.dart';
import 'package:sportner_venue_manager/home/view_model/create_venue_view_model.dart';
import 'package:sportner_venue_manager/home/view_model/home_view_model.dart';
import '../../../utils/global_colors.dart';
import '../../../utils/global_values.dart';
import '../../../utils/textstyles.dart';
import '../../view/create_venue_view.dart';
import '../../view/venue_details_view.dart';
import 'sports_icon.dart';

class VendorTurfCard extends StatelessWidget {
  final List<VmVenueDataModel> vmVenueDataList;
  const VendorTurfCard({
    super.key,
    required this.vmVenueDataList,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: vmVenueDataList.length,
      separatorBuilder: (context, index) => AppSizes.kHeight20,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VenueDetailsView(
                  index: index,
                ),
              ),
            );
          },
          child: SizedBox(
            height: size.height * 0.32,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Card(
                    child: SizedBox(
                      height: size.height * 0.265,
                      width: double.infinity,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      _imageContainer(size, index),
                      _venueDetails(index)
                    ],
                  ),
                ),
                _venueSportsFacility(size, index),
                _venueBlockButton(context, index),
                _editButton(context, index),
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned _editButton(BuildContext context, int index) {
    return Positioned(
      bottom: 0,
      right: 65,
      child: GestureDetector(
        onTap: () {
          context.read<CreateVenueViewModel>().setEditVenueValues(
                venueData: vmVenueDataList[index],
                isEditVenue: true,
              );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateVenueView(
                isEditVenue: true,
                index: index,
              ),
            ),
          );
        },
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(45),
          child: const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 225, 225, 225),
            child: Icon(
              Icons.edit,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }

  Positioned _venueBlockButton(BuildContext context, int index) {
    return Positioned(
      bottom: 0,
      right: 20,
      child: GestureDetector(
        onTap: () {
          AlertBoxWidget.alertBox(
            context: context,
            blockButton: () {
              context
                  .read<HomeViewModel>()
                  .getBlockVenue(vmVenueDataList[index].id!);
              Navigator.pop(context);
              GlassSnackBar.snackBar(
                context: context,
                title: vmVenueDataList[index].vmIsBlocked!
                    ? "Venue unblocked"
                    : "Venue blocked!",
                subtitle:
                    "Venue ${vmVenueDataList[index].vmIsBlocked! ? "Unblocked" : "Blocked"} successfully!",
              );
            },
            blockStatus: vmVenueDataList[index].vmIsBlocked!,
            title: "Venue",
            blockText:
                vmVenueDataList[index].vmIsBlocked! ? "Unblock" : "Block",
          );
        },
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(45),
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 225, 225, 225),
            child: Icon(
              Icons.block,
              color: vmVenueDataList[index].vmIsBlocked!
                  ? AppColors.green
                  : const Color.fromARGB(186, 255, 17, 0),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _venueSportsFacility(Size size, int venueindex) {
    return Positioned(
      bottom: 0,
      left: size.width * 0.075,
      child: SizedBox(
        height: 45,
        child: ListView.separated(
          itemCount: vmVenueDataList[venueindex].sportFacility!.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => AppSizes.kWidth5,
          itemBuilder: (context, sportindex) {
            return CircleAvatar(
              radius: 21,
              backgroundColor: const Color.fromARGB(99, 158, 158, 158),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                child: Icon(
                  Sports.spots(
                    sport: vmVenueDataList[venueindex]
                        .sportFacility![sportindex]
                        .sport!,
                  ),
                  color: AppColors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding _venueDetails(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          AppSizes.kHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(vmVenueDataList[index].venueName.toString(),
                  style: AppTextStyles.textH3),
              Text("₹${vmVenueDataList[index].actualPrice}",
                  style: AppTextStyles.textH3)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(vmVenueDataList[index].district.toString(),
                  style: AppTextStyles.textH4grey),
              Text("Onwards", style: AppTextStyles.textH4grey)
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageContainer(Size size, int index) {
    return Container(
      height: size.height * 0.18,
      width: size.width * 0.833,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 216, 216, 216),
        image: DecorationImage(
          image: NetworkImage(vmVenueDataList[index].image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
