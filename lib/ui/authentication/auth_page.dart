import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

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