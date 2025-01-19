import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_app/controllers/dashpanel/dashboard_panel_controller.dart';
import 'package:video_app/controllers/home_controller.dart';
import 'package:video_app/screens/home/home_screen.dart';
import 'package:video_app/screens/profile/profile_screen.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/constants/icon_path.dart';
import 'package:video_app/utils/widgets/custom_bottom_nav.dart';

class DashBoardPanel extends StatelessWidget {
  static const String routeName = "/dash-screen";
  final c = Get.find<DashPanelController>();
  DashBoardPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: c.currentIndex.value,
          onTap: c.onClick,
          items: [
            CustomBottomNav(
              iconPath: IconPath.homeInactive,
            ),
            CustomBottomNav(
              iconPath: IconPath.profileInactive,
            ),
          ],
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: c.pageController,
        children: [
          HomeScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
