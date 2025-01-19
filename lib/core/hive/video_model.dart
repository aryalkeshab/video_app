import 'package:hive/hive.dart';

part 'video_model.g.dart';

@HiveType(typeId: 0)
class VideoModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? videoPath;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? thumbnailPath;

  @HiveField(5)
  String? date;

  @HiveField(6)
  List<VideoLikeModel>? likes;

  @HiveField(7)
  List<VideoCommentModel>? comments;

  @HiveField(8)
  int? views;

  @HiveField(9)
  String? userId;

  VideoModel({
    this.id,
    this.videoPath,
    this.title,
    this.description,
    this.thumbnailPath,
    this.date,
    this.likes,
    this.comments,
    this.views,
    this.userId,
  });
}

@HiveType(typeId: 1)
class VideoLikeModel {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  String? videoId;

  @HiveField(2)
  String? date;

  @HiveField(3)
  int? likeId;

  VideoLikeModel({
    this.userId,
    this.videoId,
    this.date,
    this.likeId,
  });
}

@HiveType(typeId: 2)
class VideoCommentModel {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  String? videoId;

  @HiveField(2)
  String? date;

  @HiveField(3)
  int? commentId;

  @HiveField(5)
  String? comment;

  @HiveField(6)
  String? userName;

  VideoCommentModel({
    this.userId,
    this.videoId,
    this.date,
    this.commentId,
    this.comment,
    this.userName,
  });
}
