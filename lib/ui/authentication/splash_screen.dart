import 'dart:async';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/provider/sign_in_provider.dart';
import 'package:poly_playground/ui/authentication/welcome_screen.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';
import 'profile_info/photo_profile_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool islogin = false;
  @override
  void initState() {
    final SignInProvider sp = context.read<SignInProvider>();
    super.initState();
    //create a timer of 2 seconds
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? screenPushRep(context, const WelcomeScreen())
          : screenPushRep(context, const PhotoProfileScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.i.darkBrownColor,
      body: Center(
        child: Image.asset("assets/icon.png"),
      ),
    );
  }
}
