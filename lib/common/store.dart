import '../model/user_model.dart';

class Store {
  static final Store _store = Store._();
  factory Store() => _store;

  Store._();
  bool isLogedIn = false;
  UserDataModel userData = UserDataModel(
    city: "",
    name: "",
    date: "",
    email: "",
    image1: "",
    image2: "",
    image3: "",
    image4: "",
    intro: "",
    job: "",
    photoUrl: "",
    role: "",
    town: "",
    uid: "",
  );
  String uid = "";
  DealModel? deal;
  
}
