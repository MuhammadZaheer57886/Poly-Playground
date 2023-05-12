import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/store.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/chat/chat_screen.dart';
import 'package:poly_playground/ui/chat/components/friend_list_item.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import 'package:poly_playground/ui/home/profile_screen/profile_screen.dart';
import 'package:poly_playground/ui/likes/liked_users.dart';
import 'package:poly_playground/ui/notifications/NotificationScreen.dart';
import 'package:poly_playground/ui/video_calls/video_calls.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import 'package:poly_playground/utils/firebase_utils.dart';

class ChatUserList extends StatefulWidget {
  const ChatUserList({Key? key}) : super(key: key);

  @override
  State<ChatUserList> createState() => _ChatUserList();
}

class _ChatUserList extends State<ChatUserList> {
  List<ChatModel> chats = [];
  bool isLoading = false;
  Future<bool> getAllFriends() async {
    final friends = await getFriends();
    Store().friends = friends;
    setState(() {
      isLoading = false;
    });
    return friends.isNotEmpty;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateChatList();
    getAllFriends();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
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
                      height: 20,
                    ),
                    Container(
                      height: 50,
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
                              onPressed: () {
                                screenPush(context, const LikedUsers());
                              },
                              icon: Image.asset("assets/love.png")),
                          IconButton(
                              onPressed: () {
                                screenPush(context, const ChatUserList());
                              },
                              icon: Image.asset("assets/chat.png")),
                          IconButton(
                              onPressed: () {
                                screenPush(context, const NotificationList());
                              },
                              icon: const Icon(
                                Icons.notifications_on_outlined,
                                size: 32,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.i.whiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      width: size.width,
                      height: size.height * 0.80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child:   Text("Chats",
                                      style: TextStyle(
                                          color: AppColors.i.blackColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: size.width * 0.06)),
                          ),
                          Expanded(
                            child: Store().lastChats.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: Store().lastChats.length,
                                    itemBuilder: (context, index) {
                                      return chatCard(
                                          size, Store().lastChats[index]);
                                    })
                                : Center(
                                    child: Text(
                                      "You have no messages!",
                                      style: TextStyle(
                                          color: AppColors.i.blackColor,
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
            margin: const EdgeInsets.only(bottom: 30, right: 10),
            child: FloatingActionButton(
              onPressed: () {
                _showModalBottomSheet(
                    context, size); // code to add a new message
              },
              backgroundColor: AppColors.i.darkBrownColor.withOpacity(0.8),
              child: const Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(),
      ],
    );
  }

  Widget chatCard(Size size, ChatModel lastChat) {
    return GestureDetector(
      onTap: () async {
        Store().lastChat = lastChat;
        updateReadStatus(lastChat);
        screenPush(context, ChatScreen(receiverId: lastChat.uid));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.i.darkBrownColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 15, top: 5, bottom: 5),
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
                          color: AppColors.i.blackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.05),
                    ),
                    Text(
                      lastChat.lastMessage.message,
                      style: TextStyle(
                          color: AppColors.i.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: size.width * 0.04),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    DateFormat('h:mm a').format(
                        DateFormat('MMM dd, yyyy h:mm:ss.SSSS a')
                            .parse(lastChat.lastMessage.timestamp)),
                    style: TextStyle(
                        color: AppColors.i.whiteColor.withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.04),
                  ),
                   const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: size.width * 0.03,
                    height: size.width * 0.03,
                    decoration: BoxDecoration(
                        color: !lastChat.lastMessage.isRead && lastChat.lastMessage.senderId  != Store().uid  ?  AppColors.i.greenColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateChatList() async {
    setState(() {
      isLoading = true;
    });
    final List<ChatModel> chatList = await getLastMessages();
    if (chatList.isNotEmpty) {
      Store().lastChats = chatList;
      Store().lastChats.sort(
          (a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp));
    }
    setState(() {
      isLoading = false;
    });
  }

  void _showModalBottomSheet(BuildContext context, Size size) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return FriendList(
          onTap: () {
            screenPush(
                context,
                ChatScreen(
                    receiverId:
                    Store().friend!.uid));
          },
        );
      },
    );
  }
}
