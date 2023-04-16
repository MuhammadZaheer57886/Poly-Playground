import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/pop_message.dart';

import '../../../utils/constants/app_colors.dart';
import '../../ui_components/custom_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController controllerEmail = TextEditingController();
  String? emailError;
  @override
  void dispose() {
    controllerEmail.dispose();      
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.i.darkBrownColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
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
              AppColors.i.darkBrownColor,
              AppColors.i.darkBrownColor.withOpacity(0.4),
            ])),
        child: SingleChildScrollView(
          child: Column(children: [
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
              height: size.height * 0.04,
            ),
            CustomTextField(
              titleText: "E-MAIL",
              imageAddress: "assets/email.png",
              controller: controllerEmail,
              errorText: emailError,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            InkWell(
                      onTap: resetPassword,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.12, vertical: 17),
                        decoration: BoxDecoration(
                          color: AppColors.i.darkBrownColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            color: AppColors.i.whiteColor,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
          ]
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
     bool isValid = EmailValidator.validate(controllerEmail.text);
    if (!isValid ) {
      setState(() {
        emailError = "Please enter a valid email";
      });
      return;
    }
    showDialog(context: context, builder: (context) => 
    const Center(child: CircularProgressIndicator()));
    try{
      await FirebaseAuth.instance
      .sendPasswordResetEmail(email: controllerEmail.text.trim());
    
      // showSuccessToast(context, 'Password reset link sent to your email');
      Future.microtask(() => showSuccessToast(context, 'Password reset link sent to your email'));
      Navigator.of(context).pop();
      // Future.microtask(() => Navigator.of(context).pop());
    
    } on FirebaseAuthException catch (e) {
      print(e);
      showFailedToast(context, e.message!);
      Navigator.of(context).pop();
    }
  }
}
