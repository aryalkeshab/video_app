// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoModelAdapter extends TypeAdapter<VideoModel> {
  @override
  final int typeId = 0;

  @override
  VideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoModel(
      id: fields[0] as String?,
      videoPath: fields[1] as String?,
      title: fields[2] as String?,
      description: fields[3] as String?,
      thumbnailPath: fields[4] as String?,
      date: fields[5] as String?,
      likes: (fields[6] as List?)?.cast<VideoLikeModel>(),
      comments: (fields[7] as List?)?.cast<VideoCommentModel>(),
      views: fields[8] as int?,
      userId: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.videoPath)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.thumbnailPath)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.likes)
      ..writeByte(7)
      ..write(obj.comments)
      ..writeByte(8)
      ..write(obj.views)
      ..writeByte(9)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoLikeModelAdapter extends TypeAdapter<VideoLikeModel> {
  @override
  final int typeId = 1;

  @override
  VideoLikeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoLikeModel(
      userId: fields[0] as String?,
      videoId: fields[1] as String?,
      date: fields[2] as String?,
      likeId: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoLikeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.videoId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.likeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoLikeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoCommentModelAdapter extends TypeAdapter<VideoCommentModel> {
  @override
  final int typeId = 2;

  @override
  VideoCommentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoCommentModel(
      userId: fields[0] as String?,
      videoId: fields[1] as String?,
      date: fields[2] as String?,
      commentId: fields[3] as int?,
      comment: fields[5] as String?,
      userName: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoCommentModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.videoId)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.commentId)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.userName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoCommentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
