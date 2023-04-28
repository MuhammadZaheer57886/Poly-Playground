import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class SimpleButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color? color;



  const SimpleButton({Key? key, required this.title, required this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.12, vertical: 17),
        decoration: BoxDecoration(
          color: color ?? AppColors.i.darkBrownColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.i.whiteColor,
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
