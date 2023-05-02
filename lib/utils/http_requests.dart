import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../common/store.dart';

Future<void> snedNotification() async {
  final body = {
    "to": Store().friend!.token.toString(),
    "notification": {
      "title": "New Message",
      "body": "You got a new message from ${Store().userData.name}",
      "mutable_content": true,
      "sound": "Tri-tone"
    }
  };

  const String serverKey = "AAAA0tAQQ0E:APA91bHLglpArpGyG7Gr6wlD4XL905YPYhwplJU6aCyK25TEVHvMGOAe8PZxk2yktfajTuxW2jLeAR0n065UwlY5OIWbROPSpsRG1ak16Cuh5xIrRZoaJ3rAKFhOjUed3CYdiwydXOXp";
  var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "key=$serverKey",
    },
    body: jsonEncode(body),
  );

  log('Response status: ${response.statusCode}');
  log('Response body: ${response.body}');
}

