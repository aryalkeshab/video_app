import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_app/controllers/auth/login_controller.dart';
import 'package:video_app/screens/auth/forgot_password_screen.dart';
import 'package:video_app/screens/auth/register_screen.dart';
import 'package:video_app/screens/dashboard/dashboard_panel.dart';
import 'package:video_app/screens/home/home_screen.dart';
import 'package:video_app/utils/constants/colors.dart';
import 'package:video_app/utils/constants/icon_path.dart';
import 'package:video_app/utils/constants/image_path.dart';
import 'package:video_app/utils/constants/validators.dart';
import 'package:video_app/utils/widgets/elevated_button.dart';
import 'package:video_app/utils/widgets/outline_button.dart';
import 'package:video_app/utils/widgets/password_field.dart';
import 'package:video_app/utils/widgets/text_field.dart';
import 'package:video_app/utils/widgets/text_style.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login-screen";
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final c = Get.find<LoginController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: Form(
          key: loginKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.welcome,
                    height: 150,
                    width: 200,
                  ),
                  MyTextField(
                    hint: "Email",
                    controller: c.emailController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    validator: Validators.checkEmailField,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => PasswordField(
                      hint: "Password",
                      showPassword: c.showPassword.value,
                      onEyeClick: c.onEyeClick,
                      controller: c.passwordController,
                      textInputAction: TextInputAction.done,
                      // onSubmit: (_) => c.signInWithEmailPassword,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(ForgotPasswordScreen.routeName);
                      },
                      child: Text(
                        "Forgot Password?",
                        style:
                            CustomTextStyles.f16W500(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  PrimaryElevatedButton(
                    // onPressed: c.onSubmit,
                    onPressed: () {
                      if (loginKey.currentState?.validate() == true) {
                        c.signInWithEmailPassword(context);
                      }
                    },
                    title: "Log In",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: CustomTextStyles.f16W500(),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(RegisterScreen.routeName);
                        },
                        child: Text(
                          "Sign up",
                          style: CustomTextStyles.f16W500(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Divider(
                          color: AppColors.smallText,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        "or",
                        style: CustomTextStyles.f16W500(
                            color: AppColors.smallText),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Divider(
                          color: AppColors.smallText,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  OutlineButton(
                    prefixIconPath: IconPath.google,
                    onPressed: () {
                      c.signInWithGoogle();
                    },
                    title: "Continue with Google",
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
