
import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class MonthlyDeals extends StatelessWidget {
  const MonthlyDeals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //container 1
        Container(
          width: 100,
          height: 180,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
        child: RichText(text: TextSpan(

              children: [
                const WidgetSpan(child: SizedBox(height: 50,width: 40,)),
                TextSpan(
                  text: '3\n',
                  style: TextStyle(
                    color: AppColors.i.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
                const WidgetSpan(child: SizedBox(height: 20,width: 20,)),
                TextSpan(
                  text: 'Months\n',
                  style: TextStyle(
                    color: AppColors.i.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const WidgetSpan(child: SizedBox(height: 30,width: 15,)),
                TextSpan(
                  text: '\$9.99/mo',
                  style: TextStyle(
                    color: AppColors.i.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                
              ],
            ),
            ),
        ),


        // container 2
        Container(
          width: 100,
          height: 180,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color.fromARGB(255, 255, 241, 241),
          ),
          child: RichText(text: const TextSpan(
              children: [
                WidgetSpan(child: SizedBox(height: 50,width: 40,)),
                TextSpan(
                  text: '6\n',
                  style: TextStyle(
                    color: Color.fromARGB(255, 238, 194, 20),
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
                WidgetSpan(child: SizedBox(height: 20,width: 20,)),
                TextSpan(
                  text: 'Months\n',
                  style: TextStyle(
                    color: Color.fromARGB(255, 238, 194, 20),
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                WidgetSpan(child: SizedBox(height: 30,width: 10,)),
                TextSpan(
                  text: '\$5.99/mo',
                  style: TextStyle(
                    color: Color.fromARGB(255, 238, 194, 20),
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                WidgetSpan(child: SizedBox(height: 30,width: 20,)),
                 TextSpan(
                  text: 'Save 36%',
                  style: TextStyle(
                    color: Color.fromARGB(255, 238, 194, 20),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            ),
          ),
        
        // container 3
        Container(
          width: 100,
          height: 180,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
        child: RichText(text: TextSpan(

              children: [
                const WidgetSpan(child: SizedBox(height: 50,width: 40,)),
                TextSpan(
                  text: '1\n',
                  style: TextStyle(
                    color: AppColors.i.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
                const WidgetSpan(child: SizedBox(height: 20,width: 20,)),
                TextSpan(
                  text: 'Months\n',
                  style: TextStyle(
                    color: AppColors.i.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const WidgetSpan(child: SizedBox(height: 30,width: 10,)),
                TextSpan(
                  text: '\$14.99/mo',
                  style: TextStyle(
                    color: AppColors.i.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                
              ],
            ),
            ),
        ),
      ],
    );
  }
}
