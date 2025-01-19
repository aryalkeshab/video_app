import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_app/controllers/screen_controller/home_controller.dart';
import 'package:video_app/core/hive/database_service.dart';
import 'package:video_app/core/hive/video_model.dart';

class CommentPopup extends StatelessWidget {
  final VideoModel videoModel;
  const CommentPopup({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    final bottomSheetBackgroundColor =
        Theme.of(Get.context!).bottomSheetTheme.backgroundColor ?? Colors.white;
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(Get.context!).size.height / 2,
        width: MediaQuery.of(Get.context!).size.width,
        decoration: BoxDecoration(
          color: bottomSheetBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // Title of the bottom sheet
            const Text(
              "Comments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // List of previous comments
            Expanded(
              child: ListView.builder(
                itemCount: videoModel.comments!.length, // List of comments
                itemBuilder: (context, index) {
                  final comment = videoModel.comments![index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/placeholder.png"),
                    ),
                    title: Text(
                      comment.userName ?? comment.userId ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      comment.comment.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Divider
            const Divider(thickness: 1, color: Colors.grey),

            // Input field for adding new comments
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: Get.find<HomeController>()
                        .commentController, // A controller for the input
                    decoration: InputDecoration(
                      hintText: "Write a comment...",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () async {
                    controller.handleUserComment(
                        controller.commentController.text,
                        FirebaseAuth.instance.currentUser!.uid,
                        videoModel.id!);
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
