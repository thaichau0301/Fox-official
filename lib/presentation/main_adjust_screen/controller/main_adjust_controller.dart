import 'package:get/get.dart';

class MainAdjustController extends GetxController {
  var selectedItem = 0.obs;

  void changeItemIndex(int index) {
    print(index);
    selectedItem.value = index;
    update();
  }
}