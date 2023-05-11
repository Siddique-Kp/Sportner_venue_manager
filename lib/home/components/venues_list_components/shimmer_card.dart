import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportner_venue_manager/home/components/shimmer_widget.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import '../../../utils/global_values.dart';

class VenueLoadingCard extends StatelessWidget {
  const VenueLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          AppSizes.kHeight20,
          ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => AppSizes.kHeight20,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        _imageContainer(size, index),
                        _venueDetails(index)
                      ],
                    ),
                  ),
                  AppSizes.kHeight10,
                  Padding(
                    padding:  EdgeInsets.only(left: 30.sp),
                    child: _venueSportsFacility(size, index),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _venueSportsFacility(Size size, int index) {
    return Row(
      children: const [
        CircleAvatar(
          radius: 21,
          backgroundColor: AppColors.lightgrey,
        ),
        AppSizes.kWidth5,
        CircleAvatar(
          radius: 21,
          backgroundColor: AppColors.lightgrey,
        ),
      ],
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
              ShimmerWidget(width: 100.w, height: 15.h),
              ShimmerWidget(width: 50.w, height: 15.h)
            ],
          ),
          AppSizes.kHeight10,
          Row(
            children: [
              ShimmerWidget(width: 60.w, height: 15.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageContainer(Size size, int index) {
    return SizedBox(
      height: size.height * 0.18,
      width: size.width * 0.833,
      child: ShimmerWidget(
        width: size.width * 0.833,
        height: size.height * 0.18,
        radius: 6,
      ),
    );
  }
}
