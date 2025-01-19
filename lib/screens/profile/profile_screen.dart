import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_app/controllers/profile/profile_controller.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/constants/icon_path.dart';
import 'package:video_app/utils/widgets/custom_alert_dialog.dart';
import 'package:video_app/utils/widgets/snackbar.dart';
import 'package:video_player/video_player.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profile-screen";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              // if (controller.isUserLoggedIn())

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("ACCOUNT"),
                  // _buildListTile(
                  //   context,
                  //   icon: IconPath.user,
                  //   title: "name here from firebase",
                  //   onTap: () {
                  //     // Get.toNamed(UpdateProfileScreen.routeName);
                  //   },
                  // ),
                  Obx(() => _buildListTile(
                        context,
                        icon: IconPath.user,
                        title: controller.name.value.isNotEmpty
                            ? controller.name.value
                            : "Loading...",
                        subtitle: controller.userEmail.value.isNotEmpty
                            ? controller.userEmail.value
                            : "Loading...",
                        onTap: () {
                          // Navigate to profile update screen if needed
                          // Get.toNamed(UpdateProfileScreen.routeName);
                        },
                      )),
                ],
              ),
              const Divider(color: Colors.grey, thickness: 0.5),
              _buildListTile(context,
                  leadingIcon: Icon(
                    Icons.info,
                    color: AppColors.iconColor,
                  ),
                  icon: "",
                  title: "Settings", onTap: () {
                showSuccess("Work in progress");
              }),

              const Divider(color: Colors.grey, thickness: 0.5),
              _buildListTile(context,
                  leadingIcon: Icon(
                    Icons.info,
                    color: AppColors.iconColor,
                  ),
                  icon: "",
                  title: "HELP & SUPPORT", onTap: () {
                showSuccess("Work in progress");
              }),

              const Divider(color: Colors.grey, thickness: 0.5),
              _buildListTile(context,
                  leadingIcon: Icon(
                    Icons.info,
                    color: AppColors.iconColor,
                  ),
                  icon: "",
                  title: "About us", onTap: () {
                showSuccess("Work in progress");
              }),
              const Divider(color: Colors.grey, thickness: 0.5),

              if (FirebaseAuth.instance.currentUser != null)
                _buildListTile(context,
                    leadingIcon: Icon(
                      Icons.logout,
                      color: AppColors.primary,
                    ),
                    icon: "",
                    title: "Logout", onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: "Are you sure to log out ?",
                        onConfirm: () async {
                          await controller.logout();
                          // Get.back();
                        },
                        confirmText: "Yes",
                      );
                    },
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {String? icon,
      required String title,
      String? subtitle,
      Icon? leadingIcon,
      required VoidCallback onTap}) {
    return ListTile(
      leading: leadingIcon ??
          SvgPicture.asset(
            icon ?? IconPath.logo,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      // subtitle:
      //     Text(subtitle ?? "", style: const TextStyle(color: Colors.black)),
      subtitle: subtitle?.isNotEmpty == true
          ? Text(subtitle!, style: const TextStyle(color: Colors.black))
          : null,
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
      onTap: onTap,
    );
  }
}
