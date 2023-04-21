
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import '../common/nav_function.dart';
import '../common/pop_message.dart';
import '../ui/authentication/phone/phone_verification.dart';

class PhoneUtils{


static void onContinuePressed(BuildContext context, String phoneNumber) async {
  // Initialize Twilio
TwilioFlutter twilioFlutter = TwilioFlutter(
  accountSid: 'ACbfb7848e63772d5dda4d1579b2a0a655',
  authToken: '8ddffe241449cea80476d1252ed0dacb',
  twilioNumber: '+1 620 536 0691',
);
  bool isValidPhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\+?[1-9]\d{1,14}$');
  return regex.hasMatch(phoneNumber);
}
String generateVerificationCode() {
  // Generate a random 6-digit verification code
  var random = Random();
  return (100000 + random.nextInt(900000)).toString();
}
  // Check if the phone number is valid
  if (isValidPhoneNumber(phoneNumber)) {
    try {
      // Generate a verification code
      String verificationCode = generateVerificationCode();
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
    showFailedToast(context, "Invalid phone number.ie. +[country code][number]");
  }
}

}