import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/pop_message.dart';
import '../../../utils/constants/app_colors.dart';
import '../../payment/payment.dart';
import '../../ui_components/simple_button.dart';

class AddPictureScreen extends StatefulWidget {
  const AddPictureScreen({Key? key}) : super(key: key);

  @override
  State<AddPictureScreen> createState() => _AddPictureScreenState();
}

class _AddPictureScreenState extends State<AddPictureScreen> {
  String image1 = '';
  String image2 = '';
  String image3 = '';
  String image4 = '';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              "Your Pictures",
              style: TextStyle(
                color: AppColors.i.blackColor,
                fontWeight: FontWeight.w700,
                fontSize: size.width * 0.05,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Please insert at least one of your photos...",
              style: TextStyle(
                color: AppColors.i.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.035,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // takePictureBox(context, size,setFirstImage)
                takePictureBox(context, size, setFirstImage, image1),
                takePictureBox(context, size, setSecImage, image2),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                takePictureBox(context, size, setThirdImage, image3),
                takePictureBox(context, size, setFourthImage, image4),
              ],
            ),
            SizedBox(
              height: size.height * 0.25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleButton(
                    title: "CONTINUE",
                    onTap: () {
                      updateProfile();
                      // Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      //   builder: (context) => const Payment(),
                      // ),
                      // );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget takePictureBox(
      BuildContext context, Size size, VoidCallback onTap, String image) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size.width * 0.3,
            height: size.height * 0.15,
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
                  width: size.width * 0.3,
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    // color: AppColors.i.brownColor,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(File(image)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ), //
        ],
      ),
    );
  }

  void setFirstImage() async {
    final img = await getImageFromUser();
    setState(() {
      image1 = img;
    });
  }

  void setSecImage() async {
    final img = await getImageFromUser();
    setState(() {
      image2 = img;
    });
  }

  void setThirdImage() async {
    final img = await getImageFromUser();
    setState(() {
      image1 = img;
    });
  }

  void setFourthImage() async {
    final img = await getImageFromUser();
    setState(() {
      image4 = img;
    });
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
    return '';
  }

  void updateProfile() async {
    final image1URL =
        image1.isNotEmpty ? await uploadImage(FileImage(File(image1))) : '';
    final image2URL =
        image2.isNotEmpty ? await uploadImage(FileImage(File(image2))) : '';
    final image3URL =
        image3.isNotEmpty ? await uploadImage(FileImage(File(image3))) : '';
    final image4URL =
        image4.isNotEmpty ? await uploadImage(FileImage(File(image4))) : '';
if(image1URL.isEmpty && image2URL.isEmpty && image3URL.isEmpty && image4URL.isEmpty){
  showFailedToast(context, 'Please insert at least one image');
  return;
}
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "image1": image1URL,
      "image2": image2URL,
      "image3": image3URL,
      "image4": image4URL,
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Payment(),
        ),
      );
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
}
