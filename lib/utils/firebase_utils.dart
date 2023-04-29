import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../common/store.dart';
import '../model/user_model.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<String> setUserFirestore() async {
  User? user = firebaseAuth.currentUser;
  Store().userData.email = user!.email!;
  Store().userData.uid = user.uid;
  Store().uid = user.uid;
  try {
    await firestore
        .collection('users')
        .doc(Store().uid)
        .set(Store().userData.toMap());
    return Store().uid;
  } catch (e) {
    return '';
  }
}

bool updateUserInFirestore(UserDataModel userData) {
  try {
    firestore.collection("users").doc(Store().uid).update(userData.toMap());
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
  Store().userData =
      UserDataModel.fromMap(userDoc.data() as Map<String, dynamic>);
  return true;
}

Future<bool> logOut() async {
  try {
    await firebaseAuth.signOut();
    Store().userData = UserDataModel();
    Store().isLogedIn = false;
  } catch (e) {
    return false;
  }
  Store().clear();
  return true;
}

Stream<List<MessageModel>> listenForNewMessages(String receiverId) {
  return FirebaseFirestore.instance
      .collection("chats")
      .doc(Store().uid)
      .collection(receiverId)
      .orderBy("timestamp")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => MessageModel.fromMap(doc.data()))
          .toList());
}

Future<bool> setMessageToFirestore(MessageModel message) async {
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
    for (var doc in querySnapshot.docs) {
      friends.add(FriendModel.fromMap(doc.data()));
    }
  } catch (e) {
    friends = [];
  }
  return friends;
}

Future<List<ChatModel>> getLastMessages() async {
    List<ChatModel> chats = [];
  try{
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(Store().uid)
        .collection('chats').get();
    for(var doc in querySnapshot.docs) {
      chats.add(ChatModel.fromMap(doc.data()));
    }
    }catch(e){
      chats = [];
  }
  return chats;

}
Future<bool> updateLastMessageToFirestore(ChatModel chat) async {
  try {
    await firestore
        .collection("users")
        .doc(Store().uid)
        .collection("chats")
        .doc(chat.uid)
        .update(chat.toMap());
    return true;
  }catch(e){
    try{
      await firestore
          .collection("users")
          .doc(Store().uid)
          .collection("chats")
          .doc(chat.uid)
          .set(chat.toMap());
      return true;
    }
    catch(e){
      return false;
    }
  }
}

Future<bool> removeLike(String uid) async {
  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(Store().uid)
        .collection("likes")
        .doc(uid)
        .delete();
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> addLike(String uid) async {
  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(Store().uid)
        .collection("likes")
        .doc(uid).set({});
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> dislikeUser(String uid) async {
  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(Store().uid)
        .collection("dislikes")
        .doc(uid).set({});
    return true;
  } catch (e) {
    return false;
  }
}
