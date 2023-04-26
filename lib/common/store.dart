import 'package:poly_playground/utils/my_utils.dart';

import '../model/user_model.dart';

class Store {
  static final Store _store = Store._();
  factory Store() => _store;

  Store._();
  bool isLogedIn = false;
  UserDataModel userData = UserDataModel();
  String uid = "";
  List<FriendModel> friends = [];
  
}
