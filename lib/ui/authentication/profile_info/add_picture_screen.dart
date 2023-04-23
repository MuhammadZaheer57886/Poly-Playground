import 'dart:io';
import 'package:flutter/material.dart';
import '../../../common/nav_function.dart';
import '../../../common/pop_message.dart';
import '../../../common/store.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/my_utils.dart';
import '../../payment/payment.dart';
import '../../ui_components/simple_button.dart';

class AddPictureScreen extends StatefulWidget {
  const AddPictureScreen({Key? key}) : super(key: key);

  @override
  State<AddPictureScreen> createState() => _AddPictureScreenState();
}

class _AddPictureScreenState extends State<AddPictureScreen> {
  String image1 = Store().userData.image1;
  String image2 = Store().userData.image2;
  String image3 = Store().userData.image3;
  String image4 = Store().userData.image1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (isLoading) {
      return Scaffold(
        body: Container(
          color: Colors.transparent,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.i.darkBrownColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              "Your Pictures",
              style: TextStyle(
                color: AppColors.i.blackColor,
                fontWeight: FontWeight.w700,
                fontSize: size.width * 0.05,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Please insert at least one of your photos...",
              style: TextStyle(
                color: AppColors.i.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.035,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                takePictureBox(context, size, setFirstImage, image1),
                takePictureBox(context, size, setSecImage, image2),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                takePictureBox(context, size, setThirdImage, image3),
                takePictureBox(context, size, setFourthImage, image4),
              ],
            ),
            SizedBox(
              height: size.height * 0.25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleButton(
                    title: "CONTINUE",
                    onTap: () => updateUser()),


              ],
            )
          ],
        ),
      ),
    );
  }

  Widget takePictureBox(
      BuildContext context, Size size, VoidCallback onTap, String image) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size.width * 0.3,
            height: size.height * 0.15,
            decoration: BoxDecoration(
                color: AppColors.i.brownColor,
                borderRadius: BorderRadius.circular(15)),
          ),
          image.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  width: size.width * 0.09,
                  height: size.width * 0.09,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                )
              : Container(
                  width: size.width * 0.3,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(File(image)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ), //
        ],
      ),
    );
  }

  void setFirstImage() async {
    final img = await getImageFromUser();
    setState(() {
      image1 = img;
    });
    Store().userData.image1 = img;
  }

  void setSecImage() async {
    final img = await getImageFromUser();
    setState(() {
      image2 = img;
    });
    Store().userData.image2 = img;
  }

  void setThirdImage() async {
    final img = await getImageFromUser();
    setState(() {
      image1 = img;
    });
    Store().userData.image3 = img;
  }

  void setFourthImage() async {
    final img = await getImageFromUser();
    setState(() {
      image4 = img;
    });
    Store().userData.image4 = img;
  }

  void updateUser() async {
    setState(() {
      isLoading = true;
    });
    final userData = Store().userData;
    if (userData.image1.isEmpty &&
        userData.image2.isEmpty &&
        userData.image3.isEmpty &&
        userData.image4.isEmpty) {
      setState(() {
        isLoading = false;
      });
      showFailedToast(context, "Pleas insert atleast on image");
    }
    try {
      userData.photoUrl = await uploadImage(userData.photoUrl);
      userData.image1 = await uploadImage(userData.image1);
      userData.image2 = await uploadImage(userData.image2);
      userData.image3 = await uploadImage(userData.image3);
      userData.image4 = await uploadImage(userData.image4);
    } catch (e) {
      showFailedToast(context, "check your internet connection");
      setState(() {
        isLoading = false;
      });
      return;
    }
    final v = updateUserInFirestore(userData);
    if (v) {
      setState(() {
        isLoading = false;
      });
      showSuccessToast(context, "Welcome");
      screenPush(context, const Payment());
      return;
    }
    setState(() {
      isLoading = false;
    });
  }
}
