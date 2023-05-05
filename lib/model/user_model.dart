import 'package:poly_playground/common/store.dart';

class UserDataModel {
  String city;
  String date;
  String email;
  String image1;
  String image2;
  String image3;
  String image4;
  String intro;
  String job;
  String fullName;
  String photoUrl;
  String role;
  String town;
  String uid;
  String name;
  String dob;
  String orientation;
  String genderIdentity;
  String pronouns;
  String userName;
  String bio;
  String single;
  String open;
  String phone;
  String token;

  UserDataModel({
    this.phone = '',
    this.city = '',
    this.date = '',
    this.email = '',
    this.image1 = '',
    this.image2 = '',
    this.image3 = '',
    this.image4 = '',
    this.intro = '',
    this.job = '',
    this.fullName = '',
    this.photoUrl = '',
    this.role = '',
    this.town = '',
    this.uid = '',
    this.name = '',
    this.dob = '',
    this.orientation = '',
    this.genderIdentity = '',
    this.pronouns = '',
    this.userName = '',
    this.bio = '',
    this.single = '',
    this.open = '',
    this.token = '',
  });

  static UserDataModel fromMap(Map<String, dynamic> map) {
    UserDataModel user = UserDataModel();
    user.city = map['city'];
    user.date = map['date'];
    user.email = map['email'];
    user.image1 = map['image1'];
    user.image2 = map['image2'];
    user.image3 = map['image3'];
    user.image4 = map['image4'];
    user.intro = map['intro'];
    user.job = map['job'];
    user.fullName = map['fullName'];
    user.photoUrl = map['photoUrl'];
    user.role = map['role'];
    user.town = map['town'];
    user.uid = map['uid'];
    user.name = map['name'];
    user.dob = map['dob'];
    user.orientation = map['orientation'];
    user.genderIdentity = map['genderIdentity'];
    user.pronouns = map['pronouns'];
    user.userName = map['userName'];
    user.bio = map['bio'];
    user.single = map['single'];
    user.open = map['open'];
    user.phone = map['phone'];
    user.token = map['token'];
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'job': job,
      'intro': intro,
      'role': role,
      'date': date,
      'city': city,
      'town': town,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'photoUrl': photoUrl,
      'uid': uid,
      'email': email,
      'name': name,
      'dob': dob,
      'orientation': orientation,
      'genderIdentity': genderIdentity,
      'pronouns': pronouns,
      'userName': userName,
      'bio': bio,
      'single': single,
      'open': open,
      'phone': phone,
      'token': token,
      // add any other fields you want to serialize to JSON
    };
  }
}

class DealModel {
  String duration;
  String price;
  String discount;
  bool selected = false;

  DealModel({
    required this.duration,
    required this.price,
    required this.discount,
    required this.selected,
  });
}

class MessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  late bool isRead;
  final String timestamp;
  final String type;

  MessageModel({
    this.senderId = "",
    this.receiverId = "",
    this.message = "",
    this.isRead = false,
    this.timestamp = "",
    this.type = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'isRead': isRead,
      'timestamp': timestamp.toString(),
      'type': type,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      message: map['message'],
      isRead: map['isRead'],
      timestamp: map['timestamp'],
      type: map['type'],
    );
  }
}

class FriendModel {
  String fullName;
  String photoUrl;
  String uid;

  FriendModel({
    required this.fullName,
    required this.photoUrl,
    required this.uid,
  });

  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      fullName: map['fullName'],
      photoUrl: map['photoUrl'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'photoUrl': photoUrl,
      'uid': uid,
    };
  }
}

class ChatModel {
  String fullName;
  String photoUrl;
  String uid;
  MessageModel lastMessage;

  ChatModel({
    required this.fullName,
    required this.photoUrl,
    required this.uid,
    required this.lastMessage,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      fullName: map['fullName'],
      photoUrl: map['photoUrl'],
      uid: map['uid'],
      lastMessage: MessageModel.fromMap(map['lastMessage']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'photoUrl': photoUrl,
      'uid': uid,
      'lastMessage': lastMessage.toMap(),
    };
  }
}

class CallHistoryModel {
  final String senderId;
  final String receiverId;
  final bool ringing;
  final String timestamp;
  final String type;
  final String duration;
  final String lastCall;

  CallHistoryModel({
    required this.senderId,
    required this.receiverId,
    required this.ringing,
    required this.timestamp,
    required this.type,
    required this.duration,
    required this.lastCall,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'ringing': ringing,
      'timestamp': timestamp.toString(),
      'type': type,
      'duration': duration,
    };
  }

  factory CallHistoryModel.fromMap(Map<String, dynamic> map) {
    return CallHistoryModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      ringing: map['ringing'],
      timestamp: map['timestamp'],
      type: map['type'],
      duration: map['duration'],
      lastCall: map['lastCall'],
    );
  }
}

class CallModel {
  String fullName;
  String photoUrl;
  String uid;
  CallHistoryModel lastCall;

  CallModel({
    required this.fullName,
    required this.photoUrl,
    required this.uid,
    required this.lastCall,
  });

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      fullName: map['fullName'],
      photoUrl: map['photoUrl'],
      uid: map['uid'],
      lastCall: CallHistoryModel.fromMap(map['lastCall']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'photoUrl': photoUrl,
      'uid': uid,
      'lastCall': lastCall.toMap(),
    };
  }
}

class FriendRequest {
  final String fullName;
  final String photoUrl;
  final String senderId;
  final String receiverId;
  final String timestamp;
  String status;

  FriendRequest({
    required this.fullName,
    required this.photoUrl,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    required this.status,
  });

  static FriendRequest createFriendRequest(
      UserDataModel user, String receiverId) {
    return FriendRequest(
      fullName: user.fullName,
      photoUrl: user.photoUrl,
      senderId: user.uid,
      receiverId: receiverId,
      timestamp: DateTime.now().toString(),
      status: "pending",
    );
  }

  static fromMap(Map<String, dynamic> map) {
    return FriendRequest(
      fullName: map['fullName'],
      photoUrl: map['photoUrl'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      timestamp: map['timestamp'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'status': status,
      'fullName': fullName,
      'photoUrl': photoUrl,
    };
  }

  updateRequest(String status) {
    this.status = status;
  }
}

class NotificationModel {
  final String title;
  final String type;
  final String senderId;
  final String receiverId;
  final String timestamp;
  final String photoUrl;

  NotificationModel(
      {required this.receiverId,
      required this.senderId,
      required this.timestamp,
      required this.title,
      required this.type,
      required this.photoUrl});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'title': title,
      'type': type,
      'photoUrl': photoUrl,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      receiverId: map['receiverId'],
      senderId: map['senderId'],
      timestamp: map['timestamp'],
      title: map['title'],
      type: map['type'],
      photoUrl: map['photoUrl'],
    );
  }
  static NotificationModel createNotification(String receiverId,String type,UserDataModel sender ) {
    return NotificationModel(
      receiverId: receiverId,
      senderId: sender.uid,
      timestamp: DateTime.now().toString(),
      title:  "${sender.fullName} sent you a $type",
      type: type,
      photoUrl: sender.photoUrl,
    );
  }
}
