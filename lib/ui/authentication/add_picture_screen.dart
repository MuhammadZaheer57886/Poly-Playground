import 'package:flutter/material.dart';
import 'package:poly_playground/ui/payment/payment.dart';

import '../../utils/constants/app_colors.dart';
import '../ui_components/simple_button.dart';

class AddPictureScreen extends StatefulWidget {
  const AddPictureScreen({Key? key}) : super(key: key);

  @override
  State<AddPictureScreen> createState() => _AddPictureScreenState();
}

class _AddPictureScreenState extends State<AddPictureScreen> {
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
                takePictureBox(context, size),
                takePictureBox(context, size),
              ],
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
            SizedBox(
              height: size.height * 0.25,
            ),
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleButton(
                    title: "CONTINUE",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Payment(),
                        ),
                      );
                    }),

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget takePictureBox(BuildContext context, Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width * 0.3,
          height: size.height * 0.15,
          decoration: BoxDecoration(
              color: AppColors.i.brownColor,
              borderRadius: BorderRadius.circular(15)),
        ),
        Container(
          alignment: Alignment.center,
          width: size.width * 0.09,
          height: size.width * 0.09,
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Icon(
            Icons.add,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
