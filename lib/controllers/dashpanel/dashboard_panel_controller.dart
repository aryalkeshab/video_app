import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashPanelController extends GetxController {
  RxInt currentIndex = RxInt(0);
  RxInt notificationCount = RxInt(0);

  final PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose(); // Ensure this does not cause unintended effects
    super.dispose();
  }

  void onClick(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }
}
