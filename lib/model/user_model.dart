class UserModel{
  String? uid;
  String? email;

  UserModel({this.uid, this.email});

  // data from cloud firestore
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
    );
  }
  // sending data to cloud firestore
  Map<String, dynamic> toMap(){
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
  String name;
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
    required this.name,
    required this.photoUrl,
    required this.role,
    required this.town,
    required this.uid,
  });

  String get getCity => city;
  set setCity(String value) => city = value;

  String get getDate => date;
  set setDate(String value) => date = value;

  String get getEmail => email;
  set setEmail(String value) => email = value;

  String get getImage1 => image1;
  set setImage1(String value) => image1 = value;

  String get getImage2 => image2;
  set setImage2(String value) => image2 = value;

  String get getImage3 => image3;
  set setImage3(String value) => image3 = value;

  String get getImage4 => image4;
  set setImage4(String value) => image4 = value;

  String get getIntro => intro;
  set setIntro(String value) => intro = value;

  String get getJob => job;
  set setJob(String value) => job = value;

  String get getName => name;
  set setName(String value) => name = value;

  String get getPhotoUrl => photoUrl;
  set setPhotoUrl(String value) => photoUrl = value;

  String get getRole => role;
  set setRole(String value) => role = value;

  String get getTown => town;
  set setTown(String value) => town = value;

  String get getUid => uid;
  set setUid(String value) => uid = value;

  static void fromMap(UserDataModel user,Map<String, dynamic> map) {
    user.city = map['city'];
    user.date = map['date'];
    user.email = map['email'];
    user.image1 = map['image1'];
    user.image2 = map['image2'];
    user.image3 = map['image3'];
    user.image4 = map['image4'];
    user.intro = map['intro'];
    user.job = map['job'];
    user.name = map['name'];
    user.photoUrl = map['photoUrl'];
    user.role = map['role'];
    user.town = map['town'];
    user.uid = map['uid'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
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
