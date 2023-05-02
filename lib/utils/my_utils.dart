import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../common/store.dart';
import '../model/user_model.dart';
import 'package:intl/intl.dart';

import 'firebase_utils.dart';

Future<String> uploadImage(String path) async {
  if (path == '') {
    return '';
  }
  final fileName = path.split('/').last;
  final firebaseStorageRef =
      FirebaseStorage.instance.ref().child('users/profileImages/$fileName');
  final uploadTask = firebaseStorageRef.putFile(File(path));
  final snapshot = await uploadTask.whenComplete(() {});
  if (snapshot.state == TaskState.success) {
    final downloadUrl = await firebaseStorageRef.getDownloadURL();
    return downloadUrl;
  }
  throw Exception("check your Internet connection");
}

Future<String> getImageFromUser() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile == null) {
    return '';
  } else {
    return pickedFile.path;
  }
}



bool isValidDate(String date) {
  try {
    DateFormat.yMd().parseStrict(date);
    return true;
  } catch (e) {
    return false;
  }
}

ChatModel createChatModel(UserDataModel friend, MessageModel lastMessage) {
  return ChatModel(
    fullName: friend.fullName,
    photoUrl: friend.photoUrl,
    lastMessage: lastMessage,
    uid: friend.uid,
  );
}

CallHistoryModel createCallModel(FriendModel friend, CallModel lastCall) {
  return CallHistoryModel(
    fullName: friend.fullName,
    photoUrl: friend.photoUrl,
    lastCall: lastCall,
    uid: friend.uid,
  );
}


String formatDate() {
  final formatter = DateFormat('MMM dd, yyyy h:mm:ss.SSS a');
  return formatter.format(DateTime.now());
}
String getMessageTime(String date) {
  DateTime messageTime = DateFormat('MMM dd, yyyy h:mm:ss.SSSS a').parse(date);
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = today.subtract(const Duration(days: 1));
  DateTime twoDaysAgo = today.subtract(const Duration(days: 2));
  DateTime weekAgo = today.subtract(const Duration(days: 7));

  if (messageTime.isAfter(today)) {
    return 'Today';
  } else if (messageTime.isAfter(yesterday)) {
    return 'Yesterday';
  } else if (messageTime.isAfter(twoDaysAgo)) {
    return '2 Days Ago';
  } else if (messageTime.isAfter(weekAgo)) {
    int numDays = today.difference(messageTime).inDays;
    return '$numDays Days Ago';
  } else {
    DateFormat formatter = DateFormat('MMMM dd, yyyy');
    return formatter.format(messageTime);
  }
}

Future<bool> likeUser(String uid) async {
  bool isAdded = await addLike(uid);
  if (isAdded) {
    Store().likedUsersIds.add(uid);
    return true;
  }
  return false;
}