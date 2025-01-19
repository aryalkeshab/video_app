import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_app/controllers/dashpanel/dashboard_panel_controller.dart';
import 'package:video_app/screens/auth/login_screen.dart';

class ProfileController extends GetxController {
  final RxString name = ''.obs;
  final RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();
    if (Get.isRegistered<DashPanelController>()) {
      Get.delete<DashPanelController>();
    }
    Get.offAllNamed(LoginScreen.routeName);
  }

  Future<void> fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
          name.value = data['name'] ?? 'Username';
          userEmail.value = data['email'] ?? 'Email';
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
