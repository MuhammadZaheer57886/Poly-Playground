import 'package:flutter/material.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';

import '../../common/nav_function.dart';
// import '../../utils/constants/app_colors.dart';
import '../home/profile_screen/profile_screen.dart';
import 'messages_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return  Scaffold(

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //  SizedBox(
                  //   height: size.height * 0.04,
                  // ),
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
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: size.width,
                    height: size.height * 0.83,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: size.width * 0.14,
                                  height: size.height * 0.07,
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: AppColors.i.darkBrownColor,
                                    borderRadius:
                                        BorderRadius.circular(size.width * 0.075),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text("Chats",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: size.width * 0.06)),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Container(
                                width: size.width * 0.06,
                                height: size.height * 0.03,
                                decoration: BoxDecoration(
                                  color: AppColors.i.redColor,
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.075),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                            child: Column(
                          children: [
                            chatCard(size, "John", "Hello", "12:00",
                                "assets/profile.png"),

                            Text(
                              "You have no messages!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.05),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
          ),
        ),
    );
  }

  Widget chatCard(
      Size size, String name, String message, String time, String image) {
    return GestureDetector(
      onTap: () {
        screenPush(context, const MessageScreen());
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: AppColors.i.darkBrownColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: size.width * 0.14,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                color: AppColors.i.brownColor,
                borderRadius: BorderRadius.circular(size.width * 0.075),
                image: const DecorationImage(
                    image: AssetImage("assets/profile.png"), fit: BoxFit.cover),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John Doe",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.05),
                ),
                Text(
                  "Hello, how are you?",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.04),
                ),
              ],
            ),
            Text(
              "12:00",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.04),
            ),
          ],
        ),
      ),
    );
  }

  Widget MessageCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    "John Doe",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Hello, how are you?",
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
