import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/ui_components/simple_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../utils/constants/app_colors.dart';
import 'basic_info_screen.dart';

class PhotoProfileScreen extends StatefulWidget {
  const PhotoProfileScreen({Key? key}) : super(key: key);

  @override
  State<PhotoProfileScreen> createState() => _PhotoProfileScreenState();
}

class _PhotoProfileScreenState extends State<PhotoProfileScreen> {
  FileImage? imageFile;

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
                color:
                    imageFile != null ? Colors.transparent :const  Color(0xffB40303),
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
                uploadImage(imageFile as FileImage);
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
                onTap: () {
                  screenPush(context, const BasicInfoScreen());
                })
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
         // ScaffoldMessenger.of(context).showSnackBar(
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

  Future<String?> uploadImage(FileImage file) async {
    // Create a storage reference from our app
    final fileName = file.file.path.split('/').last;

    try {
      final Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('images/$fileName');
      final UploadTask uploadTask = firebaseStorageRef.putFile(file.file);
      await uploadTask;
      final downloadUrl = await firebaseStorageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // print(e);
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save Image.'),
        ),
      );
      return null;
    }
  }
}
