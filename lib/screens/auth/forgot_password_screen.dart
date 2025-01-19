import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_app/controllers/auth/forgot_password_controller.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/constants/icon_path.dart';
import 'package:video_app/utils/constants/image_path.dart';
import 'package:video_app/utils/constants/validators.dart';
import 'package:video_app/utils/widgets/elevated_button.dart';
import 'package:video_app/utils/widgets/shadow_container.dart';
import 'package:video_app/utils/widgets/text_field.dart';
import 'package:video_app/utils/widgets/text_style.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "/forgot-password-screen";
  final forgotPasswordController = Get.find<ForgotPasswordController>();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      Get.back();
                    },
                    child: CustomShadowContainer(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        IconPath.ios_back,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Form(
            key: forgotPasswordController.emailKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.welcome,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Please enter your email and submit. Check your inbox for an OTP we will send.",
                    style: CustomTextStyles.f12W400(),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  MyTextField(
                    hint: "Email",
                    validator: Validators.checkEmailField,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    controller: forgotPasswordController.emailController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryElevatedButton(
                    onPressed: () {
                      forgotPasswordController.forgotPassword(context);
                    },
                    title: "Send OTP",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
