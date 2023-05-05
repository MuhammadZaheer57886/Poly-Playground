import 'package:flutter/material.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import 'package:poly_playground/ui/likes/like_utils.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import '../../common/nav_function.dart';
import '../../common/store.dart';
import '../../utils/firebase_utils.dart';
import '../chat/chat_user_list.dart';
import '../home/profile_screen/profile_screen.dart';
import '../video_calls/video_calls.dart';

class LikedUsers extends StatefulWidget {
  const LikedUsers({Key? key}) : super(key: key);

  @override
  State<LikedUsers> createState() => _LikedUsersState();
}

class _LikedUsersState extends State<LikedUsers> {
  bool isLoading = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    getLikedProfiles().then((value) => {
          Store().likedUsers = value,
          setState(() {
            isLoading = false;
          })
        });
    getAllFriendRequests().then((value) => {
          Store().friendRequests = value,
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                            screenPush(context, const HomeScreen());
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: 55,
                  child: Text(
                    "People You Liked",
                    style: TextStyle(
                        color: AppColors.i.whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.04,
                  child: TabBar(
                    dividerColor: AppColors.i.whiteColor,
                    indicatorColor: AppColors.i.whiteColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Text(
                        "Friend",
                        style: TextStyle(
                          color: AppColors.i.whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.04,
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          color: AppColors.i.whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Expanded(
                  child: TabBarView(children: [
                    friends(size, context),
                    pending(size, context),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<UserDataModel>> getLikedProfiles() async {
    List<UserDataModel> likedProfiles = [];
    for (var uid in Store().likedUsersIds) {
      final user = await getUserData(uid);
      if (user == null || user.uid == Store().uid) {
      } else {
        likedProfiles.add(user);
      }
    }
    return likedProfiles;
  }

  Future<List<FriendRequest>> getAllFriendRequests() async {
    List<FriendRequest> friendRequests = await getFriendRequests();
    List<FriendRequest> filteredFriendRequests = [];
    for (var friendRequest in friendRequests) {
      if (friendRequest.status == "pending") {
        filteredFriendRequests.add(friendRequest);
      }
    }
    return filteredFriendRequests;
  }
}
