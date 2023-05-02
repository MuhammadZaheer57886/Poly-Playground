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

  static UserDataModel fromMap( Map<String, dynamic> map) {
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
  bool selected=false;

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
  final bool isRead;
  final String timestamp;
  final String type;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.isRead,
    required this.timestamp,
    required this.type,
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
      timestamp:map['timestamp'],
      type: map['type'],
    );
  }
}
class FriendModel {
  String fullName;
  String photoUrl;
  String uid;
  FriendModel({
    required this.fullName ,
    required this.photoUrl ,
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
    required this.fullName ,
    required this.photoUrl ,
    required this.uid,
    required this.lastMessage,
  });
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      fullName: map['fullName'],
      photoUrl: map['photoUrl'],
      uid: map['uid'],
      // lastMessage: map['lastMessage'],
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