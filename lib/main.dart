import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:poly_playground/common/custom_nav.dart';
import 'package:poly_playground/provider/internet_provider.dart';
import 'package:poly_playground/provider/sign_in_provider.dart';
import 'package:poly_playground/ui/authentication/splash_screen.dart';
import 'package:poly_playground/utils/constants/app_strings.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'ui/payment/stripe_key.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePubishableKey;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );
  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: AppStrings.i.appDescription,
    id: AppStrings.i.appId,
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: AppStrings.i.appName,

  );
  print(result);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()
        ),
        ChangeNotifierProvider(create: (_) => InternetProvider()
        ),
       ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Poly Playground',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
