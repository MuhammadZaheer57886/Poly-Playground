import '../model/user_model.dart';

class Store {
  static final Store _store = Store._();
  factory Store() => _store;

  Store._();
  bool isLogedIn = false;
  UserDataModel userData = UserDataModel();
  String uid = "";
  DealModel? deal;
  bool isDarkMode = false;
  List<FriendModel> friends = [];
  
}
