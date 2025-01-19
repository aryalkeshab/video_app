import 'package:get/get.dart';
import 'package:video_app/controllers/auth/forgot_password_controller.dart';
import 'package:video_app/controllers/auth/register_controller.dart';
import 'package:video_app/controllers/dashpanel/dashboard_panel_controller.dart';
import 'package:video_app/controllers/screen_controller/home_controller.dart';
import 'package:video_app/controllers/auth/login_controller.dart';
import 'package:video_app/controllers/profile/profile_controller.dart';
import 'package:video_app/controllers/screen_controller/splash_controller.dart';
import 'package:video_app/screens/auth/forgot_password_screen.dart';
import 'package:video_app/screens/auth/register_screen.dart';
import 'package:video_app/screens/dashboard/dashboard_panel.dart';
import 'package:video_app/screens/home/home_screen.dart';
import 'package:video_app/screens/auth/login_screen.dart';
import 'package:video_app/screens/profile/profile_screen.dart';
import 'package:video_app/screens/splash_screen.dart';

final List<GetPage> pages = <GetPage>[
  GetPage(
    name: SplashScreen.routeName,
    page: () => SplashScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => SplashController()),
    ),
  ),
  GetPage(
    name: LoginScreen.routeName,
    page: () => LoginScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(
        () => LoginController(),
      ),
    ),
  ),
  GetPage(
    name: RegisterScreen.routeName,
    page: () => RegisterScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => RegisterController()),
    ),
  ),
  GetPage(
    name: DashBoardPanel.routeName,
    page: () => DashBoardPanel(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => DashPanelController());
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => ProfileController());
      },
    ),
  ),
  GetPage(
    name: ForgotPasswordScreen.routeName,
    page: () => ForgotPasswordScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => ForgotPasswordController()),
    ),
  ),
  GetPage(
    name: HomeScreen.routeName,
    page: () => HomeScreen(),
    // binding: BindingsBuilder(
    //   () => Get.lazyPut(() => HomeController()),
    // ),
  ),
  GetPage(
    name: ProfileScreen.routeName,
    page: () => ProfileScreen(),
    // binding: BindingsBuilder(
    //   () => Get.lazyPut(() => ProfileController()),
    // ),
  ),
];
