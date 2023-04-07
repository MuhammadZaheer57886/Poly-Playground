import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String titleText;
  final String imageAddress;
  final TextEditingController controller;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.imageAddress,
    required this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 10, top: 4),
        width: size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.i.whiteColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: titleText,
              hintStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700),
              prefixIcon: Image.asset(
                imageAddress,
                color: Colors.black,
              )),
        ));
  }
}
