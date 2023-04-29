import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/likes/full_screen_image.dart';
import 'package:provider/provider.dart';
import '../../../common/store.dart';
import '../../../provider/sign_in_provider.dart';
import '../../../utils/constants/app_colors.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_colors.dart';
import '../home/settings_screen.dart';

class LikedProfile extends StatefulWidget {
  final UserDataModel userData;

  const LikedProfile({Key? key, required this.userData}) : super(key: key);

  @override
  State<LikedProfile> createState() => _LikedProfileState();
}

class _LikedProfileState extends State<LikedProfile> {
  late UserDataModel userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = widget.userData;
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.read<SignInProvider>();
    final Size size = MediaQuery.of(context).size;
    return Hero(
      tag: "profile",
      transitionOnUserGestures: true,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width * 0.055,
                fontWeight: FontWeight.w600),
          ),
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
              ])),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            screenPush(
                                context, FullScreenImage(userData.photoUrl));
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(userData.photoUrl),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.width * 0.06),
                            ),
                            Text(
                              userData.job,
                              style: TextStyle(
                                  color: AppColors.i.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.width * 0.037),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  color: AppColors.i.redColor,
                                  size: size.height * 0.05,
                                )),
                            Text(
                              "0",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.width * 0.037),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Stack(
                        children: [
                          Container(
                            width: size.width * 0.9,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
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
                              const Text(
                                "Level 3",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "About me",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      // "[bio]",
                      userData.bio,
                      style: TextStyle(
                          color: Colors.black,
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
                          color: Colors.black,
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
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
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
        ),
      ],
    );
  }

  Widget interestWidget(String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
