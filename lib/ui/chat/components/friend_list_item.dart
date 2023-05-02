
import 'package:flutter/material.dart';
import 'package:poly_playground/model/user_model.dart';

import '../../../common/nav_function.dart';
import '../../../utils/constants/app_colors.dart';
import '../chat_screen.dart';

class FriendListItem extends StatefulWidget {
  final UserDataModel friend;
  final Icon icon;
  final VoidCallback onTap;
  const FriendListItem({Key? key,required this.friend, required this.icon, required this.onTap}) : super(key: key);

  @override
  State<FriendListItem> createState() => _FriendListItemState();
}

class _FriendListItemState extends State<FriendListItem> {

  late UserDataModel friend;
late Icon icon;
late VoidCallback onTap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friend = widget.friend;
    icon = widget.icon;
    onTap = widget.onTap;
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          color: AppColors.i.greyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15 , vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: size.width * 0.07,
                  backgroundImage: NetworkImage(
                      friend.photoUrl),
                ),
                SizedBox(
                  width: size.width * 0.10,
                ),
                Text(
                    friend.fullName.length < 15
                        ? friend.fullName
                        :friend.fullName.substring(0, 12) + '...',
                  style: TextStyle(
                      color: AppColors.i.blackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.05),
                ),
              ],
            ),


            IconButton(
                onPressed: onTap,
                icon: icon,),

          ],
        ));
  }
}
