import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import '../ui_components/custom_text_field.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
            Container(
                alignment: Alignment.center,
                width: size.width,
                height: size.height * 0.21,
                child: Text(
                  "Verification Code",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w700),
                )),
            SizedBox(
              height: size.height * 0.12,
            ),
            CustomTextField(
                titleText: "_ _ _ _",
                imageAddress: "assets/verification_code.png",
                controller: controllerEmail),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.12, vertical: 17),
              decoration: BoxDecoration(
                color: AppColors.i.darkBrownColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "CONTINUE",
                style: TextStyle(
                  color: AppColors.i.whiteColor,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
