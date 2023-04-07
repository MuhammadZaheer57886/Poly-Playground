import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';

import '../../utils/constants/app_colors.dart';
import '../ui_components/simple_button.dart';
import 'add_picture_screen.dart';

class BasicInfo2Screen extends StatefulWidget {
  const BasicInfo2Screen({Key? key}) : super(key: key);

  @override
  State<BasicInfo2Screen> createState() => _BasicInfo2ScreenState();
}

class _BasicInfo2ScreenState extends State<BasicInfo2Screen> {
  String role = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: "Day", border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: "Month", border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: "Year", border: InputBorder.none),
                  ),
                )
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
            Container(
              padding: const EdgeInsets.only(left: 20, top: 2),
              width: size.width * 0.88,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Town",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
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
            Container(
              padding: const EdgeInsets.only(left: 20, top: 2),
              width: size.width * 0.88,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Town",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height * 0.12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleButton(
                    title: "CONTINUE",
                    onTap: () {
                      screenPush(context, const AddPictureScreen());
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
