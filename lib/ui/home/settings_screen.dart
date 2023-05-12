import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/store.dart';
import 'package:poly_playground/ui/authentication/login/forgotpassword.dart';
import 'package:poly_playground/ui/authentication/welcome_screen.dart';
import 'package:poly_playground/ui/home/edit_profile_screen.dart';
import 'package:poly_playground/ui/ui_components/simple_button.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import 'package:poly_playground/utils/firebase_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.i.darkBrownColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.i.whiteColor,
          ),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
              color: AppColors.i.whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: size.width * 0.055),
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
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.09,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: AppColors.i.whiteColor),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.08,
                      backgroundColor: AppColors.i.greyColor,
                      backgroundImage: NetworkImage(Store().userData.photoUrl),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Store().userData.fullName.toUpperCase(),
                          style: TextStyle(
                            color: AppColors.i.blackColor,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          Store().userData.email,
                          style: TextStyle(
                            color: AppColors.i.blackColor,
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                width: size.width,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  color: AppColors.i.whiteColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Switch to Dark Mode",
                      style: TextStyle(
                          color: AppColors.i.blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.05),
                    ),
                    const Spacer(),
                    Switch(
                        activeColor: Colors.black12,
                        value: Store().isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            Store().isDarkMode = value;
                          });
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              InkWell(
                onTap: () {
                  screenPush(context, const EditProfileScreen());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: size.width,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    color: AppColors.i.whiteColor,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: AppColors.i.blackColor,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  screenPush(context, const ForgotPasswordPage());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: size.width,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    color: AppColors.i.whiteColor,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Change Password",
                        style: TextStyle(
                          color: AppColors.i.blackColor,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.09,
              ),
              SimpleButton(
                  title: "Log Out",
                  onTap: () async {
                    // await logOut() ? screenPush(context, const HomeScreen()) : '';
                    final v = await logOut();
                    if (v) {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        screenPushBackUntil(context, const WelcomeScreen());
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
