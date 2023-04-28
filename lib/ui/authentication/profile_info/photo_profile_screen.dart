import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/ui_components/simple_button.dart';
import 'dart:io';
import '../../../common/pop_message.dart';
import '../../../common/store.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/firebase_utils.dart';
import '../../../utils/my_utils.dart';
import 'basic_info_screen.dart';

class PhotoProfileScreen extends StatefulWidget {
  const PhotoProfileScreen({Key? key}) : super(key: key);

  @override
  State<PhotoProfileScreen> createState() => _PhotoProfileScreenState();
}

class _PhotoProfileScreenState extends State<PhotoProfileScreen> {
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.2,
              ),
              Text(
                "Profile Picture",
                style: TextStyle(
                  color: AppColors.i.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.05,
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: size.height * 0.08),
                width: size.width * 0.4,
                height: size.width * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: imageUrl.isNotEmpty
                      ? Colors.transparent
                      : const Color(0xffB40303),
                  image: imageUrl.isNotEmpty
                      ? DecorationImage(
                          image: FileImage(File(imageUrl)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              //
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.16,
                  ),
                  width: size.width * 0.65,
                  height: 45,
                  child: Text(
                    "INSERT YOUR PHOTO",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.25,
              ),
              SimpleButton(
                title: "CONTINUE",
                onTap: () => setProfile(),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void getImage() {
    getImageFromUser().then((value) {
      if (value.isEmpty) {
        showFailedToast(context, 'Please insert your photo.');
        return;
      }
      setState(() {
        imageUrl = value;
      });
    });
  }

  void setProfile() {
    uploadImage(imageUrl).then((value) {
      if (value.isEmpty) {
        showFailedToast(context, 'Please insert your photo.');
        return;
      }
      Store().userData.photoUrl = value;
      if(updateUserInFirestore(Store().userData)){
        screenPush(context, const BasicInfoScreen());
        return;
      }
      showFailedToast(context, 'Something went wrong please try again ');
    });
  }
}
