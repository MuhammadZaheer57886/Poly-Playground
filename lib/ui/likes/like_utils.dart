import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/store.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/likes/liked_profile.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';

Widget friends(Size size, BuildContext context) {
  return SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    child: SizedBox(
      height: size.height * 0.8,
      child: GridView.builder(
        itemCount: Store().likedUsers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 0.92,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              screenPush(
                  context, UserProfile(userData: Store().likedUsers[index]));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              width: size.width * 0.3,
              decoration: BoxDecoration(
                  color: AppColors.i.whiteColor,
                  borderRadius: BorderRadius.circular(35),
                  image: DecorationImage(
                      image: NetworkImage(Store().likedUsers[index].photoUrl),
                      fit: BoxFit.fill)),
            ),
          );
        },
      ),
    ),
  );
}

Widget pending(Size size, BuildContext context) {
  return Flex(
    direction: Axis.vertical,
    children: [
      Expanded(
        child: Store().friendRequests.isNotEmpty
            ? ListView.builder(
                itemCount: Store().friendRequests.length,
                itemBuilder: (context, index) {
                  return requestItem(
                      size, Store().friendRequests[index], () {});
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
                    onPressed: () {},
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
                    onPressed: () {},
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
            margin: const EdgeInsets.symmetric(horizontal:10, vertical:5),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 2, color: AppColors.i.darkBrownColor)),
            ),
            child: TextButton(
              onPressed: () {
                Store().friendRequests.remove(request);
                Store().dislikedUsersIds.add(request.receiverId);
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
