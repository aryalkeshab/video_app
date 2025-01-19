import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_app/core/hive/database_service.dart';
import 'package:video_app/core/hive/video_model.dart';

class HomeController extends GetxController {
  RxList<VideoModel> staticVideos = RxList();
  RxnString videoId = RxnString(); // this id for socket to update that id
  final commentController = TextEditingController();
  PageController pageController = PageController(initialPage: 0);

  HiveDatabaseService hiveDatabaseService = HiveDatabaseService();
  Timer? _botCommentTimer;
  final List<Map<String, String>> comments = [];

  Future<void> getAllVideos() async {
    Future.delayed(const Duration(seconds: 1));
    List<VideoModel> videos = hiveDatabaseService.getAllVideos();
    staticVideos.value = videos;
    update();
  }

  void handleUserComment(
      String newComment, String userId, String videoId) async {
    final newComment = commentController.text.trim();

    HiveDatabaseService hiveDatabaseService = HiveDatabaseService();
    if (newComment.isNotEmpty) {
      // Save the comment to the database
      String userName = await getUserName(userId);
      hiveDatabaseService.addComment(
        videoId,
        VideoCommentModel(
          userId: userId,
          userName: userName,
          comment: newComment,
          date: DateTime.now().toString(),
          videoId: videoId,
        ),
      );

      getAllVideos(); // Refresh video list

      // Handle user comment with the bot timer
      handleBotComment(
        newComment,
        userId,
        videoId,
      );
    }
  }

  void handleBotComment(String newComment, String userId, String videoId) {
    if (newComment.isNotEmpty) {
      commentController.clear();

      _botCommentTimer?.cancel();

      _botCommentTimer = Timer(const Duration(seconds: 5), () async {
        final randomComment = _generateRandomComment();

        hiveDatabaseService.addComment(
          videoId,
          VideoCommentModel(
            userId: "Bot",
            comment: randomComment,
            date: DateTime.now().toString(),
            videoId: videoId,
          ),
        );
        await getAllVideos();
      });
    }
  }

  String _generateRandomComment() {
    final botComments = [
      "Great point!",
      "I agree!",
      "Interesting perspective!",
      "Thanks for sharing!",
      "Well said!",
    ];
    botComments.shuffle();
    return botComments.first;
  }

  Future<String> getUserName(String userId) async {
    // from firestore
    final user =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return user['name'];
  }

  bool isLiked = false;
  Future<void> handleVideoLike(String videoId) async {
    // Toggle the like status

    final homeController = Get.find<HomeController>();
    final hiveDatabaseService = HiveDatabaseService();
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    update();
    // Fetch existing likes for the video
    List<VideoLikeModel>? likes = await hiveDatabaseService.getLikes(videoId);

    if (likes != null && likes.any((like) => like.userId == currentUserId)) {
      // If the current user has already liked the video, remove the like

      await hiveDatabaseService.removeLike(videoId, currentUserId);
      update();
    } else {
      isLiked = !isLiked;

      update(); // Update the UI state immediately

      Future.delayed(const Duration(milliseconds: 500), () {
        isLiked = false;
        update();
      });
      // Otherwise, add a new like
      hiveDatabaseService.addLike(
        videoId,
        VideoLikeModel(
          userId: currentUserId,
          date: DateTime.now().toIso8601String(),
          videoId: videoId,
          likeId: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      update();
    }

    // Refresh video list and update UI
    await homeController.getAllVideos();
    update();
  }

  bool? isVideoPaused = false;

  @override
  void onInit() async {
    await getAllVideos();
    super.onInit();
  }

  @override
  void onClose() {
    _botCommentTimer
        ?.cancel(); // Clean up the timer when controller is disposed
    super.onClose();
  }

  @override
  void dispose() {
    commentController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
