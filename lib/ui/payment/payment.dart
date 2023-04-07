import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_strings.dart';
import '../profile_2/profile2.dart';
import 'continue_button.dart';
import 'monthly_deals.dart';

// import '../../utils/constants/app_colors.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Manage Subscription",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.i.darkBrownColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
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
              ]),
        ),
        child: Center(
          child: Container(
            height: 650,
            width: 550,
            decoration: BoxDecoration(
              color: const Color(0xff8A0000),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return const RadialGradient(
                      colors: [
                        Colors.yellow,
                        Colors.orange,
                      ],
                      stops: [0.0, 1.0],
                      center: Alignment.center,
                      radius: 0.5,
                      tileMode: TileMode.clamp,
                    ).createShader(bounds);
                  },
                  child: const Center(
                    child: Text(
                      'Go Premium',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 57,
                  height: 57,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.yellow, Colors.orange],
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Like Without Limits',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'Increase your chances of matching by\n    liking as many people as you want',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                //Deals
                const MonthlyDeals(),

                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    AppStrings.i.paymentComment,
                    style: TextStyle(
                      color: AppColors.i.whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.03,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                const ContinueButton(),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,  MaterialPageRoute(builder: (context) => const Profile2()));
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
