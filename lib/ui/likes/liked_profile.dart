import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/chat/chat_screen.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import 'package:poly_playground/ui/likes/full_screen_image.dart';
import 'package:poly_playground/utils/firebase_utils.dart';
import '../../../utils/constants/app_colors.dart';
import '../../common/store.dart';
import '../../utils/my_utils.dart';

class UserProfile extends StatefulWidget {
  final UserDataModel userData;
  final bool isLiked;

  const UserProfile({Key? key, required this.userData, required this.isLiked})
      : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserDataModel userData;
  late bool isLiked = false;
  bool newLike = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = widget.userData;
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            if (newLike)
              screenPush(context, const HomeScreen());
            else
              Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.i.whiteColor,
          ),
        ),
        title: Text(
          userData.role,
          style: TextStyle(
              color: AppColors.i.whiteColor,
              fontSize: size.width * 0.055,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: isLiked
                ? IconButton(
                    onPressed: () {
                      unLike(userData);
                    },
                    icon: Icon(
                      Icons.delete_rounded,
                      color: AppColors.i.whiteColor,
                      size: size.height * 0.035,
                    ))
                : IconButton(
                    onPressed: () {
                      like(userData.uid);
                    },
                    icon: Icon(
                      Icons.favorite_border_rounded,
                      color: AppColors.i.whiteColor,
                      size: size.height * 0.035,
                    )),
          ),
        ],
      ),
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
                AppColors.i.darkBrownColor.withOpacity(0.4),
              ]),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          screenPush(
                              context, FullScreenImage(userData.photoUrl));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: AppColors.i.whiteColor,
                            backgroundImage: NetworkImage(userData.photoUrl),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData.name,
                            style: TextStyle(
                                color: AppColors.i.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * 0.065),
                          ),
                          Text(
                            userData.job,
                            style: TextStyle(
                                color: AppColors.i.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * 0.05),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.1,
                      ),
                      Column(
                        children: [
                          isLiked
                              ? IconButton(
                                  onPressed: () {
                                    screenPush(
                                        context,
                                        ChatScreen(
                                          receiverId: userData.uid,
                                        ));
                                  },
                                  icon: Icon(
                                    Icons.message_rounded,
                                    color: AppColors.i.whiteColor,
                                    size: size.height * 0.035,
                                  ),
                                )
                              : const SizedBox(
                                  height: 55,
                                ),
                          const SizedBox(
                            height: 14,
                          ),
                          isLiked
                              ? IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.video_call_rounded,
                                    color: AppColors.i.whiteColor,
                                    size: size.height * 0.04,
                                  ))
                              : Container(height: 55),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: size.width * 0.85,
                        height: 20,
                        decoration: BoxDecoration(
                            color:
                                AppColors.i.darkBrownColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.35,
                            height: 20,
                            decoration: BoxDecoration(
                                color: AppColors.i.darkBrownColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Level 3",
                            style: TextStyle(color: AppColors.i.whiteColor),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    "About me",
                    style: TextStyle(
                        color: AppColors.i.blackColor,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    userData.intro,
                    style: TextStyle(
                        color: AppColors.i.blackColor,
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(
                    children: [
                      interestWidget("Hiking", () {}),
                      interestWidget("Art", () {}),
                      interestWidget("Movie", () {}),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Text(
                    "Pictures",
                    style: TextStyle(
                        color: AppColors.i.blackColor,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      takePictureBox(context, size, userData.image1),
                      takePictureBox(context, size, userData.image2),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget takePictureBox(BuildContext context, Size size, String? imageUrl) {
    DecorationImage? dImage;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      dImage = DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      );
    }
    return Container(
      width: size.width * 0.35,
      height: size.height * 0.24,
      decoration: BoxDecoration(
        color: AppColors.i.brownColor,
        borderRadius: BorderRadius.circular(18),
        image: dImage,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2)
        ],
      ),
    );
  }

  Widget interestWidget(String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
            color: AppColors.i.whiteColor,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.i.blackColor,
          ),
        ),
      ),
    );
  }

  void unLike(UserDataModel user) async {
    bool isRemoved = await removeLike(user.uid);
    if (isRemoved) {
      bool disLiked = await dislikeUser(user.uid);
      if (disLiked) {
        Store().likedUsers.remove(user);
        Store().likedUsersIds.remove(user.uid);

        setState(() {
          isLiked = false;
          newLike = true;
        });
      }
    }

  }

  void like(String uid) async {
    bool isLike = await likeUser(uid);
    if (isLike) {
      setState(() {
        isLiked = true;
        newLike = true;
      });
    }
  }
}
