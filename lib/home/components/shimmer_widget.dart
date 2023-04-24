import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangle({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
  });
  const ShimmerWidget.circle({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey[400]!,
      highlightColor: AppColors.grey[300]!,
      child: Container(
        height: height,
        width: width,
        decoration: ShapeDecoration(
          color: AppColors.grey,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
