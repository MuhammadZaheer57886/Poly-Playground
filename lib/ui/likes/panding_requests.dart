import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/store.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/home/profile_screen/user_profile.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';
import 'package:poly_playground/utils/firebase_utils.dart';
import 'package:poly_playground/utils/http_requests.dart';
import 'package:poly_playground/utils/my_utils.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({Key? key}) : super(key: key);

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  List<FriendRequest> friendRequests = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friendRequests = Store().friendRequests;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: friendRequests.isNotEmpty
              ? ListView.builder(
                  itemCount: friendRequests.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // navigateTo(context, ProfileScreen());
                        screenPush(
                            context,
                            UserProfile(
                                userId: friendRequests[index].senderId));
                      },
                      child: requestItem(size, friendRequests[index], () {}),
                    );
                  })
              : const Center(child: Text("No Pending Requests")),
        ),
      ],
    );
  }

  Widget requestItem(Size size, FriendRequest request, VoidCallback onTap) {
    return request.receiverId == Store().uid
        ? requestReceived(size, request, onTap)
        : requestSent(size, request, onTap);
  }

  Widget requestReceived(Size size, FriendRequest request, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.i.greyColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 150,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: size.width * 0.07,
                backgroundImage: NetworkImage(request.photoUrl),
              ),
              SizedBox(width: size.width * 0.1),
              Text(
                request.fullName.length < 15
                    ? request.fullName
                    : '${request.fullName.substring(0, 12)}...',
                style: TextStyle(
                  color: AppColors.i.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.05,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.i.darkBrownColor.withOpacity(0.5),
                  ),
                  child: TextButton(
                      onPressed: () {
                        handleAcceptFriendRequest(request);
                      },
                      child: Text(
                        "Accept",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.i.whiteColor,
                        ),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.i.whiteColor.withOpacity(0.5),
                  ),
                  child: TextButton(
                      onPressed: () {
                        friendRequestsRemove(request);
                      },
                      child: Text(
                        "Reject",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color: AppColors.i.darkBrownColor,
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget requestSent(Size size, FriendRequest request, VoidCallback onTap) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.i.greyColor.withOpacity(0.5),
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
                  backgroundImage: NetworkImage(request.photoUrl),
                ),
                SizedBox(
                  width: size.width * 0.10,
                ),
                Text(
                  request.fullName.length < 15
                      ? request.fullName
                      : '${request.fullName.substring(0, 12)}...',
                  style: TextStyle(
                      color: AppColors.i.blackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.05),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 2, color: AppColors.i.darkBrownColor)),
              ),
              child: TextButton(
                onPressed: () {

                  handelCancelRequest(request);
                },
                child: Text(
                  "cancel",
                  style: TextStyle(
                    color: AppColors.i.darkBrownColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void handleAcceptFriendRequest(FriendRequest request) async {
    setState(() {
      friendRequests.remove(request);
    });
    acceptFriendRequest(request);
  }

  void friendRequestsRemove(FriendRequest request) async {
    setState(() {
      friendRequests.remove(request);
    });
    await rejectFriendRequest(request);
  }

  void handelCancelRequest(FriendRequest request) async {
    setState(() {
      friendRequests.remove(request);
    });
    await cancelFriendRequest(request);
  }
}
