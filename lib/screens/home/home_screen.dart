import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_app/controllers/home_controller.dart';
import 'package:video_app/screens/home/video_widget.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/constants/icon_path.dart';
import 'package:video_app/utils/constants/image_path.dart';
import 'package:video_app/utils/widgets/shadow_container.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home-screen";
  final c = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // int initialIndex = c.getIndexOfVideos();

    return Scaffold(
        body: Stack(
      children: [
        Obx(
          () => PageView.builder(
            itemCount: c.staticVideos.length,
            scrollDirection: Axis.vertical,
            controller: c.pageController, // Use the PageController here
            itemBuilder: (context, index) {
              var video = c.staticVideos[index];

              return VideoWidget(
                videoModel: video,
              );
            },
          ),
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    c.pageController.jumpToPage(0);
                  },
                  child: Image.asset(
                    ImagePath.welcome,
                    height: 70,
                    width: 110,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
