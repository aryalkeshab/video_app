import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_app/controllers/screen_controller/splash_controller.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/constants/image_path.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splash-screen";

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashController c = Get.find<SplashController>();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Image.asset(
          ImagePath.welcome,
          height: Get.height / 5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
