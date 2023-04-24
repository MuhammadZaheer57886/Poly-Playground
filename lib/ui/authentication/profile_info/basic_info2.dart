// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';

import '../../../common/pop_message.dart';
import '../../../common/store.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/my_utils.dart';
import '../../ui_components/custom_text_field.dart';
import '../../ui_components/simple_button.dart';
import 'add_picture_screen.dart';

class BasicInfo2Screen extends StatefulWidget {
  const BasicInfo2Screen({Key? key}) : super(key: key);

  @override
  State<BasicInfo2Screen> createState() => _BasicInfo2ScreenState();
}

class _BasicInfo2ScreenState extends State<BasicInfo2Screen> {
  String role = Store().userData.role;
  final TextEditingController controllerDay = TextEditingController(
      text: Store().userData.date.isEmpty
          ? ''
          : Store().userData.date.split('/')[0]);
  final TextEditingController controllerMonth = TextEditingController(
      text: Store().userData.date.isEmpty
          ? ''
          : Store().userData.date.split('/')[1]);
  final TextEditingController controllerYear = TextEditingController(
      text: Store().userData.date.isEmpty
          ? ''
          : Store().userData.date.split('/')[2]);
  final TextEditingController controllerCity =
      TextEditingController(text: Store().userData.city);
  final TextEditingController controllerTown =
      TextEditingController(text: Store().userData.town);

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
                        "Griffin",
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
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  titleText: "Month",
                  width: size.width * 0.25,
                  controller: controllerMonth,
                  keyboardType: TextInputType.number,
                  isDark: false,
                  radius: 15,
                ),
                CustomTextField(
                  titleText: "Year",
                  width: size.width * 0.25,
                  keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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
                      if (updateInfo()) {
                        screenPush(context, const AddPictureScreen());
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool updateInfo() {
    if (controllerDay.text.isEmpty ||
        controllerMonth.text.isEmpty ||
        controllerYear.text.isEmpty ||
        controllerCity.text.isEmpty ||
        controllerTown.text.isEmpty) {
      showFailedToast(context, "Please fill all fields");
      return false;
    }
    final date = '${controllerMonth.text}/${controllerDay.text}/${controllerYear.text}';
    if (!isValidDate(date)) {
      showFailedToast(context, 'invalid date');
      return false;
    }
    Store().userData.role = role;
    Store().userData.date = date;
    Store().userData.city = controllerCity.text;
    Store().userData.town = controllerTown.text;
    return true;
  }
}
