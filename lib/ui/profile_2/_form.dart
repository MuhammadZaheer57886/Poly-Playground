import 'package:flutter/material.dart';

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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your gender identity';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          const TextFormFieldContainer(
            labelText: 'Pronouns',
            hintText: 'Enter your pronouns',
          ),
          const SizedBox(height: 10),
          TextFormFieldContainer(
            labelText: 'Solo Profile User Name *',
            hintText: 'Enter your solo profile user name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your solo profile user name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          const TextFormFieldContainer(
            labelText: 'About Me',
            hintText: 'Enter information about yourself',
          ),
          const SizedBox(height: 10),
          const TextFormFieldContainer(
            labelText: 'Single',
            hintText: 'Enter your single status',
          ),
          const SizedBox(height: 10),
          const TextFormFieldContainer(
            labelText: 'Open',
            hintText: 'Enter your open status',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
}
