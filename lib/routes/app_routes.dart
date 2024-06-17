import 'package:fox/presentation/sticker_screen/sticker_screen.dart';
import 'package:fox/presentation/studio_screen/studio_screen.dart';
import 'package:fox/presentation/text_edit_screen/form_enter_text.dart';
import '../core/app_export.dart';
import '../presentation/home_bottom_navigation/home_bottom_navigation.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/main_screen/main_screen.dart';
import '../presentation/user_screen/binding/user_binding.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String forgetPasswordTwoScreen = '/forget_password_two_screen';
  static const String forgetPasswordOneScreen = '/forget_password_one_screen';
  static const String initialRoute = '/initialRoute';
  static const String homeScreen = '/home_screen';
  static const String mainScreen = '/main_screen';
  static const String enterTextScreen = '/enter_text_screen';
  static const String stickerScreen = '/sticker_screen';
  static const String studioScreen = '/studio_screen';

  static List<GetPage> pages = [
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeBottomBar(),
      bindings: [UserBinding()],
    ),
    GetPage(
      name: mainScreen,
      page: () => MainScreen(),
    ),
    GetPage(
      name: studioScreen,
      page: () => StudioScreen(),
    ),
    GetPage(
      name: enterTextScreen,
      page: () => EnterText(),
    ),
    GetPage(
      name: stickerScreen,
      page: () => StickerScreen(),
    ),
    GetPage(
      name: initialRoute,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    )
  ];
}
