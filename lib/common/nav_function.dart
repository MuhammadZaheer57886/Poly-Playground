import 'package:flutter/material.dart';

Future<dynamic> screenPush(BuildContext context, Widget widget) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}

Future<dynamic> screenPushRep(BuildContext context, Widget widget) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}
Future<dynamic> screenPushBackUntil(BuildContext context, Widget widget) {
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
          (route) => false);
}


