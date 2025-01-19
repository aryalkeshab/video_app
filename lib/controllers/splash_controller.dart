import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:video_app/screens/auth/login_screen.dart';
import 'package:video_app/screens/dashboard/dashboard_panel.dart';
import 'package:video_app/screens/home/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 1), () {
      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   if (user != null) {
      //     // User is logged in
      //     // Get.offAllNamed(HomeScreen.routeName);
      //     Get.offAllNamed(DashBoardPanel.routeName);
      //   } else {
      //     // User is not logged in
      //     Get.offAllNamed(LoginScreen.routeName);
      //   }
      // });

      if (FirebaseAuth.instance.currentUser != null) {
        // User is logged in
        // Get.offAllNamed(HomeScreen.routeName);
        Get.offAllNamed(DashBoardPanel.routeName);
      } else {
        // User is not logged in
        Get.offAllNamed(LoginScreen.routeName);
      }
    });

    super.onInit();
  }
}
