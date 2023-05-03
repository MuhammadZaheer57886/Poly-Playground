import 'package:flutter/material.dart';
import 'package:poly_playground/model/user_model.dart';
import '../../../common/store.dart';
import '../../../utils/constants/app_colors.dart';

class FriendList extends StatefulWidget {
  final VoidCallback onTap;
  const FriendList({Key? key, required this.onTap}) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  bool isLoading = true;
  late VoidCallback onTap;
  late List<UserDataModel> friendList = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onTap = widget.onTap;
    if (Store().lastChats.isNotEmpty) {
      friendList = Store().friends.where((obj) =>
          Store().lastChats.any((obj1) => obj1.uid != obj.uid))
          .toList();
    }else
    friendList = Store().friends;
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
                      return friendListItem(size, friendList[index],
                          const Icon(Icons.message), onTap);
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget friendListItem(
      Size size, UserDataModel friend, Icon icon, VoidCallback onTap) {
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
              onPressed: () {
                Store().friend = friend;
                onTap();
              },
              icon: icon,
            ),
          ],
        ));
  }
}
