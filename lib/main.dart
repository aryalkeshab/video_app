import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_app/core/hive/video_model.dart';
import 'package:video_app/core/hive/video_uploader.dart';
import 'package:video_app/firebase_options.dart';
import 'package:video_app/screens/splash_screen.dart';
import 'package:video_app/utils/constants/theme.dart';
import 'package:video_app/utils/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure proper async setup
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  await Hive.initFlutter();
  Hive.registerAdapter(VideoModelAdapter());
  Hive.registerAdapter(VideoLikeModelAdapter());
  Hive.registerAdapter(VideoCommentModelAdapter());
  await Hive.openBox<VideoModel>('videos');

  final uploader = VideoUploader();
  await uploader.uploadVideos();

  runApp(const VideoApp());
}

class VideoApp extends StatelessWidget {
  const VideoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 200),
      getPages: pages,
      theme: CustomTheme.basicTheme(),
      initialRoute: SplashScreen.routeName,
    );
  }
}
