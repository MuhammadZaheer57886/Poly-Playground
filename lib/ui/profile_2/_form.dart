import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/pop_message.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/ui_components/simple_button.dart';
import 'package:poly_playground/utils/my_utils.dart';
import '../../common/store.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/firebase_utils.dart';
import '../home/home_screen.dart';
import 'textfield_constrans.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String orientation = '';
  String genderIdentity = '';
  String pronoun = '';
  String singleStatus = '';
  String openStatus = '';

  List<String> orientations = [
    'Select Orientation',
    'Straight',
    'Gay',
    'Lesbian',
    'Bisexual',
    'Asexual',
    'Demisexual',
    'Pansexual',
    'Queer',
  ];
  List<String> genderIdentities = [
    'Select Gender Identity',
    'Agender',
    'Androgynous',
    'Bigender',
    'Cisgender',
    'Demigender',
    'Genderfluid',
    'Genderqueer',
    'Nonbinary',
    'Transgender',
    'Two-Spirit'
  ];
  List<String> pronouns = [
    'Select Your Pronoun',
    'he/him',
    'she/her',
    'they/them',
    'ze/zir',
    'ey/em',
    'per/pers',
    've/ver',
    'xe/xem',
    'fae/faer',
    'hir/hirs',
    'ne/nem',
    'sie/hir',
    'ey/em',
    'thon/thon',
  ];
  List<String> singleStatuses = [
    'Select Single Status',
    'Yes',
    'No',
  ];
  List<String> openStatuses = [
    'Select Open Status',
    'Yes',
    'No',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormFieldContainer(
              hintText: 'Name',
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            MyDropdown(dropDownList: orientations, onChanged: (value) {
              setState(() {
                orientation = value;
              });
            }),
            const SizedBox(height: 10),
            MyDropdown(dropDownList: genderIdentities, onChanged: (value) {
              setState(() {
                genderIdentity = value;
              });
            }),
            const SizedBox(height: 10),
            MyDropdown(dropDownList: pronouns, onChanged: (value) {
              setState(() {
                pronoun = value;
              });
            }),
            const SizedBox(height: 10),
            TextFormFieldContainer(
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
              // labelText: 'About Me',
              hintText: 'Enter information about yourself',
              controller: bioController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter information about yourself';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            MyDropdown(dropDownList: singleStatuses, onChanged: (value) {
              setState(() {
                singleStatus = value;
              });
            }),
            const SizedBox(height: 10),
            MyDropdown(dropDownList: openStatuses, onChanged: (value) {
              setState(() {
                openStatus = value;
              });
            }),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            SimpleButton(
                    color: AppColors.i.darkBrownColor, title: 'Next', onTap: () {
                    if (updateProfile2()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }
                  },
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
      ),
    );
  }

  Widget dropDown(
      BuildContext context,
      List<String> dropDownList,
      Function(String) onChanged,
      ) {
    late String dropdownValue = dropDownList[0];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.i.whiteColor,
      ),
      child: DropdownButton<String>(
        dropdownColor: AppColors.i.whiteColor,
        isExpanded: true,
        itemHeight: 55,
        menuMaxHeight: 300,
        value: dropdownValue,
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
            dropdownValue = newValue;
          }
        },
        items: dropDownList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }


  bool updateProfile2() {
    if (!_formKey.currentState!.validate()) {
      showFailedToast(context, 'Please fill all the fields');
      return false;
    }

    if (orientation.contains("Select") || orientation.isEmpty ) {
      showFailedToast(context, 'Please select orientation');
      return false;
    }
    if (genderIdentity.contains("Select") || genderIdentity.isEmpty ) {
      showFailedToast(context, 'Please Select gender identity');
      return false;
    }
    if (pronoun.toLowerCase().contains("select") || pronoun.isEmpty) {
      showFailedToast(context, 'Please select pronoun');
      return false;
    }

    if (singleStatus.contains("Select") || singleStatus.isEmpty ) {
      showFailedToast(context, 'Please select single status');
      return false;
    }
    if (openStatus.contains("Select")|| openStatus.isEmpty ) {
      showFailedToast(context, 'Please select single status');
      return false;
    }
    print('Form is valid');
    _formKey.currentState!.save();
    UserDataModel userData = Store().userData;
    userData.name = nameController.text;
    userData.orientation = orientation ;
    userData.genderIdentity = genderIdentity;
    userData.pronouns = pronoun;
    userData.userName = userNameController.text;
    userData.bio = bioController.text;
    userData.single = singleStatus;

    if (updateUserInFirestore(userData)) {
      showSuccessToast(context, 'Profile created successfully');
      return true;
    }
    showFailedToast(context, 'Failed to create profile');
    return false;
  }
}

class MyDropdown extends StatefulWidget {
  final List<String> dropDownList;
  final Function(String) onChanged;

  MyDropdown({required this.dropDownList, required this.onChanged});

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String dropdownValue = "";

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.dropDownList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.i.whiteColor,
      ),
      child: DropdownButton<String>(
        dropdownColor: AppColors.i.whiteColor,
        isExpanded: true,
        itemHeight: 55,
        menuMaxHeight: 300,
        value: dropdownValue,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              dropdownValue = newValue;
            });
            widget.onChanged(newValue);
          }
        },
        items: widget.dropDownList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
