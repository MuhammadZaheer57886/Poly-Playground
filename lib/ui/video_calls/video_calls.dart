import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poly_playground/ui/chat/chat_screen.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import '../../common/nav_function.dart';
import '../../common/store.dart';
import '../../model/user_model.dart';
import '../../utils/firebase_utils.dart';
import '../../utils/my_utils.dart';
import '../chat/chat_user_list.dart';
import '../chat/components/friend_list_item.dart';
import '../home/profile_screen/profile_screen.dart';
import 'utils/agoracall.dart';

class CallListScreen extends StatefulWidget {
  const CallListScreen({Key? key}) : super(key: key);

  @override
  State<CallListScreen> createState() => _CallListScreenState();
}

class _CallListScreenState extends State<CallListScreen> {
  List<CallHistoryModel> calls = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // updateCallList();
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
                            screenPush(context, widget);
                          },
                          icon: Image.asset("assets/video.png")),
                      IconButton(
                          onPressed: () {}, icon: Image.asset("assets/love.png")),
                      IconButton(
                          onPressed: () {
                            screenPush(context, const ChatUserList());
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
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //   },
                            //   child: Container(
                            //     width: size.width * 0.14,
                            //     height: size.height * 0.07,
                            //     alignment: Alignment.centerRight,
                            //     decoration: BoxDecoration(
                            //       color: AppColors.i.darkBrownColor,
                            //       borderRadius:
                            //       BorderRadius.circular(size.width * 0.075),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text("Calls",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: size.width * 0.09)),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            // Container(
                            //   width: size.width * 0.06,
                            //   height: size.height * 0.03,
                            //   decoration: BoxDecoration(
                            //     color: AppColors.i.redColor,
                            //     borderRadius:
                            //     BorderRadius.circular(size.width * 0.075),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: calls.isNotEmpty
                            ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: calls.length,
                            itemBuilder: (context, index) {
                              return callHistoyCart(size, calls[index]);
                            })
                            : Center(
                          child: Text(
                            "You have no Calls!",
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

  Widget callHistoyCart(Size size, CallHistoryModel lastCall) {
    return GestureDetector(
      onTap: () {
        // screenPush(context, MessageScreen(receiverId: lastChat.uid));
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
                backgroundImage: NetworkImage(lastCall.photoUrl),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lastCall.fullName,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.05),
                    ),
                    Row(
                      children: [
                        const Icon(
                           Icons.call_received_sharp
                          , color: Colors.black),
                        const SizedBox(width: 10),
                        Text(
                          'call duration',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.04),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    DateFormat('h:mm a')
                        .format(DateFormat('MMM dd, yyyy h:mm:ss.SSSS a').parse(lastCall.lastCall.timestamp)),
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

  // void updateCallList() async {
  //   for (var friend in Store().friends) {
  //     final lastCall = await getLastCall(friend.uid);
  //     if (lastCall != null) {
  //       setState(() {
  //         calls.add(createCallModel(friend, lastCall));
  //       });
  //     }
  //   }
  // }

void _showModalBottomSheet(BuildContext context, Size size) {
    showModalBottomSheet(backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: size.height * 0.5,
          padding: const EdgeInsets.only(top: 20.0),
          decoration:  BoxDecoration(
            color: AppColors.i.whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: Store().friends.length,
                    itemBuilder: (context, index) {
                      return FriendListItem(friend: Store().friends[index],icon: const Icon(Icons.video_call_rounded),
                      onTap: () async {
                              await _handlecameraAndMic(Permission.camera);
                              await _handlecameraAndMic(Permission.microphone); 
                              screenPush(
                                    context,
                                    const AgoraCall());
                },
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
  
 Future<void> _handlecameraAndMic(Permission permission) async{
  final status = await permission.request();

  print(status.toString());
 }
}