import 'package:flutter/material.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import 'package:poly_playground/ui/likes/friends.dart';
import 'package:poly_playground/ui/likes/panding_requests.dart';
import 'package:poly_playground/ui/notifications/NotificationScreen.dart';
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

  Future<List<UserDataModel>> getAllFriends() async =>
      await getMultipleUsers(Store().friendsIds);

  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFriends().then((value) =>
    {
      Store().friends = value,
      getAllFriendRequests().then((value) =>
      {
        Store().friendRequests = value,
        setState(() {
          isLoading = false;
        }),
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
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
                        "Friends",
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
                !isLoading ? const Expanded(
                  child: TabBarView(children: [
                    Friends(),
                    PendingRequests(),
                  ]),
                ) : const Center(child: CircularProgressIndicator(),),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<List<FriendRequest>> getAllFriendRequests() async =>
      await getFriendRequests();
}
