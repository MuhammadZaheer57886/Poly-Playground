import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/authentication/photo_profile_screen.dart';
import 'package:poly_playground/ui/ui_components/simple_button.dart';
import 'package:poly_playground/utils/constants/app_strings.dart';

import '../../utils/constants/app_colors.dart';
import '../ui_components/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();
  final TextEditingController controllerConPass = TextEditingController();
  final TextEditingController controllerPhoneNum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
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
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                alignment: Alignment.center,
                width: size.width,
                height: size.height * 0.18,
                child: Text(
                  "Register your account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                width: size.width * 0.8,
                child: TabBar(
                  dividerColor: Colors.white,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Text(
                      "By email",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    Text(
                      "By Telephone",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  byEmailSignUp(size, context),
                  byTelephone(size, context),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget byEmailSignUp(Size size, BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        CustomTextField(
            titleText: AppStrings.i.emailTxt.toString().toUpperCase(),
            imageAddress: "assets/email.png",
            controller: controllerEmail),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
            titleText: AppStrings.i.pass.toString().toUpperCase(),
            imageAddress: "assets/lock.png",
            controller: controllerPass),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
            titleText: AppStrings.i.confirmPass.toString().toUpperCase(),
            imageAddress: "assets/lock.png",
            controller: controllerConPass),
        const SizedBox(
          height: 25,
        ),
        SimpleButton(title: "CREATE", onTap: () {
          screenPush(context, PhotoProfileScreen());
        })
      ],
    );
  }

  Widget byTelephone(Size size, BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        CustomTextField(
            titleText: AppStrings.i.phoneNumberTxt.toString().toUpperCase(),
            imageAddress: "assets/phone.png",
            controller: controllerPhoneNum),
        const SizedBox(
          height: 25,
        ),
        SimpleButton(
            title: "CREATE",
            onTap: () {
            })
      ],
    );
  }
}
