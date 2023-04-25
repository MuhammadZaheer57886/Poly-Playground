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

  String name;
  String dob;
  String orientation;
  String genderIdentity;
  String pronouns;
  String userName;
  String bio;
  String single;
  String open;


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
    required this.name,
    required this.dob,
    required this.orientation,
    required this.genderIdentity,
    required this.pronouns,
    required this.userName,
    required this.bio,
    required this.single,
    required this.open,
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
    user.name = map['name'];
    user.dob = map['dob'];
    user.orientation = map['orientation'];
    user.genderIdentity = map['genderIdentity'];
    user.pronouns = map['pronouns'];
    user.userName = map['userName'];
    user.bio = map['bio'];
    user.single = map['single'];
    user.open = map['open'];
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
      'name': name,
      'dob': dob,
      'orientation' : orientation,
      'genderIdentity' : genderIdentity,
      'pronouns' : pronouns,
      'userName' : userName,
      'bio' : bio,
      'single' : single,
      'open' : open,
      // add any other fields you want to serialize to JSON
    };
  }
}
