import '../model/user_model.dart';

class Store {
  static final Store _store = Store._();

  factory Store() => _store;

  Store._();

  bool isLogedIn = false;
  bool isUser = false;
  UserDataModel userData = UserDataModel();
  String uid = "";
  DealModel? deal;
  bool isDarkMode = false;
  FriendModel? friend;
  List<FriendModel> friends = [];
  List<UserDataModel> users = [];
  List<UserDataModel> dislikedUsers = [];
  List<String> dislikedUsersIds = [];
  List<UserDataModel> likedUsers = [];
  List<String> likedUsersIds = [];


  void clear() {
    isLogedIn = false;
    isUser = false;
    userData = UserDataModel();
    uid = "";
    deal = null;
    isDarkMode = false;
    friend = null;
    friends = [];
    users = [];
    dislikedUsers = [];
    likedUsers = [];
  }
}
