import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccess(String message) {
  Get.snackbar("Success", message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3));
}

void showError(String message) {
  Get.snackbar("Error", message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3));
}
