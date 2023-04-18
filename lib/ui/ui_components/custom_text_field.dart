import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String titleText;
  final String imageAddress;
  final TextEditingController controller;
  final String? errorText;
  final bool obscuretext;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.imageAddress,
    required this.titleText,
    this.errorText, 
    this.validator,
    this.obscuretext = false,
    this.autovalidateMode, 
    this.keyboardType, 
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 10, top: 4),
            width: size.width * 0.8,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.i.whiteColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: keyboardType,
              autovalidateMode: autovalidateMode,
              obscureText: obscuretext ,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: titleText,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 11, 7, 7), fontWeight: FontWeight.w700),
                  prefixIcon: Image.asset(
                    imageAddress,
                    color: Colors.black,
                  )),
            )),
            if (errorText != null)
              Text(
                errorText!,
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
              ),
      ],
    );
  }
}
