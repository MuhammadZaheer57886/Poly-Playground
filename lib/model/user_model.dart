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