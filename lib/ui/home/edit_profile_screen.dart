import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../ui_components/simple_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String role = "";

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
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/temp/5.png"))),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
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
              textField(size, "Full Name"),
              const SizedBox(
                height: 10,
              ),
              textField(size, "Job"),
              const SizedBox(
                height: 10,
              ),
              textField(size, "Biography"),
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
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: size.width * 0.25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: "Day", border: InputBorder.none),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: size.width * 0.25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: "Month", border: InputBorder.none),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: size.width * 0.25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: "Year", border: InputBorder.none),
                    ),
                  )
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
              Container(
                padding: const EdgeInsets.only(left: 20, top: 2),
                width: size.width * 0.88,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Town",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
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
              Container(
                padding: const EdgeInsets.only(left: 20, top: 2),
                width: size.width * 0.88,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Town",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
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
                  takePictureBox(context, size),
                  takePictureBox(context, size),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleButton(title: "SAVE", onTap: () {}),
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

  Widget textField(Size size, String text) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 20),
      width: size.width * 0.86,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.i.brownColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        decoration: InputDecoration(border: InputBorder.none, hintText: text),
      ),
    );
  }

  Widget takePictureBox(BuildContext context, Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width * 0.35,
          height: size.height * 0.24,
          decoration: BoxDecoration(
              color: AppColors.i.whiteColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2)
              ]),
        ),
      ],
    );
  }
}
