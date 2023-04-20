import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';

import '../../../common/pop_message.dart';
import '../../../utils/constants/app_colors.dart';
import '../../ui_components/custom_text_field.dart';
import '../../ui_components/simple_button.dart';
import 'add_picture_screen.dart';

class BasicInfo2Screen extends StatefulWidget {
  const BasicInfo2Screen({Key? key}) : super(key: key);

  @override
  State<BasicInfo2Screen> createState() => _BasicInfo2ScreenState();
}

class _BasicInfo2ScreenState extends State<BasicInfo2Screen> {
  String role = "";
  String date = "";
  String city = "";
  String town = "";
  final TextEditingController controllerDay = TextEditingController();
  final TextEditingController controllerMonth = TextEditingController();
  final TextEditingController controllerYear = TextEditingController();
  final TextEditingController controllerCity = TextEditingController();
  final TextEditingController controllerTown = TextEditingController();

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
        height: size.height * 0.9,
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
              "Role",
              style: TextStyle(
                color: AppColors.i.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.05,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.25,
                      child: Text(
                        "Unicorn",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ),
                    Radio(
                        value: "unicorn",
                        groupValue: role,
                        onChanged: (value) {
                          setState(() {
                            role = value as String;
                          });
                        })
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.25,
                      child: Text(
                        "Unicorn",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ),
                    Radio(
                        value: "Griffin",
                        groupValue: role,
                        onChanged: (value) {
                          setState(() {
                            role = value as String;
                          });
                        })
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.25,
                      child: Text(
                        "Couple",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ),
                    Radio(
                        value: "Couple",
                        groupValue: role,
                        onChanged: (value) {
                          setState(() {
                            role = value as String;
                          });
                        })
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.25,
                      child: Text(
                        "Undecided",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ),
                    Radio(
                        value: "Undecided",
                        groupValue: role,
                        onChanged: (value) {
                          setState(() {
                            role = value as String;
                          });
                        })
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Date of Birth",
              style: TextStyle(
                color: AppColors.i.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.05,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  titleText: "Day",
                  width: size.width * 0.25,
                  controller: controllerDay,
                  isDark: false,
                  radius: 15,
                ),
                CustomTextField(
                  titleText: "Month",
                  width: size.width * 0.25,
                  controller: controllerMonth,
                  isDark: false,
                  radius: 15,
                ),
                CustomTextField(
                  titleText: "Year",
                  width: size.width * 0.25,
                  controller: controllerYear,
                  isDark: false,
                  radius: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Select your city:",
              style: TextStyle(
                color: AppColors.i.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.045,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                titleText: "City",
                width: size.width * 0.88,
                controller: controllerCity,
                isDark: false,
                radius: 15,
                pl: 20),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Choose your country:",
              style: TextStyle(
                color: AppColors.i.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.045,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                titleText: "Town",
                width: size.width * 0.88,
                controller: controllerTown,
                isDark: false,
                radius: 15,
                pl: 20),
            SizedBox(
              height: size.height * 0.08,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleButton(
                    title: "CONTINUE",
                    onTap: () {
                      setDate();
                      updateInfo();
                      // screenPush(context, const AddPictureScreen());
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  void setDate() {
    if (controllerDay.text.isNotEmpty &&
        controllerMonth.text.isNotEmpty &&
        controllerYear.text.isNotEmpty &&
        controllerCity.text.isNotEmpty &&
        controllerTown.text.isNotEmpty) {
      if (int.parse(controllerDay.text) > 31 ||
          int.parse(controllerDay.text) < 1) {
        showFailedToast(context, "Please enter valid day");
      } else if (int.parse(controllerMonth.text) > 12 ||
          int.parse(controllerMonth.text) < 1) {
        showFailedToast(context, "Please enter valid month");
      } else if (int.parse(controllerYear.text) > 2021 ||
          int.parse(controllerYear.text) < 1900) {
        showFailedToast(context, "Please enter valid year");
      } else {
        setState(() {
          date =
              "${controllerDay.text}/${controllerMonth.text}/${controllerYear.text}";
          city = controllerCity.text;
          town = controllerTown.text;
        });
      }
    }
  }
  void updateInfo() {
    if (date.isNotEmpty && city.isNotEmpty && town.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "date": date,
        "city": city,
        "town": town,
        "role" : role ,
      }).then((value) {
        screenPush(context, const AddPictureScreen());
      });
    }
  }
}
