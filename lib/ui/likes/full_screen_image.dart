import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.i.darkBrownColor,
                    AppColors.i.darkBrownColor.withOpacity(0.4),
                    AppColors.i.darkBrownColor.withOpacity(0.4),
                  ])),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColors.i.whiteColor,
                    ),
                  ),
                ),
              ),
              Hero(
                tag: 'user_image',
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Image(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
