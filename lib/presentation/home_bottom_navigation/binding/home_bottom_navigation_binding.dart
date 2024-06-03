import 'package:fox/presentation/home_bottom_navigation/controller/home_bottom_navigation_controller.dart';
import 'package:get/get.dart';

class HomeBottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeBottomBarController());
  }}