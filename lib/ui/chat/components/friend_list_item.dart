import 'package:flutter/material.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../common/nav_function.dart';
import '../../../common/store.dart';
import '../../../utils/constants/app_colors.dart';
import '../chat_screen.dart';

class FriendList extends StatefulWidget {
  final VoidCallback onTap;
  final bool forChat;

  const FriendList(
      {Key? key, required this.onTap,  this.forChat = true})
      : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  bool isLoading = true;
  late VoidCallback onTap;
  late List<UserDataModel> friendList = [];
  late bool forChat;

  @override
  void initState() {
    print(Store().lastChats.length);
    // TODO: implement initState
    super.initState();
    onTap = widget.onTap;
    forChat = widget.forChat;
    if (widget.forChat) {
      setFriendListForChat();
    } else {
      setFriendListForCall();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * 0.5,
          padding: const EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
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
                    itemCount: friendList.length,
                    itemBuilder: (context, index) {
                      return friendListItem(
                          size, friendList[index], onTap);
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget friendListItem(
      Size size, UserDataModel friend,  VoidCallback onTap) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.i.greyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: size.width * 0.07,
                  backgroundImage: NetworkImage(friend.photoUrl),
                ),
                SizedBox(
                  width: size.width * 0.10,
                ),
                Text(
                  friend.fullName.length < 15
                      ? friend.fullName
                      : friend.fullName.substring(0, 12) + '...',
                  style: TextStyle(
                      color: AppColors.i.blackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.05),
                ),
              ],
            ),
            IconButton(
              onPressed:(){
                Store().friend = friend;
                onTap();
              },
              icon:  forChat ? const Icon(Icons.chat,) :  _videoCallIcon(friend),
            ),
          ],
        ));
  }

  void setFriendListForChat() {
    List<UserDataModel> friends = Store().friends;
    List<ChatModel> lastChats = Store().lastChats;
    List<UserDataModel> filteredFriends = [];

    for (int i = 0; i < friends.length; i++) {
      bool isMatching = false;
      for (int j = 0; j < lastChats.length; j++) {
        if (friends[i].uid == lastChats[j].uid) {
          isMatching = true;
          break;
        }
      }
      if (!isMatching) {
        filteredFriends.add(friends[i]);
      }
    }
    setState(() {
      friendList = filteredFriends;
    });
  }

  void setFriendListForCall() {
    List<UserDataModel> friends = Store().friends;
    List<CallModel> lastCall = Store().lastCalls;
    List<UserDataModel> filteredFriends = [];

    for (int i = 0; i < friends.length; i++) {
      bool isMatching = false;
      for (int j = 0; j < lastCall.length; j++) {
        if (friends[i].uid == lastCall[j].uid) {
          isMatching = true;
          break;
        }
      }
      if (!isMatching) {
        filteredFriends.add(friends[i]);
      }
    }
    setState(() {
      friendList = filteredFriends;
    });
  }
  
  Widget _videoCallIcon(UserDataModel friend) {
      return ZegoSendCallInvitationButton(
   isVideoCall: true,
   resourceID: "zegouikit_call",    // For offline call notification
   invitees: [
      ZegoUIKitUser(
         id: friend.uid,
         name: friend.fullName,
      ),
      
   ],
   iconSize: const Size(30, 30),
    buttonSize: const Size(40, 40),
);
  }
}
