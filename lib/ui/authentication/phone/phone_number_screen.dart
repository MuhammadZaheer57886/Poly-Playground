import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/authentication/phone/phone_verification.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../../../common/pop_message.dart';
import '../../../utils/constants/app_colors.dart';
import '../../home/home_screen.dart';
import '../../ui_components/custom_text_field.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  // late TwilioFlutter twilioFlutter;
  // @override
  // void initState(String phoneNumber) {
  //   twilioFlutter = TwilioFlutter(
  //       accountSid: 'ACbfb7848e63772d5dda4d1579b2a0a655',
  //       authToken: '8ddffe241449cea80476d1252ed0dacb',
  //       twilioNumber: phoneNumber);
  //   super.initState();
  // }
  // void sendSms() async {
  //   twilioFlutter.sendSMS(
  //       toNumber: ' ************', messageBody: 'Hii everyone this is a demo of\nflutter twilio sms.');
  // }
  // void getSms() async {
  //   var data = await twilioFlutter.getSmsList();
  //   print(data);
  //   await twilioFlutter.getSMS('***************************');
  // }
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
                _onContinuePressed(context, phoneController.text);
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
// Initialize Twilio
TwilioFlutter twilioFlutter = TwilioFlutter(
  accountSid: 'ACbfb7848e63772d5dda4d1579b2a0a655',
  authToken: '8ddffe241449cea80476d1252ed0dacb',
  twilioNumber: '+92 308 5745875',
);

void _onContinuePressed(BuildContext context, String phoneNumber) async {
  // Check if the phone number is valid
  if (isValidPhoneNumber(phoneNumber)) {
    try {
      // Generate a verification code
      String verificationCode = _generateVerificationCode();
      // Navigate to phone verification screen and pass verification code
      screenPush(context, PhoneVerificationScreen(
            verificationId: verificationCode,
          ),
          );
      // Send SMS with verification code
      await twilioFlutter.sendSMS(
        toNumber: phoneNumber,
        messageBody: 'Your verification code is: $verificationCode',
      );
      
    } catch (e) {
      print("Error sending SMS with Twilio: $e");
      // Show an error message to the user for SMS sending failure
      showFailedToast(context, "Failed to send SMS for verification");
    }
  } else {
    // Show an error message to the user for invalid phone number
    showFailedToast(context, "Invalid phone number");
  }
}

bool isValidPhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\+?[1-9]\d{1,14}$');
  return regex.hasMatch(phoneNumber);
}

String _generateVerificationCode() {
  // Generate a random 6-digit verification code
  var random = Random();
  return (100000 + random.nextInt(900000)).toString();
}

}
