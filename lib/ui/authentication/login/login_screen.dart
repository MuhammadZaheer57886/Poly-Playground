import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import '../../../common/pop_message.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../ui_components/custom_text_field.dart';
import '../phone/phone_number_screen.dart';
import '../signup/signup_screen.dart';
import '../welcome_screen.dart';
import 'forgotpassword.dart';

class Loginwidget extends StatefulWidget {
  // final VoidCallback onClickedSignUp;
  const Loginwidget({
    super.key,
    // required this.onClickedSignUp
  });

  @override
  State<Loginwidget> createState() => LloginwidgetState();
}

class LloginwidgetState extends State<Loginwidget> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  //calling fire base
  final _auth = FirebaseAuth.instance;
  
  String? emailError;
  String? passError;
  

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.10,
              ),
              SizedBox(
                  width: size.width,
                  height: size.height * 0.21,
                  child: Image.asset("assets/icon.png")),
              SizedBox(
                height: size.height * 0.10,
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
                controller: controllerEmail,
                errorText: emailError,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                titleText: "PASSWORD",
                imageAddress: "assets/lock.png",
                controller: controllerPassword,
                obscuretext: true,
                errorText: passError,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        await _login(
                            controllerEmail.text, controllerPassword.text);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.1, vertical: 17),
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
                          onTap: () {
                            screenPush(context, const ForgotPasswordPage());
                          },
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
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  roundButton("assets/phone.png", size, () => screenPush(context, const PhoneNumberScreen())),
                  const SizedBox(
                    width: 20,
                  ),
                  roundButton("assets/google_g.png", size, () => screenPush(context, const WelcomeScreen())),
                  const SizedBox(
                    width: 20,
                  ),
                  roundButton("assets/facebook_round.png", size, () => screenPush(context, const WelcomeScreen())),
                ],
              ),
              const SizedBox(
                height: 10,
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
                    InkWell(
                      onTap: () {
                        screenPush(context, const SignUpScreen());
                      },
                      child: Text(
                        AppStrings.i.signUp,
                        style: TextStyle(
                          color: AppColors.i.whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.037,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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

  roundButton(String imageAddress, Size size, Function() onTap) {
    return InkWell(
      onTap: onTap,
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
  }_login(String email, String password) async {
  bool isValid = EmailValidator.validate(email);
  bool isValidPass = password.length >= 6;
  if (!isValid && !isValidPass) {
     setState(() {
      emailError = "Please enter a valid email";
      passError = "Password must be at least 6 characters";
    });

    // Show error messages for 3 seconds.
    Timer(const Duration(seconds: 4), () {
      setState(() {
        emailError = null;
        passError = null;
      });
    });

    return;
  }

  try {
    List<String> signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    if (signInMethods.contains('password')) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);

      showSuccessToast(context, "Login Successful");
      screenPush(context, const HomeScreen());
    } else {
      showFailedToast(context, "SIGNUP: Email not found");
    }
  } catch (e) {
    print(e);
    showFailedToast(context, e.toString());
  }
}
}
