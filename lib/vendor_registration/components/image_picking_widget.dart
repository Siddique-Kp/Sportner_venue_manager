import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/global_colors.dart';
import '../view_model/sign_up_view_model.dart';

class ImagePickingWidget extends StatelessWidget {
  const ImagePickingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signUpProvider = context.watch<SignUpViewModel>();
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        log("hi");
        context.read<SignUpViewModel>().imagePicker();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black12,
        ),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                width: size.width * 0.5,
                child: Text(
                  signUpProvider.image == null
                      ? "Add Gov. approve Document"
                      : signUpProvider.image!.path.split("/").last,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: MyColors.kButtonColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: MyColors.appMainGreenColor,
                ),
                width: 90,
                height: 30,
                child: const Center(
                    child: Text(
                  "Choose file",
                  style: TextStyle(
                    color: MyColors.kWhiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
