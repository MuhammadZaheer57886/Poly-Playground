import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/authentication/profile_info/photo_profile_screen.dart';
import 'package:poly_playground/ui/authentication/welcome_screen.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';

import '../../common/store.dart';
import '../../model/user_model.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Store().isLogedIn = false;
        } else {
          Store().uid = user.uid;
          Store().isLogedIn = true;
        }
      });
      Timer(const Duration(seconds: 2), () {
        if(Store().isLogedIn){
            screenPush(context, const HomeScreen());
        }
        else{
          screenPush(context, const WelcomeScreen());
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.i.darkBrownColor,
      body: Center(
        child: Image.asset("assets/icon.png"),
      ),
    );
  }
}
