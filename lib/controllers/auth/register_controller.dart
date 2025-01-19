import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_app/screens/dashboard/dashboard_panel.dart';
import 'package:video_app/screens/home/home_screen.dart';
import 'package:video_app/utils/widgets/loading.dart';
import 'package:video_app/utils/widgets/snackbar.dart';

class RegisterController extends GetxController {
  final registrationKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  final ProgressDialog loading = ProgressDialog();

  RxBool isLoading = false.obs;

  RxBool showPassword = RxBool(false);
  RxBool showConPassword = RxBool(false);

  void onForgetPassword() {}

  void onEyeClick() {
    showPassword.value = !showPassword.value;
  }

  void onconEyeClick() {
    showConPassword.value = !showConPassword.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

// Register user with email and password
  Future<void> signUpWithEmailPassword() async {
    if (!registrationKey.currentState!.validate()) return; // Validate form

    loading.show();

    try {
      // Create user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user == null) {
        // Handle the case where the user is null
        return;
      }

      // Add user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user!.email, // Store the email
        'uid': userCredential.user!.uid, // Store the user's UID
        'name': nameController.text, // Optional: Store the user's name
        'profile_picture': '', // Optional: Store profile picture URL if needed
        'date_joined': FieldValue.serverTimestamp(), // Store join date
      });

      // Clear the input fields
      emailController.clear();
      passwordController.clear();

      loading.hide();
      showSuccess("User signed up successfully!");

      Get.offAllNamed(DashBoardPanel.routeName);

      // SnackBar.success(Get.context!, message: "User signed up successfully!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showError("Email already in use. Please use a different email.");

        loading.hide();
      } else {
        showError("Registration failed. Please try again.");
        loading.hide();
      }
    } catch (e) {
      showError("Registration failed. Please try again.");
      loading.hide();
    } finally {
      // loading.hide();
      loading.hide();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    registrationKey.currentState!.reset();
    super.dispose();
  }
}
