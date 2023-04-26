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
