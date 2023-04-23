import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../common/store.dart';
import '../model/user_model.dart';

Future<String> uploadImage(String path) async {
  if (path == '' || path == null) {
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
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile == null) {
    return '';
  } else {
    return pickedFile.path;
  }
}

String setDate(String day, String month, String year) {
  if (int.parse(day) > 31 || int.parse(day) < 1) {
    return '';
  }
  if (int.parse(month) > 12 || int.parse(month) < 1) {
    return '';
  }
  if (int.parse(year) > 2021 || int.parse(year) < 1900) {
    return '';
  }
  return '$day/$month/$year';
}

bool updateUserInFirestore(UserDataModel userData) {
  try {
    FirebaseFirestore.instance
        .collection("users")
        .doc(Store().uid)
        .update(userData.toJson());
  } catch (e) {
    return false;
  }
  return true;
}
