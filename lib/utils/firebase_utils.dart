import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../common/store.dart';
import '../model/user_model.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final cruntUserRef =
    FirebaseFirestore.instance.collection('users').doc(Store().uid);

Future<String> setUser() async {
  User? user = firebaseAuth.currentUser;
  Store().userData.email = user!.email!;
  Store().userData.uid = user.uid;
  Store().uid = user.uid;
  try {
    await cruntUserRef.set(Store().userData.toMap());
    return Store().uid;
  } catch (e) {
    return '';
  }
}

bool updateUserInFirestore(UserDataModel userData) {
  try {
    cruntUserRef.update(userData.toMap());
  } catch (e) {
    return false;
  }
  return true;
}

Future<UserDataModel?> getUserData(String userId) async {
  DocumentSnapshot userDoc =
      await firestore.collection("users").doc(userId).get();
  if (!userDoc.exists) {
    return null;
  }
  return UserDataModel.fromMap(userDoc.data() as Map<String, dynamic>);
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
  return firestore
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

Future<List<UserDataModel>> getFriends() async {
  // List<UserDataModel> friends = [];
  // try {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await firestore.collection("users").get();
  //   for (var doc in querySnapshot.docs) {
  //     friends.add(UserDataModel.fromMap(doc.data()));
  //   }
  // } catch (e) {
  //   friends = [];
  // }

  // return friends;
  List<UserDataModel> friends = [];
  for (var element in Store().likedUsersIds)  {
    final user = await getUserData(element);
    if (user != null) friends.add(UserDataModel.fromMap(user.toMap()));
  }
  return friends;
}

Future<List<ChatModel>> getLastMessages() async {
  List<ChatModel> chats = [];
  try {
    final querySnapshot = await cruntUserRef.collection('chats').get();
    for (var doc in querySnapshot.docs) {
      chats.add(ChatModel.fromMap(doc.data()));
    }
  } catch (e) {
    chats = [];
  }
  return chats;
}

Future<bool> updateLastMessageToFirestore(ChatModel chat,ChatModel chat2) async {
  try {
    await cruntUserRef.collection("chats").doc(chat.uid).update(chat.toMap());
    await firestore
        .collection("users")
        .doc(chat.uid)
        .collection("chats")
        .doc(Store().uid)
        .update(chat2.toMap());

    return true;
  } catch (e) {
    try {
      await cruntUserRef.collection("chats").doc(chat.uid).set(chat.toMap());
      await firestore
          .collection("users")
          .doc(chat.uid)
          .collection("chats")
          .doc(Store().uid)
          .set(chat2.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}

Future<bool> removeLike(String uid) async {
  try {
    await cruntUserRef.collection("likes").doc(uid).delete();
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> addLike(String uid) async {
  try {
    await cruntUserRef.collection("likes").doc(uid).set({});
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> dislikeUser(String uid) async {
  try {
    await cruntUserRef.collection("dislikes").doc(uid).set({});
    return true;
  } catch (e) {
    return false;
  }
}

Future<List<UserDataModel>> getAllUsers() async {
  List<UserDataModel> users = [];
  try {
    final value = await firestore.collection("users").get();
    if (value == null) {
      return users;
    }
    for (var doc in value.docs) {
      users.add(UserDataModel.fromMap(doc.data()));
    }
  } catch (e) {
    users = [];
  }
  Store().users = users;
  return users;
}

Future<List<String>> getDislikedUsers() async {
  List<String> dislikes = [];
  try {
    QuerySnapshot snap = await cruntUserRef.collection("dislikes").get();
    for (var doc in snap.docs) {
      dislikes.add(doc.id);
    }
  } catch (e) {
    dislikes = [];
  }
  return dislikes;
}

Future<List<String>> getLikedUsers() async {
  List<String> likes = [];
  try {
    QuerySnapshot snap = await cruntUserRef.collection("likes").get();
    for (var doc in snap.docs) {
      likes.add(doc.id);
    }
  } catch (e) {
    likes = [];
  }
  return likes;
}

Future<String?>  requestToken()async{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();

  final token = await messaging.getToken();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification}');
    }
  });


  return token;

}

Future<void> updateReadStatus(ChatModel chat) async{
  try {
    chat.lastMessage.isRead = true;
    firestore.collection('users').doc(Store().uid).collection('chats').doc(
        chat.uid).update(chat.toMap());
  }catch(e){
    print(e);
  }

}