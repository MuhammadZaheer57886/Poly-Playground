import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import 'package:poly_playground/ui/home/profile_screen/profile_screen.dart';
import '../../common/store.dart';
import '../../model/user_model.dart';
import '../../utils/constants/app_colors.dart';
import '../chat/chat_user_list.dart';

class LikedProfiles extends StatefulWidget {
  const LikedProfiles({Key? key}) : super(key: key);

  @override
  State<LikedProfiles> createState() => _LikedProfilesState();
}

class _LikedProfilesState extends State<LikedProfiles> {
  bool isLoading = true;

  @override
  void initState() async {
    super.initState();
    await getLikedProfiles();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
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
                color: Colors.white,
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

                        }, icon: Image.asset("assets/home.png")),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/video.png")),
                    IconButton(
                        onPressed: () {}, icon: Image.asset("assets/love.png")),
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
              Expanded(
                child: Stack(
                  children: [
                    GridView.builder(
                      itemCount: 6,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 1.0,
                          childAspectRatio: 0.92),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                              // image: DecorationImage(
                              //     image: AssetImage(
                              //         "assets/temp/${index + 1}.png"),
                              //     fit: BoxFit.fill)
                            ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<UserDataModel>> getLikedProfiles() async {
    final List<UserDataModel> likedProfiles = [];
    final List<String> likedProfileIds = [];
    QuerySnapshot docs = await FirebaseFirestore.instance.collection("users")
        .doc(Store().uid).collection("chats")
        .get();
    print(docs.docs.length);

    return [];
  }

  void getLiked = () async {
    // await getLikedProfiles();
    // setState(() {
    //   isLoading = false;
    // });
  };
}
