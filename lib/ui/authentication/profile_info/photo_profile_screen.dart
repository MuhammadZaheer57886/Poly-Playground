import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/ui_components/simple_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../utils/constants/app_colors.dart';
import 'basic_info_screen.dart';

class PhotoProfileScreen extends StatefulWidget {
  const PhotoProfileScreen({Key? key}) : super(key: key);

  @override
  State<PhotoProfileScreen> createState() => _PhotoProfileScreenState();
}

class _PhotoProfileScreenState extends State<PhotoProfileScreen> {
  FileImage? imageFile;

  @override
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
            Text(
              "Profile Picture",
              style: TextStyle(
                color: AppColors.i.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.05,
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height * 0.08),
              width: size.width * 0.4,
              height: size.width * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: imageFile != null
                    ? Colors.transparent
                    : const Color(0xffB40303),
                image: imageFile != null
                    ? DecorationImage(
                        image: imageFile!,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            //
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                getImageFromUser();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.16,
                ),
                width: size.width * 0.65,
                height: 45,
                child: Text(
                  "INSERT YOUR PHOTO",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.25,
            ),
            SimpleButton(
              title: "CONTINUE",
              // onTap: () {
              //  String url = uploadImage(imageFile as FileImage) as String;
              //   url != '' ? updateProfileImage(url!) : '';
              //
              //   screenPush(context, const BasicInfoScreen());
              // })
              onTap: () async {
                 String downloadUrl = await uploadImage(imageFile as FileImage);
                if (downloadUrl != null && downloadUrl.isNotEmpty) {
                  try {
                    // await FirebaseFirestore.instance
                    //     .collection('users')
                    //     .doc(FirebaseAuth.instance.currentUser!.uid)
                    //     .update({
                    //   'photoUrl': downloadUrl,
                    // });
                      screenPush(context,BasicInfoScreen(photoUrl: downloadUrl));
                  } catch (e) {
                    print(e);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future getImageFromUser() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) {
        const SnackBar(
          content: Text('Failed to get image from camera.'),
        );
        // );
        return;
      }
      setState(() {
        imageFile = FileImage(File(pickedFile.path));
      });
    } catch (e) {
      // print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get image from camera.'),
        ),
      );
    }
  }

  Future< String> uploadImage(FileImage file) async {
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
        throw Exception('Failed to upload image.');
      }
    } on FirebaseException catch (e) {
      print(e);
      throw Exception('Failed to upload image.');
    } catch (e) {
      print(e);
      throw Exception('Failed to upload image.');
    }
  }
}