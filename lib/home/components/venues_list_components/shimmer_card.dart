import 'package:flutter/material.dart';
import 'package:sportner_venue_manager/home/components/shimmer_widget.dart';
import '../../../utils/global_values.dart';

class ShimmerVenueCard extends StatelessWidget {
  const ShimmerVenueCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (context, index) => AppSizes.kHeight20,
      itemBuilder: (context, index) {
        return SizedBox(
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
            ],
          ),
        );
      },
    );
  }

  Positioned _venueSportsFacility(Size size, int index) {
    return Positioned(
      bottom: 0,
      left: size.width * 0.075,
      child: SizedBox(
        height: 45,
        child: ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => AppSizes.kWidth5,
          itemBuilder: (context, index) {
            return const CircleAvatar(
              radius: 21,
              backgroundColor: Color.fromARGB(99, 158, 158, 158),
              child: ShimmerWidget.circle(width: 40, height: 40),
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
            children: const [
              ShimmerWidget.rectangle(width: 100, height: 17),
              ShimmerWidget.rectangle(width: 50, height: 17)
            ],
          ),
          AppSizes.kHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerWidget.rectangle(width: 60, height: 17),
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
      child: ShimmerWidget.rectangle(
        width: size.width * 0.833,
        height: size.height * 0.18,
        shapeBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
