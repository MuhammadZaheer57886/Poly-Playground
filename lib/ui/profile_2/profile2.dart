import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poly_playground/ui/payment/payment.dart';

import '../../common/nav_function.dart';
import '../../common/store.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/my_utils.dart';
import '_form.dart';

class Profile2 extends StatefulWidget {
  const Profile2({super.key});

  @override
  State<Profile2> createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  String image1 = '';
  String image2 = '';
  String image3 = '';
  String image4 = '';
  String profileImage = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              screenPushRep(context, const Payment());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Image.asset(
                  'assets/icon.png',
                  width: 60,
                  height: 60,
                ),
                const Text(
                  'Profile', // replace with your screen title
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(height: size.height * 0.05),
                addPhotos(
                    size, context, Store().userData.photoUrl, profileImage),
                SizedBox(height: size.height * 0.05),
                const ProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row addPhotos(
      Size size, BuildContext context, String imageUrl, String imagePath) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.22,
                  decoration: BoxDecoration(
                    color: AppColors.i.brownColor,
                    borderRadius: BorderRadius.circular(15),
                    image: imageUrl.isNotEmpty || imagePath.isNotEmpty
                        ? DecorationImage(
                            image: imagePath.isEmpty
                                ? NetworkImage(Store().userData.photoUrl)
                                : FileImage(File(imagePath)) as ImageProvider,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                Positioned(
                  right: 0.05,
                  top: 0.05,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.09,
                    height: size.width * 0.09,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.mode_edit,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 14),
        Column(
          children: [
            GestureDetector(
                onTap:()=> setImage1(),
                child: takePictureBox(
                    context, size, Store().userData.image1, image1)),
            const SizedBox(height: 20),
            GestureDetector(
                onTap:()=> setImage2(),
                child: takePictureBox(
                    context, size, Store().userData.image2, image2)),
          ],
        ),
        const SizedBox(width: 14),
        Column(
          children: [
            GestureDetector(
                onTap:()=> setImage3(),
                child: takePictureBox(
                    context, size, Store().userData.image3, image3)),
            const SizedBox(height: 20),
            GestureDetector(
                onTap:()=> setImage4(),
                child: takePictureBox(
                    context, size, Store().userData.image4, image4)),
          ],
        ),
      ],
    );
  }

  Widget takePictureBox(
      BuildContext context, Size size, String imageUrl, String imagePath) {
    return Stack(
      children: [
        Container(
          width: size.width * 0.2,
          height: size.height * 0.10,
          decoration: BoxDecoration(
              color: AppColors.i.brownColor,
              image: imageUrl.isNotEmpty || imagePath.isNotEmpty
                  ? DecorationImage(
                      image: imagePath.isEmpty
                          ? NetworkImage(imageUrl)
                          : FileImage(File(imagePath)) as ImageProvider,
                      fit: BoxFit.cover,
                    )
                  : null,
              borderRadius: BorderRadius.circular(15)),
        ),
        Positioned(
          right: 0.02,
          top: 0.02,
          child: Container(
            alignment: Alignment.center,
            width: size.width * 0.06,
            height: size.width * 0.06,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Icon(
              Icons.mode_edit,
              color: Colors.grey,
              size:  15,
            ),
          ),
        ),
      ],
    );
  }

  void setImage1() {
    getImageFromUser().then((value) {
      setState(() {
        image1 = value;
      });
      uploadImage(value).then((val) {
        Store().userData.image1 = val;
      });
    });
  }
  void setImage2() {
    getImageFromUser().then((value) {
      setState(() {
        image2 = value;
      });
      uploadImage(value).then((val) {
        Store().userData.image2 = val;

      });
    });
  }
  void setImage3() {
    getImageFromUser().then((value) {
      setState(() {
        image3 = value;
      });
      uploadImage(value).then((val) {
        Store().userData.image2 = val;
      });
    });
  }
  void setImage4() {

    getImageFromUser().then((value) {
      setState(() {
        image4 = value;
      });
      uploadImage(value).then((val) {
        Store().userData.image2 = val;
      });
    });
  }
}
