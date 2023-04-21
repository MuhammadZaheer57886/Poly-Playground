import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String titleText;
  final String imageAddress;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscuretext;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final double? width;
  final double? radius;
  final bool isDark;

  final double? height;
  final double? pl;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.imageAddress = '',
    required this.titleText,
    this.errorText,
    this.validator,
    this.obscuretext = false,
    this.autovalidateMode,
    this.width,
    this.radius,
    this.isDark = true,
    this.height,
    this.pl,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.only(left: pl ?? 10, top: 4),
          width: width ?? size.width * 0.8,
          height: height ?? 50,
          decoration: BoxDecoration(
            color: AppColors.i.whiteColor,
            // borderRadius: BorderRadius.circular(40),
            borderRadius: BorderRadius.circular(radius ?? 40),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            autovalidateMode: autovalidateMode,
            obscureText: obscuretext,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: titleText,
              hintStyle: TextStyle(
                  color: isDark ? const Color.fromARGB(255, 11, 7, 7) : null,
                  fontWeight: FontWeight.w700),
              prefixIcon: imageAddress != ''
                  ? Image.asset(
                      imageAddress,
                      color: Colors.black,
                    )
                  : null,
            ),
          ),
        ),
        if (errorText != null)
          Text(
            errorText!,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
      ],
    );
  }
}
