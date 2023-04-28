import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poly_playground/ui/chat/chat_screen.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import 'package:poly_playground/ui/video_calls/video_calls.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import '../../common/nav_function.dart';
import '../../common/store.dart';
import '../../model/user_model.dart';
import '../../utils/firebase_utils.dart';
import '../../utils/my_utils.dart';
import '../home/profile_screen/profile_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatModel> chats = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updaeChatList();
  }

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 0.05,
                ),
                Container(
                  height: 40,
                  width: size.width,
                  color: AppColors.i.whiteColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            screenPush(context, const ProfileScreen());
                          },
                          icon: Image.asset("assets/profile.png")),
                      IconButton(
                          onPressed: () {
                            screenPush(context, const HomeScreen());
                          },
                          icon: Image.asset("assets/home.png")),
                      IconButton(
                          onPressed: () {
                            screenPush(context, const CallListScreen());
                          },
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
                      Expanded(
                        child: chats.isNotEmpty
                            ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              return chatCard(size, chats[index]);
                            })
                            : Center(
                          child: Text(
                            "You have no messages!",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            _showModalBottomSheet(context,size); // code to add a new message
          },
          backgroundColor: AppColors.i.darkBrownColor.withOpacity(0.8),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget chatCard(Size size, ChatModel lastChat) {
    return GestureDetector(
      onTap: () {
        screenPush(context, MessageScreen(receiverId: lastChat.uid));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.i.darkBrownColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 15, top: 5 , bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: size.width * 0.07,
                backgroundImage: NetworkImage(lastChat.photoUrl),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lastChat.fullName,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.05),
                    ),
                    Text(
                      lastChat.lastMessage.message,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: size.width * 0.04),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    DateFormat('h:mm a')
                        .format(DateFormat('MMM dd, yyyy h:mm:ss.SSSS a').parse(lastChat.lastMessage.timestamp)),
                    style: TextStyle(
                        color: AppColors.i.whiteColor.withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.04),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updaeChatList() async {
    for (var friend in Store().friends) {
      final lastMessage = await getLastMessage(friend.uid);
      if (lastMessage != null) {
        setState(() {
          chats.add(createChatModel(friend, lastMessage));
        });
      }
    }
  }

  void _showModalBottomSheet(BuildContext context,Size size) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: size.height * 0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
              child: ListView.builder(
                // shrinkWrap: true,
                  itemCount: Store().friends.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: size.width * 0.07,
                              backgroundImage:
                              NetworkImage(Store().friends[index].photoUrl),
                            ),
                            Text(
                              Store().friends[index].fullName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize:size.width * 0.05),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            IconButton(
                                onPressed: () {
                                  screenPush(
                                      context,
                                      MessageScreen(
                                          receiverId:
                                          Store().friends[index].uid));
                                },
                                icon: const Icon(Icons.message)),
                          ],
                        ));
                  }),
            ),
        ],
          ),
        );
      },
    );
  }
}
