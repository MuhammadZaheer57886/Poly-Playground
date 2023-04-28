import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../common/store.dart';
import '../model/user_model.dart';
import 'package:intl/intl.dart';

final firestore = FirebaseFirestore.instance;

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

bool updateUserInFirestore(UserDataModel userData) {
  try {
    firestore.collection("users").doc(Store().uid).update(userData.toJson());
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> setMessagetoFirestore(MessageModel message) async {
  try {
    final v = await firestore
        .collection("chats")
        .doc(Store().uid)
        .collection(message.receiverId)
        .add(message.toMap());
    await firestore
        .collection("chats")
        .doc(message.receiverId)
        .collection(Store().uid)
        .doc(v.id)
        .set(message.toMap());
  } catch (e) {
    return false;
  }
  return true;
}

Stream<List<MessageModel>> listenForNewMessages(String receiverId)  {
  return  FirebaseFirestore
      .instance
      .collection("chats")
      .doc(Store().uid)
      .collection(receiverId)
      .orderBy("timestamp")
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => MessageModel.fromMap(doc.data())).toList());
}
Future<List<MessageModel>> getMessagesFromFirestore(String receiverId) async {
  List<MessageModel> messages = [];
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore
        .instance
        .collection("chats")
        .doc(Store()
        .uid)
        .collection(receiverId)
        .get();

    querySnapshot.docs.forEach((doc) {
      messages.add(MessageModel.fromMap(doc.data()));
    });
  } catch (e) {
    messages = [];
  }
  return messages;
}

bool isValidDate(String date) {
  try {
    DateFormat.yMd().parseStrict(date);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> logOut() async {
  await FirebaseAuth.instance.signOut();
  Store().userData = UserDataModel();
  Store().isLogedIn = false;
  return true;
}

Future<bool> deleteAccount() async {
  try {
    await FirebaseAuth.instance.currentUser!.delete();
    await firestore.collection("users").doc(Store().uid).delete();
    Store().userData = UserDataModel();
    Store().isLogedIn = false;
    return true;
  } catch (e) {
    return false;
  }
}

Future<MessageModel?> getLastMessage(String receiverId) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc(Store().uid)
        .collection(receiverId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    return MessageModel.fromMap(querySnapshot.docs.first.data());
  } catch (e) {

    return null;
  }
}

Future<List<FriendModel>> getFriends() async {
  List<FriendModel> friends = [];
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection("users").get();
    querySnapshot.docs.forEach((doc) {
      // print(doc.data());
      friends.add(FriendModel.fromMap(doc.data()));
    });
  } catch (e) {
    friends = [];
  }
  return friends;
}

ChatModel createChatModel(FriendModel friend, MessageModel lastMessage) {
  return ChatModel(
    fullName: friend.fullName,
    photoUrl: friend.photoUrl,
    lastMessage: lastMessage,
    uid: friend.uid,
  );
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




String formatDate() {
  final formatter = DateFormat('MMM dd, yyyy h:mm:ss.SSS a');
  return formatter.format(DateTime.now());
}


