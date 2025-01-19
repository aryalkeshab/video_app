import 'package:hive/hive.dart';
import 'package:video_app/core/hive/video_model.dart';

class HiveDatabaseService {
  late Box<VideoModel> videoBox = Hive.box<VideoModel>('videos');

  Future<void> saveVideo(VideoModel video) async {
    video.id ??= DateTime.now().toString();
    Future.delayed(const Duration(milliseconds: 300));
    await videoBox.put(video.id, video);
  }

  VideoModel? getVideo(String id) {
    return videoBox.get(id);
  }

  Future<void> editVideo(VideoModel video) async {
    if (video.id != null) {
      await videoBox.put(video.id, video);
    }
  }

  Future<void> deleteVideo(String id) async {
    await videoBox.delete(id);
  }

  List<VideoModel> getAllVideos() {
    return videoBox.values.toList();
  }

  Future<List<VideoLikeModel>?> getLikes(String videoId) async {
    final video = videoBox.values.firstWhere(
      (v) => v.id == videoId,
    );
    return video?.likes;
  }

  Future<void> removeLike(String videoId, String userId) async {
    final video = videoBox.get(videoId);
    if (video != null) {
      video.likes?.removeWhere((like) => like.userId == userId);
      videoBox.put(videoId, video);
    }
  }

  Future<List<VideoCommentModel>?> getComments(String videoId) async {
    final video = videoBox.values.firstWhere(
      (v) => v.id == videoId,
    );
    return video?.comments;
  }

  void addLike(String videoId, VideoLikeModel like) {
    final video = videoBox.get(videoId);
    if (video != null) {
      like.likeId ??= DateTime.now().millisecondsSinceEpoch;
      video.likes ??= [];
      video.likes!.add(like);
      videoBox.put(videoId, video);
    }
  }

  void addComment(String videoId, VideoCommentModel comment) {
    final video = videoBox.get(videoId);
    if (video != null) {
      comment.commentId ??= DateTime.now().millisecondsSinceEpoch;
      video.comments ??= [];
      video.comments!.add(comment);
      videoBox.put(videoId, video);
    }
  }

  void clearVideos() {
    videoBox.clear();
  }
}

// final dbService = HiveDatabaseService();

// void main() async {
//   await dbService.initialize();

//   // Add a new video
//   final video = VideoModel(videoPath: 'path/to/video.mp4', title: 'My Video');
//   await dbService.saveVideo(video);

//   // Retrieve video
//   final retrievedVideo = dbService.getVideo(video.id!);

//   // Add a like
//   dbService.addLike(
//       video.id!, VideoLikeModel(userId: 'user123', date: '2025-01-15'));

//   // Add a comment
//   dbService.addComment(
//       video.id!, VideoCommentModel(userId: 'user456', date: '2025-01-15'));
// }
