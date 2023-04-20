import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/pop_message.dart';
import 'package:poly_playground/provider/internet_provider.dart';
import 'package:poly_playground/provider/sign_in_provider.dart';
import 'package:poly_playground/ui/authentication/phone/phone_number_screen.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import 'package:poly_playground/utils/constants/app_strings.dart';
import 'package:provider/provider.dart';
import '../home/home_screen.dart';
import 'login/login_screen.dart';
import 'signup/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.i.darkBrownColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                    width: size.width,
                    height: size.height * 0.21,
                    child: Image.asset("assets/icon.png")),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  AppStrings.i.appName,
                  style: TextStyle(
                    color: AppColors.i.whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.055,
                  ),
                ),
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
                loginButton(size, AppStrings.i.email, "assets/email.png", () {
                  screenPushRep(
                    context, const Loginwidget());
                }),
                const SizedBox(
                  height: 15,
                ),
                loginButton(size, AppStrings.i.google, "assets/google.png", () {
                  handleGoogleSignIn();
                  
                }),
                const SizedBox(
                  height: 15,
                ),
                loginButton(size, AppStrings.i.facebook, "assets/facebook.png",
                    () {
                  showFailedToast(context, "Coming soon");
                }),
                const SizedBox(
                  height: 15,
                ),
                loginButton(size, AppStrings.i.phoneNumber, "assets/phone.png",
                    () {
                  screenPush(context, const PhoneNumberScreen());
                }),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35.0),
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
              )
            ],
          ),
        )
        );
  }

  Widget loginButton(
      Size size, String text, String imageAddress, Function() onTap) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: size.width * 0.8,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.i.whiteColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Image.asset(imageAddress),
              Text(text,
                  style: TextStyle(
                    color: AppColors.i.blackColor,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(),
              const SizedBox(),
            ],
          ),
        ));
  }
  //handling google sign in
  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    // interner provider
    final ip = context.read<InternetProvider>();

    await ip.checkInternetConnection();
    if (ip.hasInternet == false) {
      showFailedToast(context, "No internet connection");

    } else {
      await sp.signInWithGoogle().then((value) async{
        if (sp.hasError == true) {
          showFailedToast(context, sp.errorCode.toString());
        } else {
          sp.checkUserExist().then((value) async{
            if(value ==true){
              // user exist
              sp.getUserDataFromFireStore(sp.uid).then((value) => 
              sp.saveDataToSharedPref().then( (value) => sp.setSignIn().then((value) => {
                handleAfterSignIn(),
              }))
              );

            }else{
              // user does not exist
              sp.saveUserDataToFireStore().then((value) => sp
              .saveDataToSharedPref().then((value)=> sp.setSignIn().then((value) => {
                handleAfterSignIn(),
              })));
            }
          });
        }
      });
      
  }
}
// handeling after sign in
  void handleAfterSignIn() {
    Future.delayed(const Duration(seconds: 3), () {
      screenPush(context, const HomeScreen());
    });
  }
}