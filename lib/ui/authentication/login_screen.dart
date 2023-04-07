import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/ui_components/custom_text_field.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';

import '../../utils/constants/app_strings.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

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
              AppColors.i.darkBrownColor,
              AppColors.i.darkBrownColor.withOpacity(0.4),
            ])),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.12,
            ),
            SizedBox(
                width: size.width,
                height: size.height * 0.21,
                child: Image.asset("assets/icon.png")),
            SizedBox(
              height: size.height * 0.12,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Text(
                AppStrings.i.welcomeMsg,
                style: TextStyle(
                  color: AppColors.i.whiteColor,
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.035,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            CustomTextField(
                titleText: "E-MAIL",
                imageAddress: "assets/email.png",
                controller: controllerEmail),
            const SizedBox(
              height: 12,
            ),
            CustomTextField(
                titleText: "PASSWORD",
                imageAddress: "assets/lock.png",
                controller: controllerPassword),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      screenPush(context, const HomeScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.12, vertical: 17),
                      decoration: BoxDecoration(
                        color: AppColors.i.darkBrownColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: AppColors.i.whiteColor,
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot your password ?",
                          style: TextStyle(
                            color: AppColors.i.blackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                roundButton("assets/phone.png", size, () => null),
                const SizedBox(
                  width: 20,
                ),
                roundButton("assets/google_g.png", size, () => null),
                const SizedBox(
                  width: 20,
                ),
                roundButton("assets/facebook_round.png", size, () => null),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      AppStrings.i.doNotHaveAnAccount,
                      style: TextStyle(
                        color: AppColors.i.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    AppStrings.i.signUp,
                    style: TextStyle(
                      color: AppColors.i.whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.037,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  roundButton(String imageAddress, Size size, Function() onTap) {
    return InkWell(
      child: Container(
        width: size.width * 0.15,
        height: size.width * 0.15,
        decoration: BoxDecoration(
            color: AppColors.i.whiteColor, shape: BoxShape.circle),
        child: Image.asset(
          imageAddress,
        ),
      ),
    );
  }

  Widget loginButton(Size size, String titleText, String imageAddress,
      TextEditingController controller) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 10, top: 4),
        width: size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.i.whiteColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: titleText,
              prefixIcon: Image.asset(
                imageAddress,
              )),
        ));
  }
}
