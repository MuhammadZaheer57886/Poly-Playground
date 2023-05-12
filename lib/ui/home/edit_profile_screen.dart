import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/pop_message.dart';
import 'package:poly_playground/common/store.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/ui_components/custom_text_field.dart';
import 'package:poly_playground/ui/ui_components/simple_button.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import 'package:poly_playground/utils/firebase_utils.dart';
import 'package:poly_playground/utils/my_utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserDataModel userData = Store().userData;
  String role = Store().userData.role;
  final TextEditingController controllerFullName = TextEditingController();
  final TextEditingController controllerJob = TextEditingController();
  final TextEditingController controllerIntro = TextEditingController();
  final TextEditingController controllerTown = TextEditingController();
  final TextEditingController controllerCity = TextEditingController();
  final TextEditingController controllerDay = TextEditingController();
  final TextEditingController controllerMonth = TextEditingController();
  final TextEditingController controllerYear = TextEditingController();

  String profileImage = '';
  String image1 = '';
  String image2 = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.i.darkBrownColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.i.whiteColor,
          ),
        ),
        title: Text(
          "Edit your profile",
          style: TextStyle(
            color: AppColors.i.blackColor,
            fontWeight: FontWeight.w700,
            fontSize: size.width * 0.055,
          ),
        ),
      ),
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
              AppColors.i.darkBrownColor.withOpacity(0.6),
              AppColors.i.darkBrownColor.withOpacity(0.5),
            ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CircleAvatar(
                        radius: size.width * 0.20,
                        backgroundColor: AppColors.i.greyColor,
                        backgroundImage: profileImage.isEmpty
                                  ? NetworkImage(
                                      userData.photoUrl,
                                    )
                                  : FileImage(File(profileImage)) as ImageProvider,
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            editeProfileImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            width: size.width * 0.07,
                            height: size.width * 0.07,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.i.whiteColor.withOpacity(0.8)),
                            child: Icon(
                              Icons.mode_edit,
                              color: AppColors.i.blackColor,
                              size: size.width * 0.042,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                "My Profile:",
                style: TextStyle(
                  color: AppColors.i.blackColor,
                  fontWeight: FontWeight.w800,
                  fontSize: size.width * 0.05,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              textField(size, userData.fullName, controllerFullName),
              const SizedBox(
                height: 10,
              ),
              textField(size, userData.job, controllerJob),
              const SizedBox(
                height: 10,
              ),
              textField(size, userData.intro, controllerIntro),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Gender:",
                style: TextStyle(
                  color: AppColors.i.blackColor,
                  fontWeight: FontWeight.w800,
                  fontSize: size.width * 0.05,
                ),
              ),
              const SizedBox(
                height: 5,
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
                    controller: controllerDay,
                    titleText: userData.date.split('/')[0],
                    width: size.width * 0.25,
                    radius: 15,
                    isDark: false,
                  ),
                  CustomTextField(
                    controller: controllerMonth,
                    titleText: userData.date.split('/')[1],
                    width: size.width * 0.25,
                    radius: 15,
                    isDark: false,
                  ),
                  CustomTextField(
                    controller: controllerYear,
                    titleText: userData.date.split('/')[2],
                    width: size.width * 0.25,
                    radius: 15,
                    isDark: false,
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
                  controller: controllerCity,
                  titleText: userData.city,
                  width: size.width * 0.88,
                  radius: 15,
                  isDark: false,
                  pl: 20),
              const SizedBox(
                height: 15,
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
                height: 15,
              ),
              CustomTextField(
                  controller: controllerTown,
                  titleText: userData.town,
                  width: size.width * 0.88,
                  radius: 15,
                  isDark: false,
                  pl: 20),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Pictures:",
                style: TextStyle(
                  color: AppColors.i.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.045,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  takePictureBox(context, size, setImage1, userData.image1),
                  takePictureBox(context, size, setImage2, userData.image2),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleButton(
                      title: "SAVE",
                      onTap: () {
                        updateProfile();
                      }),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(Size size, String text, TextEditingController controller) {
    return CustomTextField(
      controller: controller,
      titleText: text,
      pl: 20,
      width: size.width * 0.86,
      radius: 25,
      color: AppColors.i.brownColor,
      isDark: false,
    );
  }

  Widget takePictureBox(
      BuildContext context, Size size, VoidCallback onTap, String image) {
    bool selected = false;
    return GestureDetector(
      onTap: () {
        selected = true;
        onTap();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size.width * 0.35,
            height: size.height * 0.24,
            decoration: BoxDecoration(
                color: AppColors.i.brownColor,
                borderRadius: BorderRadius.circular(15)),
          ),
          image.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  width: size.width * 0.09,
                  height: size.width * 0.09,
                  decoration: BoxDecoration(
                      color: AppColors.i.whiteColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.add,
                    color: AppColors.i.greyColor,
                  ),
                )
              : Container(
                  width: size.width * 0.34,
                  height: size.height * 0.24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: selected
                          ? FileImage(File(image)) as ImageProvider<Object>
                          : NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void editeProfileImage() {
    getImageFromUser().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          profileImage = value;
        });
      }
    });
  }

  void setImage1() {
    getImageFromUser().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          image1 = value;
        });
      }
    });
  }

  void setImage2() {
    getImageFromUser().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          image2 = value;
        });
      }
    });
  }

  void updateProfile() async {
    if (controllerFullName.text.isEmpty &&
        controllerJob.text.isEmpty &&
        controllerIntro.text.isEmpty &&
        controllerCity.text.isEmpty &&
        controllerTown.text.isEmpty &&
        profileImage.isEmpty &&
        image1.isEmpty &&
        image2.isEmpty &&
        role.isEmpty) {
      showFailedToast(context, 'No Information Updated');
      Navigator.pop(context);
      return;
    }

    final date =
        '${controllerDay.text}/${controllerMonth.text}/${controllerYear.text}';

    final idDate = isValidDate(int.parse(controllerDay.text),
        int.parse(controllerMonth.text), int.parse(controllerYear.text));
    final isEighteen = isEighteenYearsOld(int.parse(controllerDay.text),
        int.parse(controllerMonth.text), int.parse(controllerYear.text));
    if (!idDate || !isEighteen) {
      showFailedToast(context, 'Invalid Date! date not updated');
    }
    userData.photoUrl = profileImage.isEmpty
        ? userData.photoUrl
        : await uploadImage(profileImage);
    userData.fullName = controllerFullName.text.isEmpty
        ? userData.fullName
        : controllerFullName.text;
    userData.job =
        controllerJob.text.isEmpty ? userData.job : controllerJob.text;
    userData.intro =
        controllerIntro.text.isEmpty ? userData.intro : controllerIntro.text;
    userData.role = role;
    userData.date = idDate && isEighteen ? date : userData.date;
    userData.city =
        controllerCity.text.isEmpty ? userData.city : controllerCity.text;
    userData.town =
        controllerTown.text.isEmpty ? userData.town : controllerTown.text;
    userData.image1 =
        image1.isEmpty ? userData.image1 : await uploadImage(image1);
    userData.image2 =
        image2.isEmpty ? userData.image2 : await uploadImage(image2);
    updateUserInFirestore(userData).then((v) {
      if (v) {
        showSuccessToast(context, 'Profile updated successfully');
        Store().userData = userData;
        Navigator.pop(context);
      } else {
        showFailedToast(context, 'Failed to update profile');
      }
    });
  }
}
