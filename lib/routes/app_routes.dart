import 'package:fox/presentation/main_crop_screen/main_crop_screen.dart';
import 'package:fox/presentation/main_filter_screen/main_filter_screen.dart';
import 'package:fox/presentation/sticker_screen/sticker_screen.dart';
import 'package:fox/presentation/text_edit_screen/form_enter_text.dart';
import '../core/app_export.dart';
import '../presentation/forget_password_one_screen/binding/forget_password_one_binding.dart';
import '../presentation/forget_password_one_screen/forget_password_one_screen.dart';
import '../presentation/forget_password_two_screen/binding/forget_password_two_binding.dart';
import '../presentation/forget_password_two_screen/forget_password_two_screen.dart';
import '../presentation/home_bottom_navigation/home_bottom_navigation.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/main_screen/main_screen.dart';
import '../presentation/paint_screen/paint_screen.dart';
import '../presentation/user_screen/binding/user_binding.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String forgetPasswordTwoScreen = '/forget_password_two_screen';
  static const String forgetPasswordOneScreen = '/forget_password_one_screen';
  static const String initialRoute = '/initialRoute';
  static const String homeScreen = '/home_screen';
  static const String mainScreen = '/main_screen';
  static const String filtersScreen = '/filters_screen';
  static const String cropScreen = '/crop_screen';
  static const String enterTextScreen = '/enter_text_screen';
  static const String paintScreen = '/paint_screen';
  static const String stickerScreen = '/sticker_screen';

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
      name: homeScreen,
      page: () => HomeBottomBar(),
      bindings: [UserBinding()],
    ),
    GetPage(
      name: mainScreen,
      page: () => MainScreen(),
    ),
    // GetPage(
    //   name: filtersScreen,
    //   page: () => FiltersScreen(),
    // ),
    // GetPage(
    //   name: cropScreen,
    //   page: () => CropScreen(),
    // ),
    GetPage(
      name: enterTextScreen,
      page: () => EnterText(),
    ),
    // GetPage(
    //   name: paintScreen,
    //   page: () => PaintScreen(),
    // ),
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
