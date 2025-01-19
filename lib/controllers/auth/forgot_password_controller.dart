import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_app/screens/auth/login_screen.dart';
import 'package:video_app/utils/widgets/loading.dart';
import 'package:video_app/utils/widgets/snackbar.dart';

class ForgotPasswordController extends ChangeNotifier {
  final emailKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
//  forgot password
  Future<void> forgotPassword(BuildContext context) async {
    if (emailKey.currentState!.validate()) {
      final ProgressDialog loading = ProgressDialog();
      loading.show();

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        showSuccess(
            "Password reset email sent successfully to ${emailController.text}!");
        emailController.clear();

        Get.offAndToNamed(LoginScreen.routeName);
      } on FirebaseAuthException catch (e) {
        log("catch condition reached $e");
        showError(e.message!);
        loading.hide();
      } finally {
        loading.hide();

        loading.hide();
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    emailKey.currentState!.reset();
    super.dispose();
  }
}
