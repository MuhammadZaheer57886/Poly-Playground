import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/common/store.dart';
import 'package:poly_playground/model/user_model.dart';
import 'package:poly_playground/ui/home/profile_screen/user_profile.dart';
import 'package:poly_playground/utils/constants/app_colors.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<UserDataModel> friends = [];
  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      friends = Store().friends;
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: size.height * 0.8,
        child: GridView.builder(
          itemCount: friends.length,
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
                    context, UserProfile(userId: friends[index].uid));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                width: size.width * 0.3,
                decoration: BoxDecoration(
                    color: AppColors.i.whiteColor,
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                        image: NetworkImage(friends[index].photoUrl),
                        fit: BoxFit.fill)),
              ),
            );
          },
        ),
      ),
    );
  }
}
