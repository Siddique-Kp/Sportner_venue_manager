import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/textstyles.dart';

class ErrorDataWidget extends StatelessWidget {
  const ErrorDataWidget({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    required this.text,
  });

  final String image;
  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * height,
            width: size.width * width,
            child: SvgPicture.asset(
              image,
              fit: BoxFit.contain,
              // ignore: deprecated_member_use
              color: const Color.fromARGB(99, 158, 158, 158),
            ),
          ),
          Text(
            text,
            style: AppTextStyles.textH4grey,
          )
        ],
      ),
    );
  }
}

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ErrorDataWidget(
      image: "assets/no_internet.svg",
      height: 0.07,
      width: 0.35,
      text: "No Internet connection",
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ErrorDataWidget(
      image: "assets/no_data.svg",
      height: 0.15,
      width: 0.45,
      text: "Could not find any data",
    );
  }
}
