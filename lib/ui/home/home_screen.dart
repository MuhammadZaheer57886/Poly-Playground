import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/pop_message.dart';
import 'package:poly_playground/ui/authentication/profile_info/photo_profile_screen.dart';
import 'package:poly_playground/ui/authentication/welcome_screen.dart';
import 'package:poly_playground/ui/home/profile_screen/profile_screen.dart';
import '../../common/store.dart';
import '../../model/user_model.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/firebase_utils.dart';
import '../../utils/my_utils.dart';
import '../chat/chat_user_list.dart';
import '../likes/liked_profile.dart';
import '../likes/liked_users.dart';

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
                            onPressed: () {},
                            icon: Image.asset("assets/home.png")),
                        IconButton(
                            onPressed: () {},
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
                    height: 15,
                  ),
// Container(
//   height: 50,
//   width: size.width,
//   color: Colors.white,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       IconButton(
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           }, icon: Image.asset("assets/menu.png")
//
//           ),
//
//       IconButton(
//           onPressed: () {},
//           icon: Image.asset("assets/search.png")),
//
//       InkWell(
//         onTap: () {},
//         child: Text(
//           "FOR YOU",
//           style: TextStyle(
//               color: Colors.yellow.shade800,
//               fontWeight: FontWeight.w700),
//         ),
//       ),
//       InkWell(
//         onTap: () {},
//         child: Text(
//           "TRENDING",
//           style: TextStyle(
//               color: Colors.red.shade800,
//               fontWeight: FontWeight.w700),
//         ),
//       ),
//       InkWell(
//         onTap: () {},
//         child: const Text(
//           "NEARBY",
//           style: TextStyle(
//               color: Colors.black, fontWeight: FontWeight.w700),
//         ),
//       ),
//       InkWell(
//         onTap: () {},
//         child: const Text(
//           "NEW",
//           style: TextStyle(
//               color: Colors.black, fontWeight: FontWeight.w700),
//         ),
//       )
//     ],
//   ),
// ),
// const SizedBox(
//   height: 10,
// ),
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
                                    like(users[index]);
                                  },
                                  onTap: () {
                                    screenPush(
                                        context,
                                        UserProfile(
                                          userData: users[index],
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
    if (user == null) {
      screenPush(context, const WelcomeScreen());
      return false;
    }
    Store().userData = user;
    if (Store().userData.photoUrl.isEmpty) {
      screenPush(context, const PhotoProfileScreen());
      return false;
    }
    Store().users = await getAllUsers();
    Store().dislikedUsersIds = await getDislikedUsers();
    Store().likedUsersIds = await getLikedUsers();
    return true;
  }

  Future<bool> handleState() async {
    if (!Store().isUser) {
      if (await getDetails()) {
        Store().isUser = true;
      }
    }
    if (Store().isUser) {
      setState(() {
        users = Store().users;
        users.removeWhere((element) => element.uid == Store().uid);
        users.removeWhere(
            (element) => Store().dislikedUsersIds.contains(element.uid));
        users.removeWhere(
            (element) => Store().likedUsersIds.contains(element.uid));
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

  like(UserDataModel user) async {
    setState(() {
      users.removeWhere((element) => element == user);
    });
    bool isLike = await likeUser(user.uid);
    if (!isLike) {
      Store().likedUsersIds.add(user.uid);
      showFailedToast(context, "something went wrong");
      setState(() {
        users.add(user);
      });
    }
  }
}
