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
import 'package:poly_playground/ui/video_calls/utils/zegokeys.dart';
import 'package:poly_playground/utils/constants/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'common/store.dart';
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
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  print(result);
  ZegoUIKit().initLog().then((value) {
    ///  Call the `useSystemCallingUI` method
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (Store().userData.uid.isNotEmpty) {
      onUserLogin();
    }else{
      ZegoUIKitPrebuiltCallInvitationService().uninit();
    }
  }
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
  void onUserLogin() {
  /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged in or re-logged in
  /// We recommend calling this method as soon as the user logs in to your app.
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: ZegoConfig.appID ,
    appSign: ZegoConfig.appSign ,
    userID: Store().userData.uid,
      userName: Store().userData.fullName,
    plugins: [ZegoUIKitSignalingPlugin()],
  );
}
}
