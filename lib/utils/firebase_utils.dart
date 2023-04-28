
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

  // try{
  //   final messagesRef = FirebaseFirestore.instance
  //       .collection('chats').doc(Store().uid).get();
  //       // .collectionGroup();
  //   print(messagesRef);
  //   // messagesRef.get().then((querySnapshot) {
  //   //   querySnapshot.docs.forEach((doc) {
  //   //     final senderId = doc.get('senderId');
  //   //     final messageText = doc.get('messageText');
  //   //     print('$senderId: $messageText');
  //   //   });
  //   // });
  //
  // }
  // catch(e){
  //   return null;
  // }
  //
  //
  // return null;
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