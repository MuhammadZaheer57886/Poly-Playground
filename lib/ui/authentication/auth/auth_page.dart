import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import '../signup/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  
  void toggle()=> setState(()=> isLogin = !isLogin);
  @override
  Widget build(BuildContext context)=> isLogin ? Loginwidget(onClickedSignUp: toggle,) : const SignUpScreen( );
}