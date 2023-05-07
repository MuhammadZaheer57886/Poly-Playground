import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/utils/constants/app_strings.dart';
import '../common/store.dart';

Future<bool> sendNotification(body) async {
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
    log(response.body);
    if (response.statusCode == 200) return true;

    return false;
  } catch (e) {
    log(e.toString());
    return false;
  }
}

Future<bool> messageNotification() async {
  final body = {
    "to": Store().friend!.token.toString(),
    "notification": {
      "title": AppStrings.i.messageNotificationTitle,
      "body": AppStrings.i.messageNotificationBody,
      "android_channel_id": AppStrings.i.appId,
      "sound": AppStrings.i.notificationSound,
      "mutable_content": true,
      "image": Store().userData.photoUrl,
    }
  };
  return await sendNotification(body);
}

Future<bool> cancelFriendRequestNotification(UserDataModel user) async {
  final body = {
    "to": user.token.toString(),
    "notification": {
      "title": AppStrings.i.canselFriendRequestNotificationTitle,
      "body": AppStrings.i.cancelFriendRequestNotificationBody,
      "android_channel_id": AppStrings.i.appId,
      "sound": AppStrings.i.notificationSound,
      "mutable_content": true,
      "image": Store().userData.photoUrl,
    }
  };

  return await sendNotification(body);

}
Future<bool> friendRequestNotification(UserDataModel user) async {
  final body = {
    "to": user.token.toString(),
    "notification": {
      "title": AppStrings.i.friendRequestNotificationTitle,
      "body": AppStrings.i.friendRequestNotificationBody,
      "android_channel_id": AppStrings.i.appId,
      "sound": AppStrings.i.notificationSound,
      "mutable_content": true,
      "image": Store().userData.photoUrl,
    }
  };

  return await sendNotification(body);

}
Future<bool> friendRequestAcceptedNotification(UserDataModel user) async {
  final body = {
    "to": user.token.toString(),
    "notification": {
      "title": AppStrings.i.friendRequestAcceptedNotificationTitle,
      "body": AppStrings.i.friendRequestAcceptedNotificationBody,
      "android_channel_id": AppStrings.i.appId,
      "sound": AppStrings.i.notificationSound,
      "mutable_content": true,
      "image": Store().userData.photoUrl,
    }
  };

  return await sendNotification(body);

}
Future<bool> friendRequestRejectedNotification(UserDataModel user) async {
  final body = {
    "to": user.token.toString(),
    "notification": {
      "title": AppStrings.i.friendRequestRejectedNotificationTitle,
      "body": AppStrings.i.friendRequestRejectedNotificationBody,
      "android_channel_id": AppStrings.i.appId,
      "sound": AppStrings.i.notificationSound,
      "mutable_content": true,
      "image": Store().userData.photoUrl,
    }
  };

  return await sendNotification(body);

}
