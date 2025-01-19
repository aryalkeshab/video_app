import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:video_app/core/hive/database_service.dart';
import 'video_model.dart'; // Replace with your actual model import

class VideoUploader {
  Future<void> uploadVideos() async {
    // Load the JSON file
    final String jsonString =
        await rootBundle.loadString('assets/video_metadata.json');
    final List<dynamic> videoList = json.decode(jsonString);
    HiveDatabaseService hiveDatabaseService = HiveDatabaseService();
    // await hiveDatabaseService.initialize();
    int length = hiveDatabaseService.getAllVideos().length;
    if (length > 0) {
      return;
    }

    // Parse and save videos
    for (var videoData in videoList) {
      final video = VideoModel(
        videoPath: videoData['videoPath'],
        title: videoData['title'],
        description: videoData['description'],
        userId: videoData['userId'],
        likes: [],
        comments: [],
        views: 0,
        date: DateTime.now().toString(),
      );

      // Automatically generate and assign an ID
      video.id = DateTime.now().toString();

      // Save video to Hive
      Future.delayed(const Duration(milliseconds: 100));

      await hiveDatabaseService.saveVideo(video);
    }
  }
}
