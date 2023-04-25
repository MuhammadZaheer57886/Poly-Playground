import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/ui_components/simple_button.dart';
import 'package:poly_playground/utils/my_utils.dart';
import '../../common/store.dart';
import '../../utils/constants/app_colors.dart';
import 'edit_profile_screen.dart';
import 'home_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  get fibaseAuth => null;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.i.darkBrownColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
              color: Colors.white,
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
        child: Column(
          children: [
            Container(
              width: size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(6),
                    width: size.width * 0.1,
                    height: size.width * 0.1,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/temp/5.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Store().userData.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        Store().userData.email,
                        style: TextStyle(
                          color: Colors.black,
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
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Switch to Dark Mode",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.04),
                  ),
                  const Spacer(),
                  Switch(
                      activeColor: Colors.black12,
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: Colors.black,
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
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: size.width,
                height: size.height * 0.08,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.black,
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
              height: size.height*0.09,
            ),
            SimpleButton(title: "Log Out", onTap: ()  async {
              await logOut() ? screenPush(context, const HomeScreen()) : '';


            })
          ],
        ),
      ),
    );
  }


}
