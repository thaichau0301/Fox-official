
import 'package:get/get.dart';

class mainBarController extends GetxController {
  var tabIndex = 0.obs;
  final flexImage = 10;
  final flexTools = 4;
  final flexBottomBar = 3;
  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}