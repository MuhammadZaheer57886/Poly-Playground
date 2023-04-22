import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
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
  void getUserData(String userId) async {
    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      return;
    }

    UserDataModel.fromMap(Store().userData,userDoc.data() as Map<String, dynamic>);
    return;
  }
  // bool islogin = false;
  @override
  void initState() {

    super.initState();
    // Timer(const Duration(seconds: 2), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          // screenPushRep(context, const WelcomeScreen());
          Store().isLogedIn = false;
        } else {
          Store().isLogedIn = true;
          getUserData(user.uid);
          // screenPushRep(context, const HomeScreen());
          // print("Splach"+Store().userData.name);
        }
      });
      Timer(Duration(seconds: 2), () {
        Store().isLogedIn == false
            ? screenPushRep(context, const WelcomeScreen())
            : screenPushRep(context, const HomeScreen());
      });

    //   sp.isSignedIn == false
    //       ? screenPushRep(context, const WelcomeScreen())
    //       : screenPushRep(context, const PhotoProfileScreen());
    // });

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
