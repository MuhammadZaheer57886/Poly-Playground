class UserModel {
  String? uid;
  String? email;

  UserModel({this.uid, this.email});

  // data from cloud firestore
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
    );
  }

  // sending data to cloud firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}

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

  UserDataModel({
    required this.city,
    required this.date,
    required this.email,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.intro,
    required this.job,
    required this.fullName,
    required this.photoUrl,
    required this.role,
    required this.town,
    required this.uid,
  });

  static void fromMap(UserDataModel user, Map<String, dynamic> map) {
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
  }

  Map<String, dynamic> toJson() {
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

      // add any other fields you want to serialize to JSON
    };
  }
}
