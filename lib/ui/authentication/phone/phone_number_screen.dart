import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/authentication/phone/phone_verification.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../../../common/pop_message.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/phoneUtils.dart';
import '../../home/home_screen.dart';
import '../../ui_components/custom_text_field.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              AppColors.i.darkBrownColor,
              AppColors.i.darkBrownColor.withOpacity(0.4),
            ])),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
                alignment: Alignment.center,
                width: size.width,
                height: size.height * 0.21,
                child: Text(
                  "Connect by Phone Number",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w700),
                )),
            SizedBox(
              height: size.height * 0.12,
            ),
            CustomTextField(
                titleText: "PHONE NUMBER",
                keyboardType: TextInputType.phone,
                imageAddress: "assets/phone.png",
                controller: phoneController
                ),
            SizedBox(
              height: size.height * 0.04,
            ),
            InkWell(
              onTap: () {
                PhoneUtils.onContinuePressed(context, phoneController.text);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.12, vertical: 17),
                decoration: BoxDecoration(
                  color: AppColors.i.darkBrownColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  "CONTINUE",
                  style: TextStyle(
                    color: AppColors.i.whiteColor,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
