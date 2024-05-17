
import 'package:get/get.dart';

class HomeBottomBarController extends GetxController {
  var tabIndex = 0.obs;
  void changeTab(int index) {
    tabIndex.value = index;
    if(index == 1) Get.toNamed('/main_navigation');
    update();
  }
}