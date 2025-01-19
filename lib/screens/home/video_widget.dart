import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_app/controllers/screen_controller/home_controller.dart';
import 'package:video_app/core/hive/database_service.dart';
import 'package:video_app/core/hive/video_model.dart';
import 'package:video_app/screens/home/comment_popup.dart';

import 'package:video_app/utils/constants/icon_path.dart';
import 'package:video_app/utils/widgets/cache_network_image.dart';
import 'package:video_app/utils/widgets/shadow_container.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final VideoModel videoModel;

  const VideoWidget({
    super.key,
    required this.videoModel,
  });

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget>
    with SingleTickerProviderStateMixin {
  HomeController c = Get.put(HomeController());
  late VideoPlayerController _videoController;

  bool isVideoInitialized = false;
  bool isVideoError = false;

  @override
  void initState() {
    super.initState();

    if (widget.videoModel.videoPath == null ||
        widget.videoModel.videoPath!.isEmpty) {
      return;
    }

    try {
      _videoController = VideoPlayerController.asset(
        widget.videoModel.videoPath!,
        videoPlayerOptions: VideoPlayerOptions(),
      );
      _initializeVideo();
    } catch (error) {
      setState(() {
        isVideoError = true;
      });
    }
  }

  Future<void> _initializeVideo() async {
    try {
      await _videoController.initialize();
      setState(() {
        isVideoInitialized = true;
      });
      _videoController.play();
    } catch (error) {
      setState(() {
        isVideoError = true;
      });
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);

    return GetBuilder<HomeController>(builder: (c) {
      return Stack(
        fit: StackFit.expand,
        children: [
          isVideoInitialized
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _videoController.value.isPlaying
                              ? _videoController.pause()
                              : _videoController.play();
                        });
                      },
                      onDoubleTap: () async {
                        await c.handleVideoLike(widget.videoModel.id!);
                        setState(() {});
                      },
                      child: c.isLiked
                          ? Stack(
                              children: [
                                VideoPlayer(_videoController),
                                Container(
                                  color: Colors.black26.withOpacity(0.5),
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.red.withOpacity(0.8),
                                      size: 100,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : !_videoController.value.isPlaying
                              ? Stack(
                                  children: [
                                    VideoPlayer(_videoController),
                                    Container(
                                      color: Colors.black26.withOpacity(0.5),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.play,
                                          size: 75,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : AspectRatio(
                                  aspectRatio:
                                      _videoController.value.aspectRatio,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      VideoPlayer(_videoController),
                                    ],
                                  ),
                                ),
                    ),
                  ),
                )
              : isVideoError
                  ? const Center(child: Text("Error loading video."))
                  : const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 140,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await c.handleVideoLike(widget.videoModel.id!);
                    },
                    child: Icon(
                      widget.videoModel.likes!.any(
                        (like) =>
                            like.userId ==
                            FirebaseAuth.instance.currentUser!.uid,
                      )
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: widget.videoModel.likes!.any(
                        (like) =>
                            like.userId ==
                            FirebaseAuth.instance.currentUser!.uid,
                      )
                          ? Colors.red
                          : Colors.white,
                      size: 30,
                    ),
                  ),
                  Visibility(
                    visible: widget.videoModel.likes!.isNotEmpty,
                    child: Text(
                      '${widget.videoModel.likes?.length ?? 0} ', // Number of views
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: widget.videoModel.likes!.isNotEmpty ? 10 : 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            CommentPopup(
                              videoModel: widget.videoModel,
                            ),
                            isScrollControlled: true,
                            enableDrag: true,
                          );
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CustomShadowContainer(
                                  child: SvgPicture.asset(
                                    IconPath.comment,
                                    height: 25,
                                    width: 25,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      widget.videoModel.comments!.length
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),

                      //share

                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          await Share.share(widget.videoModel.videoPath!);
                        },
                        child: Column(
                          children: [
                            CustomShadowContainer(
                              child: SvgPicture.asset(
                                IconPath.share,
                                height: 25,
                                width: 25,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.2), // Semi-transparent background
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.videoModel.title ?? 'No Title', // Video title
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.videoModel.description ??
                          'No Description', // Video description
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.videoModel.date?.substring(0, 10) ??
                              'Unknown Date', // Date of upload
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                        // Row(
                        //   children: [

                        //     Icon(
                        //       widget.videoModel.likes!.isNotEmpty
                        //           ? Icons.favorite
                        //           : Icons.favorite_border,
                        //       size: 16,
                        //       color: Colors.red,
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.videoModel.userId ?? 'Unknown', // User ID
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
