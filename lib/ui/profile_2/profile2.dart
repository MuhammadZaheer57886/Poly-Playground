import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import '_form.dart';

class Profile2 extends StatefulWidget {
  const Profile2({super.key});

  @override
  State<Profile2> createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Image.asset(
                  'assets/icon.png',
                  width: 60,
                  height: 60,
                ),
                const Text(
                  'Profile', // replace with your screen title
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(height: size.height * 0.05),
                addPhotos(size, context),
                SizedBox(height: size.height * 0.05),
                const ProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row addPhotos(Size size, BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size.width * 0.4,
                  height: size.height * 0.22,
                  decoration: BoxDecoration(
                      color: AppColors.i.brownColor,
                      borderRadius: BorderRadius.circular(15)),
                ),
                Container(
                  alignment: Alignment.center,
                  width: size.width * 0.09,
                  height: size.width * 0.09,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 100,
                  child: Text('Add profile image *',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 14),
        Column(
          children: [
            takePictureBox(context, size),
            const SizedBox(height: 20),
            takePictureBox(context, size),
          ],
        ),
        const SizedBox(width: 14),
        Column(
          children: [
            takePictureBox(context, size),
            const SizedBox(height: 20),
            takePictureBox(context, size),
          ],
        ),
      ],
    );
  }

  Widget takePictureBox(BuildContext context, Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width * 0.2,
          height: size.height * 0.10,
          decoration: BoxDecoration(
              color: AppColors.i.brownColor,
              borderRadius: BorderRadius.circular(15)),
        ),
      ],
    );
  }
}
