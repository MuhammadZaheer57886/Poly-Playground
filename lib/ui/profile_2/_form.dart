import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/pop_message.dart';
import 'package:poly_playground/utils/my_utils.dart';
import '../../utils/constants/app_colors.dart';
import '../home/home_screen.dart';
import 'textfield_constrans.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController orientationController = TextEditingController();
  TextEditingController genderIdentityController = TextEditingController();
  TextEditingController pronounceController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController singleController = TextEditingController();
  TextEditingController openController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldContainer(
            labelText: 'Name *',
            hintText: 'Enter your name',
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormFieldContainer(
            labelText: 'Date of Birth *',
            hintText: 'Enter your date of birth',
            controller: dobController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your date of birth';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormFieldContainer(
            labelText: 'Orientation *',
            hintText: 'Enter your orientation',
            controller: orientationController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your orientation';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormFieldContainer(
            labelText: 'Gender Identity *',
            hintText: 'Enter your gender identity',
            controller: genderIdentityController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your gender identity';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormFieldContainer(
            labelText: 'Pronouns',
            hintText: 'Enter your pronouns',
            controller: pronounceController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your pronouns';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormFieldContainer(
            labelText: 'Solo Profile User Name *',
            hintText: 'Enter your solo profile user name',
            controller: userNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your solo profile user name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormFieldContainer(
            labelText: 'About Me',
            hintText: 'Enter information about yourself',
            controller: aboutController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter information about yourself';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormFieldContainer(
            labelText: 'Single',
            hintText: 'Enter your single status',
            controller: singleController,
            validator: (value) {
              if (value.toString().toLowerCase() == 'yes' ||
                  value.toString().toLowerCase() == 'no') {
                return null;
              }
              return 'Please enter yes, no';
            },
          ),
          const SizedBox(height: 10),
          TextFormFieldContainer(
            labelText: 'Open',
            hintText: 'Enter your open status',
            controller: openController,
            validator: (value) {
              if (value.toString().toLowerCase() == 'yes' ||
                  value.toString().toLowerCase() == 'no') {
                return null;
              }
              return 'Please enter yes, no';
            },
          ),
          const SizedBox(height: 25),
          // ElevatedButton(
          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {
          //       _formKey.currentState!.save();
          //     }
          //   },
          //   child: const Text('Submit'),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  updateProfile2();
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.20, vertical: 17),
                  decoration: BoxDecoration(
                    color: AppColors.i.darkBrownColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      color: AppColors.i.whiteColor,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: AppColors.i.darkBrownColor,
                child: const Icon(
                  Icons.question_mark,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.05)
        ],
      ),
    );
  }

  bool isValidDate(String date) {
    try {
      DateFormat.yMd().parseStrict(date);
      return true;
    } catch (e) {
      return false;
    }
  }

  void updateProfile2() {
    if (!_formKey.currentState!.validate()) {
      showFailedToast(context, 'Please fill all the fields');
      return;
    }
    // _formKey.currentState!.save();
    if(!isValidDate(dobController.text)) {
      showFailedToast(context, 'Date format should be in mm/dd/yyyy');
      return;
    }
    if (singleController.text.toString().toLowerCase() != 'yes' &&
        singleController.text.toString().toLowerCase() != 'no') {
      showFailedToast(context, 'Please enter yes, no in single field');
      return;
    }
    if (openController.text.toString().toLowerCase() != 'yes' &&
        openController.text.toString().toLowerCase() != 'no') {
      showFailedToast(context, 'Please enter yes, no in open field');
      return;
    }
    print('success');
    screenPush(context, const HomeScreen());
    // updateUserInFirestore(userData)
  }
}
