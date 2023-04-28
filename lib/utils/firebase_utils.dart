
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../common/store.dart';
import '../model/user_model.dart';
FirebaseFirestore firestore  = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<String> setUserFirestore() async {
  User? user = firebaseAuth.currentUser;
  Store().userData.email = user!.email!;
  Store().userData.uid = user.uid;
  Store().uid= user.uid;
  try {
    await firestore.collection('users').doc(Store().uid).set(
        Store().userData.toMap());
    return Store().uid;
  } catch (e) {
    return '';
  }
}

bool updateUserInFirestore(UserDataModel userData) {
  try {
      firestore
        .collection("users")
        .doc(Store().uid)
        .update(userData.toMap());
  } catch (e) {
    return false;
  }
  return true;
}

Future<bool> getUserDataFromFireStore(String userId) async {
  DocumentSnapshot userDoc =
  await firestore.collection('users').doc(userId).get();
  if (!userDoc.exists) {
    return false;
  }
  Store().userData = UserDataModel.fromMap(userDoc.data() as Map<String, dynamic>);
  return true;
}

Future<bool> logOut() async {
  try{
    await firebaseAuth.signOut();
    Store().userData = UserDataModel();
    Store().isLogedIn = false;
  } catch (e) {
    return false;
  }
  // await firebaseAuth.signOut();
  // Store().userData = UserDataModel();
  // Store().isLogedIn = false;
  return true;
}
