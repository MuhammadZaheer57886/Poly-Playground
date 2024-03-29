import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../common/store.dart';
import '../model/user_model.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final currentRef =
    FirebaseFirestore.instance.collection('users').doc(Store().uid);

Future<String> setUser() async {
  User? user = firebaseAuth.currentUser;
  Store().userData.email = user!.email!;
  Store().userData.uid = user.uid;
  Store().uid = user.uid;
  try {
    await fireStore
        .collection("users")
        .doc(user.uid)
        .set(Store().userData.toMap());
    return Store().uid.toString();
  } catch (e) {
    return '';
  }
}

bool updateUserInFirestore(UserDataModel userData) {
  try {
    currentRef.update(userData.toMap());
  } catch (e) {
    return false;
  }

  return true;
}

Future<UserDataModel?> getUserData(String userId) async {
  DocumentSnapshot userDoc =
      await fireStore.collection("users").doc(userId).get();
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
  return fireStore
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
    final v = await fireStore
        .collection("chats")
        .doc(Store().uid)
        .collection(message.receiverId)
        .add(message.toMap());
    await fireStore
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
  List<UserDataModel> friends = [];
  for (var element in Store().friendsIds) {
    final user = await getUserData(element);
    if (user != null) friends.add(UserDataModel.fromMap(user.toMap()));
  }
  return friends;
}

Future<List<ChatModel>> getLastMessages() async {
  List<ChatModel> chats = [];
  try {
    final querySnapshot = await currentRef.collection('chats').get();
    for (var doc in querySnapshot.docs) {
      chats.add(ChatModel.fromMap(doc.data()));
    }
  } catch (e) {
    chats = [];
  }
  return chats;
}

Future<bool> updateLastMessageToFirestore(
    ChatModel chat, ChatModel chat2) async {
  try {
    await currentRef.collection("chats").doc(chat.uid).update(chat.toMap());
    await fireStore
        .collection("users")
        .doc(chat.uid)
        .collection("chats")
        .doc(Store().uid)
        .update(chat2.toMap());

    return true;
  } catch (e) {
    try {
      await currentRef.collection("chats").doc(chat.uid).set(chat.toMap());
      await fireStore
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
    await currentRef.collection("likes").doc(uid).delete();
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> addLike(String uid) async {
  try {
    await currentRef.collection("likes").doc(uid).set({});
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> dislikeUser(String uid) async {
  try {
    await currentRef.collection("dislikes").doc(uid).set({});
    return true;
  } catch (e) {
    return false;
  }
}

Future<List<UserDataModel>> getAllUsers() async {
  List<UserDataModel> users = [];
  try {
    final value = await fireStore.collection("users").get();
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
    QuerySnapshot snap = await currentRef.collection("dislikes").get();
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
    QuerySnapshot snap = await currentRef.collection("likes").get();
    for (var doc in snap.docs) {
      likes.add(doc.id);
    }
  } catch (e) {
    likes = [];
  }
  return likes;
}

Future<String?> requestToken() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();

    final token = await messaging.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
    return token;
  } catch (e) {
    return null;
  }
}

Future<void> updateReadStatus(ChatModel chat) async {
  try {
    chat.lastMessage.isRead = true;
    fireStore
        .collection('users')
        .doc(Store().uid)
        .collection('chats')
        .doc(chat.uid)
        .update(chat.toMap());
  } catch (e) {
    log(e.toString());
  }
}

Future<List<CallModel>> getLastcall() async {
  List<CallModel> call = [];
  try {
    final querySnapshot = await currentRef.collection('call').get();
    for (var doc in querySnapshot.docs) {
      call.add(CallModel.fromMap(doc.data()));
    }
  } catch (e) {
    call = [];
  }
  return call;
}

Future<bool> sendFriendRequest(
    FriendRequest request, FriendRequest request2) async {
  try {
    await currentRef
        .collection("friendRequests")
        .doc(request.receiverId)
        .set(request.toMap());
    await fireStore
        .collection("users")
        .doc(request2.receiverId)
        .collection("friendRequests")
        .doc(Store().uid)
        .set(request2.toMap());
    return true;
  } catch (e) {
    return false;
  }
}

Future<List<FriendRequest>> getFriendRequests() async {
  List<FriendRequest> requests = [];
  try {
    final querySnapshot = await currentRef.collection('friendRequests').get();
    for (var doc in querySnapshot.docs) {
      requests.add(FriendRequest.fromMap(doc.data()));
    }
  } catch (e) {
    requests = [];
  }
  return requests;
}

Future<void> setNotificationInFirestore(NotificationModel notification) async {
  await fireStore
      .collection('users')
      .doc(notification.receiverId)
      .collection("notifications")
      .doc()
      .set(notification.toMap());
}

Future<List<NotificationModel>> getNotificationFromFirestore() async {
  List<NotificationModel> notifications = [];
  try {
    QuerySnapshot<Map<String, dynamic>> snaps = await fireStore
        .collection('users')
        .doc(Store().uid)
        .collection("notifications")
        .get();
    for (var doc in snaps.docs) {
      NotificationModel notification = NotificationModel.fromMap(doc.data());
      if(notification.id.isEmpty){
        notification.id = doc.id;
      }
      notifications.add(notification);
    }
  } catch (e) {
    notifications = [];
  }

  return notifications;

}

Future<void> updateNotificationToFirestore(NotificationModel notification) async {
  currentRef
      .collection('notifications')
      .doc(notification.id)
      .update(notification.toMap());
}

Future<void> deleteFriendRequestFromeFireBase(FriendRequest request) async {
  String id = request.senderId == Store().uid ? request.receiverId : request.senderId;
  try {
    await currentRef
        .collection('friendRequests')
        .doc(id)
        .delete();
    await fireStore
        .collection('users')
        .doc(id)
        .collection("friendRequests")
        .doc(Store().uid)
        .delete();
  }catch(e){
  }
}
// Future<void> updateFriendRequestFromeFireBase(FriendRequest request) async {
//   String id = request.senderId == Store().uid ? request.receiverId : request.senderId;
//   try {
//     await currentRef
//         .collection('friendRequests')
//         .doc(id)
//         .update({"status":request.status});
//     await fireStore
//         .collection('users')
//         .doc(id)
//         .collection("friendRequests")
//         .doc(Store().uid)
//         .update({"status":request.status});
//   }catch(e){
//   }
// }

Future<void> addFriendToFireStore(String friendId) async {
  await currentRef
      .collection('friends')
      .doc(friendId)
      .set({});
  await fireStore
      .collection('users')
      .doc(friendId)
      .collection("friends")
      .doc(Store().uid)
      .set({});
}
Future<FriendRequest?> checkFriendRequest(String friendId) async {
  try {
    final value = await currentRef
        .collection('friendRequests')
        .doc(friendId)
        .get();
    if (value == null) {
      return null;
    }
    return FriendRequest.fromMap(value.data()!);
  } catch (e) {
    return null;
  }
}

Future<List<String>> getFriendsIds() async {
  try {
    final value = await currentRef
        .collection('friends')
        .get();
    if (value == null) {
      return [];
    }
    List<String> friendsIds = [];
    for (var doc in value.docs) {
      friendsIds.add(doc.id);
    }

    return friendsIds;
  } catch (e) {
    return [];
  }
}
Future <bool> checkIsFriend(String friendId) async {
  try {
    final value = await currentRef
        .collection('friends')
        .doc(friendId)
        .get();
    if (value == null) {
      return false;
    }
    return true;
  } catch (e) {
    return false;
  }
}
Future<List<String>> getFriendRequestsIds() async {
  try {
    final value = await currentRef
        .collection('friendRequests')
        .get();
    List<String> friendsIds = [];
    for (var doc in value.docs) {
      friendsIds.add(doc.id);
    }

    return friendsIds;
  } catch (e) {
    return [];
  }
}


Future<List<UserDataModel>> getMultipleUsers(List<String> docIds) async {
  try {
    final docsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("uid",  whereIn:  docIds)
        .get();
  List<UserDataModel> docsData = docsSnapshot.docs.map((doc) =>UserDataModel.fromMap(doc.data())).toList();

  return docsData;
  }catch(e){
    return [];
  }
}