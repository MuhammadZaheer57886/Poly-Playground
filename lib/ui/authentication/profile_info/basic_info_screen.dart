import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';

import '../../../utils/constants/app_colors.dart';
import '../../ui_components/custom_text_field.dart';
import '../../ui_components/simple_button.dart';
import '../basic_info2.dart';

class BasicInfoScreen extends StatefulWidget {
  final String? photoUrl;
  const BasicInfoScreen({Key? key, this.photoUrl}) : super(key: key);

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final TextEditingController controllerFullName = TextEditingController();
  final TextEditingController controllerJOB = TextEditingController();
  final TextEditingController controllerIntro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              "Base",
              style: TextStyle(
                color: AppColors.i.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.05,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: controllerFullName,
                titleText: 'Full Name',
                width: size.width * 0.88,
                radius: 15,
                isDark: false,
                pl: 20),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: controllerJOB,
                titleText: 'JOB',
                width: size.width * 0.88,
                radius: 15,
                isDark: false,
                pl: 20),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: controllerIntro,
                titleText: 'INTRODUCTION YOURSELF',
                width: size.width * 0.88,
                radius: 15,
                isDark: false,
                height: 150,
                pl: 20),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleButton(
                    title: "CONTINUE",
                    onTap: () {
                      updateBasicInfo();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
@override
  void initState() {
    // TODO: implement initState
      super.initState();
      print(widget.photoUrl);
  }
  void updateBasicInfo() async {
    // Check if any of the fields are empty
    if (controllerFullName.text.isEmpty ||
        controllerJOB.text.isEmpty ||
        controllerIntro.text.isEmpty ||
        widget.photoUrl == null) {
      return;
    }

    try {
      // Update the user's basic info in the Firebase Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'job': controllerJOB.text,
        'name': controllerFullName.text,
        'intro': controllerIntro.text,
        'photoUrl': widget.photoUrl,
      });

      // Navigate to the next screen
      screenPush(context, const BasicInfo2Screen());
    } catch (e) {
      // Handle any errors that may occur during the process
      print(e);
    }
  }
}
