import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_app/controllers/auth/register_controller.dart';
import 'package:video_app/screens/auth/login_screen.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/constants/icon_path.dart';
import 'package:video_app/utils/constants/validators.dart';
import 'package:video_app/utils/widgets/elevated_button.dart';
import 'package:video_app/utils/widgets/password_field.dart';
import 'package:video_app/utils/widgets/text_field.dart';
import 'package:video_app/utils/widgets/text_style.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "/register-screen";

  final registrationController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Form(
              key: registrationController.registrationKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: CustomTextStyles.f20W600(),
                  ),
                  Text(
                    "Create your account",
                    style: CustomTextStyles.f12W400(),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  MyTextField(
                      hint: "Name",
                      controller: registrationController.nameController,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      textCapitalization: TextCapitalization.none,
                      validator: Validators.checkFieldEmpty),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    hint: "Email",
                    controller: registrationController.emailController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    validator: Validators.checkEmailField,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => PasswordField(
                      hint: "Password",
                      showPassword: registrationController.showPassword.value,
                      onEyeClick: registrationController.onEyeClick,
                      controller: registrationController.passwordController,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => PasswordField(
                      hint: "Confirm password",
                      textInputAction: TextInputAction.done,
                      onEyeClick: registrationController.onconEyeClick,
                      showPassword:
                          registrationController.showConPassword.value,
                      validator: (value) => Validators.checkConfirmPassword(
                        registrationController.passwordController.text,
                        value,
                      ),
                      controller:
                          registrationController.confirmPasswordController,
                      onSubmit: (_) =>
                          registrationController.signUpWithEmailPassword(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => PrimaryElevatedButton(
                      onPressed: registrationController.isLoading.value
                          ? null
                          : () {
                              registrationController.signUpWithEmailPassword();
                            },
                      title: registrationController.isLoading.value
                          ? "Registering..."
                          : "Register",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: CustomTextStyles.f14W400(
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      InkResponse(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
                          style: CustomTextStyles.f14W400(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
