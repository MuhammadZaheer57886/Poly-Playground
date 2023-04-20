import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/pop_message.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/ui_components/simple_button.dart';
import 'package:poly_playground/utils/constants/app_strings.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/phoneUtils.dart';
import '../../home/home_screen.dart';
import '../../ui_components/custom_text_field.dart';
import '../phone/phone_number_screen.dart';

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
  final _auth = FirebaseAuth.instance;
  // PhoneNumberScreen phoneNumScreen = PhoneNumberScreen();
  String? emailError;
  String? passError;
  String? conPassError;
  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPass.dispose();
    controllerConPass.dispose();
    super.dispose();
  }
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
    //  String? emailError;
    return Form(
      key: _formkey,
      child: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          CustomTextField(
            titleText: AppStrings.i.emailTxt.toString().toUpperCase(),
            imageAddress: "assets/email.png",
            controller: controllerEmail,
            errorText: emailError,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            titleText: AppStrings.i.pass.toString().toUpperCase(),
            imageAddress: "assets/lock.png",
            controller: controllerPass,
            obscuretext: true,
            errorText: passError,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            titleText: AppStrings.i.confirmPass.toString().toUpperCase(),
            imageAddress: "assets/lock.png",
            controller: controllerConPass,
            errorText: conPassError,
            obscuretext: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(
            height: 25,
          ),
          SimpleButton(title: "CREATE", 
          onTap: ()async{
            await signUpFun( controllerEmail.text, controllerPass.text, controllerConPass.text);
          }  
          )
        ],
      ),
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
        SimpleButton(title: "CREATE", onTap: () {
          PhoneUtils.onContinuePressed(context, controllerPhoneNum.text);
        })
      ],
    );
  }

 signUpFun(String email, String password,String confirmPass)async {
    // final isValid = _formkey.currentState!.validate();
    // if (!isValid) return;
    bool isValid = EmailValidator.validate(email);
    bool isValidPass = password.length >= 6;
    bool isValidConPass = confirmPass == password;
    if (!isValid && !isValidPass) {
      setState(() {
        emailError = "Please enter a valid email";
        passError = "Password must be at least 6 characters ";
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
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     });
    if (!isValidConPass) {
        setState(() {
        conPassError = "Password does not match";
      });
      return;
    }else{
      
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailstoFirestore()})
          .catchError((e) {
        showFailedToast(context, e.message!);
      });
    }
  }

  postDetailstoFirestore() async {
    // calling our firebase 
    FirebaseFirestore firebaseFirestore  = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    //calling our user model
    UserModel userModel = UserModel();
    //setting values to our user model
    userModel.email = user!.email;
    userModel.uid = user.uid;

    //sending valiues to firestore
    await firebaseFirestore.collection('users').doc(user.uid).set(userModel.toMap());
    
    showSuccessToast(context, 'Account created successfully');
     
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
