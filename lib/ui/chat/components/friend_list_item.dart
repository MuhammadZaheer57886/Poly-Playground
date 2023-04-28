
import 'package:flutter/material.dart';
import 'package:poly_playground/model/user_model.dart';

import '../../../common/nav_function.dart';
import '../../../common/store.dart';
import '../../../utils/constants/app_colors.dart';
import '../chat_screen.dart';

class FriendListItem extends StatefulWidget {
  final FriendModel friend;
  final Icon icon;
  const FriendListItem({Key? key,required this.friend, required this.icon}) : super(key: key);

  @override
  State<FriendListItem> createState() => _FriendListItemState();
}

class _FriendListItemState extends State<FriendListItem> {

  late FriendModel friend;
late Icon icon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friend = widget.friend;
    icon = widget.icon;
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      // color: AppColors.i.greyColor.withOpacity(0.2),
        decoration: BoxDecoration(
          color: AppColors.i.greyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15 , vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: size.width * 0.07,
              backgroundImage: NetworkImage(
                  friend.photoUrl),
            ),
            Text(
              friend.fullName,
              style: TextStyle(
                  color: AppColors.i.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.05),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            IconButton(
                onPressed: () {
                  screenPush(
                      context,
                      ChatScreen(
                          receiverId:
                          friend.uid));
                },
                icon: icon,

          ],
        ));
  }
}
