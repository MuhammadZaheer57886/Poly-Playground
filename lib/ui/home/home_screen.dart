import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/provider/sign_in_provider.dart';
import 'package:poly_playground/ui/authentication/welcome_screen.dart';
import 'package:poly_playground/ui/home/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';
import '../chat/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              AppColors.i.darkBrownColor,
              AppColors.i.darkBrownColor.withOpacity(0.4),
            ])),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          screenPush(context, const ProfileScreen());
                        },
                        icon: Image.asset("assets/profile.png")),
                    IconButton(
                        onPressed: () {}, icon: Image.asset("assets/home.png")),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/video.png")),
                    IconButton(
                        onPressed: () {}, icon: Image.asset("assets/love.png")),
                    IconButton(
                        onPressed: () {
                          screenPush(context, const ChatScreen());
                        },
                        icon: Image.asset("assets/chat.png")),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        }, icon: Image.asset("assets/menu.png")
                        
                        ),
                        
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset("assets/search.png")),
                    
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "FOR YOU",
                        style: TextStyle(
                            color: Colors.yellow.shade800,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "TRENDING",
                        style: TextStyle(
                            color: Colors.red.shade800,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "NEARBY",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "NEW",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: 0.92),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          image: DecorationImage(
                              image: AssetImage("assets/temp/${index + 1}.png"),
                              fit: BoxFit.fill)),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
