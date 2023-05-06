import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poly_playground/ui/chat/chat_screen.dart';
import 'package:poly_playground/ui/chat/chat_user_list.dart';
import 'package:poly_playground/ui/home/home_screen.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import 'package:poly_playground/utils/constants/app_strings.dart';
import 'package:poly_playground/utils/my_utils.dart';
import '../../common/nav_function.dart';
import '../../common/store.dart';
import '../../model/user_model.dart';
import '../../utils/firebase_utils.dart';
import '../home/profile_screen/profile_screen.dart';
import '../likes/liked_users.dart';
import '../video_calls/video_calls.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  State<NotificationList> createState() => _NotificationList();
}

class _NotificationList extends State<NotificationList> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateNotifications();
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
                    const SizedBox(height: 20),
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
                                // screenPush(context, const NotificationList());
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
                      width: size.width,
                      height: size.height * 0.83,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text("Notifications",
                                style: TextStyle(
                                    color: AppColors.i.whiteColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: size.width * 0.06)),
                          ),
                          Expanded(
                            child: Store().notifications.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: Store().notifications.length,
                                    itemBuilder: (context, index) {
                                      return notificationCard(
                                          size, Store().notifications[index]);
                                    })
                                : Center(
                                    child: Text(
                                      "You have no notification!",
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
        ),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(),
      ],
    );
  }

  Widget notificationCard(Size size, NotificationModel notification) {
    return GestureDetector(
      onTap: () async {
        if(!notification.status) {
          notification.updateStatus();
          await updateNotificationToFirestore(notification);
        }
        navidateFromNotificationScreen(notification);

      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: notification.status ?AppColors.i.darkBrownColor.withOpacity(0.3) : AppColors.i.darkBrownColor.withOpacity(0.5),
          border: Border(
            bottom: BorderSide(color: AppColors.i.blackColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 15, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: size.width * 0.07,
                backgroundImage: NetworkImage(notification.photoUrl),
              ),
              Container(
                width: size.width * 0.65,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification.type,
                          style: TextStyle(
                              color: AppColors.i.blackColor,
                              fontWeight: FontWeight.w700,
                              fontSize: size.width * 0.05),
                        ),
                        Text(
                          getMessageTime(notification.timestamp),
                          style: TextStyle(
                              color: AppColors.i.whiteColor.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.04),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        notification.title.length > 30
                            ? '${notification.title.substring(0, 27)}...'
                            : notification.title,
                        style: TextStyle(
                            color: AppColors.i.blackColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateNotifications() async {
    setState(() {
      isLoading = true;
    });
    final List<NotificationModel> notifications =
        await getNotificationFromFirestore();

    if (notifications.isNotEmpty) {
      Store().notifications = notifications;
    }
    setState(() {
      isLoading = false;
    });
  }

  void navidateFromNotificationScreen(NotificationModel notification) {
    switch(notification.type)
        {
      case "Friend Request":
        screenPush(context, LikedUsers());
        break;
      case "Message":
        screenPush(context, ChatScreen(receiverId: notification.senderId));
        break;
      default:
        "";
        break;
    }
  }



}
