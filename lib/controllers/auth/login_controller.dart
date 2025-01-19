import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_app/screens/dashboard/dashboard_panel.dart';
import 'package:video_app/screens/home/home_screen.dart';
import 'package:video_app/utils/widgets/loading.dart';
import 'package:video_app/utils/widgets/snackbar.dart';

class LoginController extends GetxController {
  // final loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs; // Reactive loading state

  RxBool showPassword = RxBool(false);
  final ProgressDialog loading = ProgressDialog();

  void onForgetPassword() {}

  void onEyeClick() {
    showPassword.value = !showPassword.value;
  }

  Future<void> signInWithEmailPassword(BuildContext context) async {
    // if (loginKey.currentState!.validate()) {
    //   log("loading is being displayed");

    // }
    try {
      loading.show();

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        userCredential.user!.getIdToken().then((token) async {
          if (token != null) {
            if (Get.isRegistered<LoginController>()) {
              emailController.clear();
              passwordController.clear();
            }
            loading.hide();
            showSuccess("Login successful");
            // Get.offAllNamed(HomeScreen.routeName);

            Get.offAllNamed(DashBoardPanel.routeName);
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      loading.hide();
      String errorMessage = "An error occurred during login.";
      if (e.code == 'invalid-credential') {
        errorMessage =
            "Invalid credential. Please check your email and password.";
      } else if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password. Please try again.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      } else if (e.code == 'user-disabled') {
        errorMessage = "This account has been disabled.";
      } else if (e.code == 'too-many-requests') {
        errorMessage = "Too many login attempts. Please try again later.";
      }
      showError("${e.message}");
    } finally {
      loading.hide();
    }
  }

  ValueNotifier userCredential = ValueNotifier('');
  List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
// sign in with google
  Future<void> signInWithGoogle() async {
    try {
      loading.show();

      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        loading.hide();
        showError("Google sign-in canceled");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        loading.hide();
        showError("Failed to retrieve authentication tokens");
        return;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential firebaseUserCredential =
          await _auth.signInWithCredential(credential);

      final User? user = firebaseUserCredential.user;

      if (user != null) {
        // Firestore update in the background
        await (FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'email': user.email,
          'uid': user.uid,
          'name': googleUser.displayName ?? 'Unknown',
          'profile_picture': googleUser.photoUrl ?? '',
          'date_joined': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true)));

        final token = await user.getIdToken();
        if (token!.isNotEmpty) {
          // final coreController = Get.find<CoreController>();
          // await coreController.loadCurrentUser();

          loading.hide();
          showSuccess("Login successful");

          // if (!Get.currentRoute.endsWith(DashBoardPanel.routeName)) {
          Get.offAllNamed(DashBoardPanel.routeName);
          // }
        } else {
          loading.hide();
          showError("Failed to retrieve token");
        }
      }
    } catch (e) {
      loading.hide();
      // showError("Error signing in with Google: ${e.toString()}");
      if (e is PlatformException) {
        print("Details: ${e.details}");
        print("Code: ${e.code}");
      }
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
