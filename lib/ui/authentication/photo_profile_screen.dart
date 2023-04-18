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
              decoration: const BoxDecoration(
                  color: Color(0xffB40303), shape: BoxShape.circle),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                final a = getImageFromUser();
                print(a);
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

  Future<File?> getImageFromUser() async {
    final picker = ImagePicker();
    try{
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) {
        return null; // User did not select an image
      }

      final file = File(pickedFile.path);
      return file;
    } catch (e) {
      print(e);
      return null;
    }
  }



}
