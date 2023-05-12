import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/store.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/authentication/profile_info/add_picture_screen.dart';
import 'package:poly_playground/ui/authentication/profile_info/basic_info2.dart';
import 'package:poly_playground/ui/authentication/profile_info/basic_info_screen.dart';
import 'package:poly_playground/ui/authentication/profile_info/photo_profile_screen.dart';
import 'package:poly_playground/ui/authentication/welcome_screen.dart';
import 'package:poly_playground/ui/chat/chat_user_list.dart';
import 'package:poly_playground/ui/home/profile_screen/profile_screen.dart';
import 'package:poly_playground/ui/home/profile_screen/user_profile.dart';
import 'package:poly_playground/ui/likes/liked_users.dart';
import 'package:poly_playground/ui/notifications/NotificationScreen.dart';
import 'package:poly_playground/ui/profile_2/profile2.dart';
import 'package:poly_playground/ui/video_calls/video_calls.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import 'package:poly_playground/utils/firebase_utils.dart';
import 'package:poly_playground/utils/my_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  late List<UserDataModel> users = [];

  @override
  void initState() {
    super.initState();
    if (!Store().isLogedIn) {
      screenPush(context, const WelcomeScreen());
      return;
    }
    handleState().then((value) => {
          setState(() {
            isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  AppColors.i.darkBrownColor,
                  AppColors.i.darkBrownColor.withOpacity(0.4),
                ])),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: size.width,
                    color: AppColors.i.whiteColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              screenPush(context, const ProfileScreen());
                            },
                            icon: Image.asset("assets/profile.png")),
                        IconButton(
                            onPressed: () {
                              screenPush(context, widget);
                            },
                            icon: Image.asset("assets/home.png")),
                        IconButton(
                            onPressed: () {
                              screenPush(context, const CallListScreen());
                            },
                            icon: Image.asset("assets/video.png")),
                        IconButton(
                            onPressed: () {
                              screenPush(context, const LikedUsers());
                            },
                            icon: Image.asset("assets/love.png")),
                        IconButton(
                            onPressed: () {
                              screenPush(context, const ChatUserList());
                            },
                            icon: Image.asset("assets/chat.png")),
                        IconButton(
                            onPressed: () {
                              screenPush(context, const NotificationList());
                            },
                            icon: const Icon(
                              Icons.notifications_on_outlined,
                              size: 32,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: users.isNotEmpty
                        ? GridView.builder(
                            itemCount: users.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5.0,
                                    crossAxisSpacing: 1.0,
                                    childAspectRatio: 0.92),
                            itemBuilder: (context, index) {
                              return Stack(children: [
                                GestureDetector(
                                  onDoubleTap: () {
                                    handelFriendRequest(index);
                                  },
                                  onTap: () {
                                    screenPush(
                                        context,
                                        UserProfile(
                                          userId: users[index].uid,
                                        ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    width: size.width * 0.5,
                                    decoration: BoxDecoration(
                                        color: AppColors.i.whiteColor,
                                        borderRadius: BorderRadius.circular(35),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                users[index].photoUrl),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      disLike(users[index].uid);
                                    },
                                    child: Container(
                                      width: size.width * 0.06,
                                      height: size.width * 0.06,
                                      decoration: BoxDecoration(
                                          color: AppColors.i.whiteColor,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.i.blackColor,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                            },
                          )
                        : Center(
                            child: Text(
                            "No Users Found",
                            style: TextStyle(
                                color: AppColors.i.whiteColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )),
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(),
      ],
    );
  }

  Future<bool> getDetails() async {
    final user = await getUserData(Store().uid);
    if(!checkDetails(user)){
      return false;
    }
    Store().userData = user!;
    Store().users = await getAllUsers();
    Store().dislikedUsersIds = await getDislikedUsers();
    Store().friendsIds = await getFriendsIds();
    Store().friendRequestsIds = await getFriendRequestsIds();
    return true;
  }

  Future<bool> handleState() async {
    if (!Store().isUser) {
      if (await getDetails()) {
        final token = await requestToken();
        if (token != null) {
          Store().userData.token = token;
          await updateUserInFirestore(Store().userData);
        }
        Store().isUser = true;
      }
    }
    if (Store().isUser) {
      setState(() {
        users = Store().users;
        users.removeWhere((element) => element.uid == Store().uid);
        users.removeWhere(
            (element) => Store().dislikedUsersIds.contains(element.uid));
        users
            .removeWhere((element) => Store().friendsIds.contains(element.uid));
        users.removeWhere(
            (element) => Store().friendRequestsIds.contains(element.uid));
      });
    }
    return Store().isUser;
  }

  void disLike(String uid) async {
    Store().dislikedUsersIds.add(uid);
    await dislikeUser(uid);
    setState(() {
      users.removeWhere((element) => element.uid == uid);
    });
  }

  Future<void> handelFriendRequest(int index) async {
    UserDataModel user = users[index];
    setState(() {
      users[index] = users[users.length - 1];
      users.removeAt(users.length - 1);
    });
    if (!await makeFriendRequest(user)) {
      setState(() {
        users.insert(index, user);
      });
    }
  }

  bool checkDetails(UserDataModel? user) {
    if (user == null) {
      screenPush(context, const WelcomeScreen());
      return false;
    }
    if (user.photoUrl.isEmpty) {
      screenPush(context, const PhotoProfileScreen());
      return false;
    }
    if(user.fullName.isEmpty){
      screenPush(context, const BasicInfoScreen());
      return false;
    }
    if(user.role.isEmpty){
      screenPush(context, const BasicInfo2Screen());
      return false;
    }
    if(user.image1.isEmpty && user.image2.isEmpty && user.image3.isEmpty && user.image4.isEmpty ){
      screenPush(context, const AddPictureScreen());
      return false;
    }
    if(user.name.isEmpty){
      screenPush(context, const Profile2());
      return false;
    }
    return true;
  }
}
