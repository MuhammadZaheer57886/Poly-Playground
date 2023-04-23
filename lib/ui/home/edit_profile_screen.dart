import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poly_playground/ui/ui_components/custom_text_field.dart';
import '../../common/pop_message.dart';
import '../../common/store.dart';
import '../../model/user_model.dart';
import '../../utils/constants/app_colors.dart';
import '../ui_components/simple_button.dart';

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
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Edit your profile",
          style: TextStyle(
            color: Colors.black,
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
                      Container(
                        width: size.width * 0.34,
                        height: size.width * 0.34,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: profileImage.isEmpty ? NetworkImage(
                              userData.getPhotoUrl,
                            ) : FileImage(File(profileImage)) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // image: AssetImage("assets/temp/5.png"))),
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
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white70),
                            child: Icon(
                              Icons.mode_edit,
                              color: Colors.black,
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
              textField(size, userData.name, controllerFullName),
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
                            color: Colors.black,
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
                          "Unicorn",
                          style: TextStyle(
                            color: Colors.black,
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
                            color: Colors.black,
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
                            color: Colors.black,
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
                  SimpleButton(title: "SAVE", onTap: () {
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
    // ImageProvider<Object> imageProvider = selected ? FileImage(File(image)):NetworkImage(image);
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
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                )
              : Container(
                  width: size.width * 0.34,
                  height: size.height * 0.24,
                  decoration: BoxDecoration(
                    // color: AppColors.i.brownColor,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      // image:imageProvider,
                      image: selected
                          ? FileImage(File(image)) as ImageProvider<Object>
                          : NetworkImage(image),
                      // image: FileImage(File(image)),
                      // image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ), //
        ],
      ),
    );
  }

  Future<String> getImageFromUser() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) {
        showFailedToast(context, 'No image selected.');
        return '';
      }
      return pickedFile.path;
    } catch (e) {
      showFailedToast(context, 'Failed to get image from camera.');
      return '';
    }
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
  Future<String> uploadImage(FileImage file) async {
    final fileName = file.file.path.split('/').last;

    try {
      final firebaseStorageRef =
      FirebaseStorage.instance.ref().child('users/profileImages/$fileName');
      final uploadTask = firebaseStorageRef.putFile(file.file);
      final snapshot = await uploadTask.whenComplete(() {});
      if (snapshot.state == TaskState.success) {
        final downloadUrl = await firebaseStorageRef.getDownloadURL();
        return downloadUrl;
      } else {
        showFailedToast(context, 'Failed to upload image');
        return '';
      }
    } on FirebaseException catch (e) {
      print(e);
      return '';
    } catch (e) {
      print(e);
      return '';
    }
  }

  void updateProfile() async {
    if( controllerFullName.text.isEmpty && controllerJob.text.isEmpty && controllerIntro.text.isEmpty && controllerCity.text.isEmpty && controllerTown.text.isEmpty && profileImage.isEmpty && image1.isEmpty && image2.isEmpty){
      showFailedToast(context, 'No Informayion Updated');
      Navigator.pop(context);
      return;
    }


    final date = '${controllerDay.text}/${controllerMonth.text}/${controllerYear.text}';

    final idDate = isValidDate(date);
    userData.photoUrl = profileImage.isEmpty ? userData.photoUrl : await uploadImage(FileImage(File(profileImage)));
    userData.name = controllerFullName.text.isEmpty ? userData.name : controllerFullName.text;
    userData.job = controllerJob.text.isEmpty ? userData.job : controllerJob.text;
    userData.intro = controllerIntro.text.isEmpty ? userData.intro : controllerIntro.text;

    userData.role = role;
    userData.date = idDate ? date : userData.date;
    userData.city = controllerCity.text.isEmpty ? userData.city : controllerCity.text;
    userData.town = controllerTown.text.isEmpty ? userData.town : controllerTown.text;
    userData.image1 = image1.isEmpty ? userData.image1 : await uploadImage(FileImage(File(image1)));
    userData.image2 = image2.isEmpty ? userData.image2 : await uploadImage(FileImage(File(image2)));

    FirebaseFirestore.instance.collection('users').doc(userData.uid).update(userData.toJson()).then((value) {
      showSuccessToast(context, 'Profile updated successfully');
      Store().userData = userData;
      Navigator.pop(context);
    }).catchError((error) {
      showFailedToast(context, 'Failed to update profile');
    });
  }

  bool isValidDate(String dateStr) {
    DateTime? date = DateTime.tryParse(dateStr);
    if (date == null) {
      return false;
    }
    // Check that the year is not before 1900 or after the current year
    final now = DateTime.now();
    return date.year >= 1900 && date.year <= now.year;
  }

}
