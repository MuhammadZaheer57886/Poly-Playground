
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, 
      height: 50.0, 
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEEAF51), Color(0xFFB67718)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextButton(
        onPressed: () {
          Fluttertoast.showToast(
            msg: 'Coming Soon!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        child: const Text(
          'CONTINUE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
