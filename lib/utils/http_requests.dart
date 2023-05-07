import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:poly_playground/utils/constants/app_strings.dart';
import '../common/store.dart';

Future<bool> snedNotification() async {
  final body = {
    "to": Store().friend!.token.toString(),
    "notification": {
      "title": AppStrings.i.messageNotificationTitle,
      "body": AppStrings.i.messageNotificationBody,
      "android_channel_id": AppStrings.i.appId,
      "sound": AppStrings.i.messageNotificationSound,
      "mutable_content": true,
    }
  };

  var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
  try {
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=${AppStrings.i.serverKey}",
      },
      body: jsonEncode(body),
    );
    if(response.statusCode == 200)
      return true;
    return false;
  }
  catch (e) {
    log(e.toString());
    return false;
  }
}