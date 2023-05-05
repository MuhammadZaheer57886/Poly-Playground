import 'package:flutter/material.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import '../../common/nav_function.dart';
import '../../common/store.dart';
import '../../utils/firebase_utils.dart';
import '../chat/chat_user_list.dart';
import '../home/profile_screen/profile_screen.dart';
import '../video_calls/video_calls.dart';
import 'liked_profile.dart';

class LikedUsers extends StatefulWidget {
  const LikedUsers({Key? key}) : super(key: key);

  @override
  State<LikedUsers> createState() => _LikedUsersState();
}

class _LikedUsersState extends State<LikedUsers> {
  late List<UserDataModel> likedProfiles = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLikedProfiles().then((value) => {
          Store().likedUsers = value,
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
              ],
            )),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                screenPush(context, widget);
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      height: 45,
                      child: Text(
                        "People You Liked ",
                        style: TextStyle(
                            color: AppColors.i.whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    // SingleChildScrollView(
                    //   physics: const AlwaysScrollableScrollPhysics(),
                    //   child: SizedBox(
                    //     height: size.height * 0.8,
                    //     child: GridView.builder(
                    //       itemCount: Store().likedUsers.length,
                    //       gridDelegate:
                    //           const SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2,
                    //         mainAxisSpacing: 5.0,
                    //         crossAxisSpacing: 1.0,
                    //         childAspectRatio: 0.92,
                    //       ),
                    //       itemBuilder: (context, index) {
                    //         return GestureDetector(
                    //           onTap: () {
                    //             screenPush(
                    //                 context,
                    //                 UserProfile(
                    //                   userData: Store().likedUsers[index]));
                    //           },
                    //           child: Container(
                    //             margin: const EdgeInsets.symmetric(
                    //                 horizontal: 16, vertical: 5),
                    //             width: size.width * 0.3,
                    //             decoration: BoxDecoration(
                    //                 color: AppColors.i.whiteColor,
                    //                 borderRadius: BorderRadius.circular(35),
                    //                 image: DecorationImage(
                    //                     image: NetworkImage(Store()
                    //                         .likedUsers[index]
                    //                         .photoUrl),
                    //                     fit: BoxFit.fill)),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
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
}
