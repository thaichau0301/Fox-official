import 'package:fox/presentation/home_bottom_bar/home_nav_screen.dart';
import 'package:fox/presentation/main_insert_screen/main_insert_screen.dart';
import 'package:fox/presentation/text_edit_screen/text_edit_screen.dart';

import '../core/app_export.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/forget_password_one_screen/binding/forget_password_one_binding.dart';
import '../presentation/forget_password_one_screen/forget_password_one_screen.dart';
import '../presentation/forget_password_two_screen/binding/forget_password_two_binding.dart';
import '../presentation/forget_password_two_screen/forget_password_two_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/mainBottomNav/bottom_nav_screen.dart';
import '../presentation/main_adjust_screen/main_adjust_screen.dart';
import '../presentation/main_crop_screen/main_crop_screen.dart';
import '../presentation/main_filter_screen/main_filter_screen.dart';
import '../presentation/main_remove_screen/main_remove_screen.dart';
import '../presentation/user_screen/binding/user_binding.dart';
import '../presentation/user_screen/user_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String forgetPasswordTwoScreen = '/forget_password_two_screen';
  static const String forgetPasswordOneScreen = '/forget_password_one_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';
  static const String homeBottomNavBar = '/home_bottom_nav_bar';
  static const String homeScreen = '/home_screen';
  static const String userScreen = '/user_screen';
  static const String mainBottomNavBar = '/main_bottom_nav_bar';
  static const String mainAdjustScreen = '/adjust_screen';
  static const String mainFilterScreen = '/filter_screen';
  static const String mainCropScreen = '/crop_screen';
  static const String mainRemoveScreen = '/remove_screen';
  static const String mainInsertScreen = '/overlay_screen';
  static const String textEditScreen = '/text_edit_screen';

  static List<GetPage> pages = [
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: forgetPasswordTwoScreen,
      page: () => ForgetPasswordTwoScreen(),
      bindings: [ForgetPasswordTwoBinding()],
    ),
    GetPage(
      name: forgetPasswordOneScreen,
      page: () => ForgetPasswordOneScreen(),
      bindings: [ForgetPasswordOneBinding()],
    ),
    GetPage(
      name: homeBottomNavBar,
      page: () => homeBottomBar(),
      // bindings: [UserBinding()],
    ),
    GetPage(
      name: homeScreen,
      page: () => Home(),
      bindings: [UserBinding()],
    ),
    GetPage(
      name: userScreen,
      page: () => UserScreen(),
      bindings: [UserBinding()],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: mainBottomNavBar,
      page: () => mainBottomBar(),
      // bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: mainAdjustScreen,
      page: () => main_adjust(),
      // bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: mainFilterScreen,
      page: () => main_filter(),
      // bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: mainCropScreen,
      page: () => main_crop(),
      // bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: mainRemoveScreen,
      page: () => main_remove(),
      // bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: mainInsertScreen,
      page: () => main_insert(),
      // bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: textEditScreen,
      page: () => text_edit_screen(),
      // bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: initialRoute,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    )
  ];
}
