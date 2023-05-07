import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import '../../../common/pop_message.dart';
import '../../../common/store.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/firebase_utils.dart';
import '../../../utils/my_utils.dart';
import '../../ui_components/custom_text_field.dart';
import '../../ui_components/simple_button.dart';
import 'add_picture_screen.dart';

class BasicInfo2Screen extends StatefulWidget {
  const BasicInfo2Screen({Key? key}) : super(key: key);

  @override
  State<BasicInfo2Screen> createState() => _BasicInfo2ScreenState();
}

class _BasicInfo2ScreenState extends State<BasicInfo2Screen> {
  String role = "";
  final TextEditingController controllerDay = TextEditingController();
  final TextEditingController controllerMonth = TextEditingController();
  final TextEditingController controllerYear = TextEditingController();
  final TextEditingController controllerCity = TextEditingController();
  final TextEditingController controllerTown = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              AppColors.i.darkBrownColor,
              AppColors.i.darkBrownColor.withOpacity(0.4),
              AppColors.i.darkBrownColor.withOpacity(0.4),
            ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                "Role",
                style: TextStyle(
                  color: AppColors.i.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.05,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                        child: Text(
                          "Unicorn",
                          style: TextStyle(
                            color: AppColors.i.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.045,
                          ),
                        ),
                      ),
                      Radio(
                          value: "unicorn",
                          groupValue: role,
                          onChanged: (value) {
                            setState(() {
                              role = value as String;
                            });
                          })
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                        child: Text(
                          "Griffin",
                          style: TextStyle(
                            color: AppColors.i.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.045,
                          ),
                        ),
                      ),
                      Radio(
                          value: "Griffin",
                          groupValue: role,
                          onChanged: (value) {
                            setState(() {
                              role = value as String;
                            });
                          })
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                        child: Text(
                          "Couple",
                          style: TextStyle(
                            color: AppColors.i.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.045,
                          ),
                        ),
                      ),
                      Radio(
                          value: "Couple",
                          groupValue: role,
                          onChanged: (value) {
                            setState(() {
                              role = value as String;
                            });
                          })
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                        child: Text(
                          "Undecided",
                          style: TextStyle(
                            color: AppColors.i.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.045,
                          ),
                        ),
                      ),
                      Radio(
                          value: "Undecided",
                          groupValue: role,
                          onChanged: (value) {
                            setState(() {
                              role = value as String;
                            });
                          })
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Date of Birth",
                style: TextStyle(
                  color: AppColors.i.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.05,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    titleText: "Day",
                    width: size.width * 0.25,
                    controller: controllerDay,
                    isDark: false,
                    radius: 15,
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextField(
                    titleText: "Month",
                    width: size.width * 0.25,
                    controller: controllerMonth,
                    keyboardType: TextInputType.number,
                    isDark: false,
                    radius: 15,
                  ),
                  CustomTextField(
                    titleText: "Year",
                    width: size.width * 0.25,
                    keyboardType: TextInputType.number,
                    controller: controllerYear,
                    isDark: false,
                    radius: 15,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Select your city:",
                style: TextStyle(
                  color: AppColors.i.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.045,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  titleText: "Town",
                  width: size.width * 0.88,
                  keyboardType: TextInputType.text,
                  controller: controllerCity,
                  isDark: false,
                  radius: 15,
                  pl: 20),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Choose your country:",
                style: TextStyle(
                  color: AppColors.i.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.045,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  titleText: "Country",
                  width: size.width * 0.88,
                  keyboardType: TextInputType.text,
                  controller: controllerTown,
                  isDark: false,
                  radius: 15,
                  pl: 20),
              SizedBox(
                height: size.height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleButton(
                      title: "CONTINUE",
                      onTap: () async {
                        if (await updateInfo()) {
                          screenPush(context, const AddPictureScreen());
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> updateInfo() async {
    if (controllerDay.text.isEmpty ||
        controllerMonth.text.isEmpty ||
        controllerYear.text.isEmpty ||
        controllerCity.text.isEmpty ||
        controllerTown.text.isEmpty) {
      showFailedToast(context, "Please fill all fields");
      return false;
    }
    if(!isValidDate(int.parse(controllerDay.text),int.parse(controllerMonth.text),int.parse(controllerYear.text))){
      showFailedToast(context, "Please enter a valid date");
      return false;
    }
    if(!isEighteenYearsOld(int.parse(controllerDay.text),int.parse(controllerMonth.text),int.parse(controllerYear.text))){
      showFailedToast(context, "You must be 18 years old");
      return false;
    }
    Store().userData.role = role;
    Store().userData.date = '${controllerDay.text}/${controllerMonth.text}/${controllerYear.text}';
    Store().userData.city = controllerCity.text;
    Store().userData.town = controllerTown.text;
    if(await updateUserInFirestore(Store().userData)){
      return true;
    }
    showFailedToast(context, 'Something went wrong please try again ');
    return false;
  }
}
