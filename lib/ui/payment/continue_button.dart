import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/pop_message.dart';
import 'package:poly_playground/ui/profile_2/profile2.dart';

class ContinueButton extends StatefulWidget {
  final String selectedAmount;
  const ContinueButton({
    Key? key,
    required this.selectedAmount,
  }) : super(key: key);

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  Map<String, dynamic>? paymentIntent;
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
        onPressed: () async {
          await paymentFunction(widget.selectedAmount);
          
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

  Future<void> paymentFunction(String amount) async {
    //Step 1: payment intent(type of curency, amount)
    try {
      paymentIntent = await createPaymentIntent(amount, 'usd');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              merchantDisplayName: 'Company',
              style: ThemeMode.light,
            ),
          )
          .then((value) => {});
      displayPaymetSheet();
    } catch (e) {
      print(e);
    }
  }

  displayPaymetSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) => {
            //success status
            print('payment success'),
            showSuccessToast(context, 'Payment Success'),
            screenPush(context, const Profile2()),
          });
    } catch (e) {
      print(e);
    }
  }

  createPaymentIntent(String amount, String curency) async {
    print(amount.toString());
    String amountWithoutCurrency =
        amount.replaceAll(RegExp(r'[\$,\s]'), ''); // remove $ and space
    amountWithoutCurrency = amountWithoutCurrency.replaceAll(
        RegExp(r'[^\d.]'), ''); // remove non-numeric characters
    double amountDouble = double.parse(amountWithoutCurrency);
    int amountInt = (amountDouble * 100).toInt();
    try {
      Map<String, dynamic> body = {
        'amount': amountInt.toString(),
        'currency': curency,
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51Mz24UANURd7IOLISKEBRYqAB5wUc9tDKAHmqCakPep8kvgaI9wgEiVtcnReWHgFLI1ilsZl804Chclwm7eUa6XH003mUNzeP6',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
