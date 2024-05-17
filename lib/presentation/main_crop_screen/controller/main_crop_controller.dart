import 'package:get/get.dart';

class mainCropController extends GetxController {
  var activeBtnIndex = 0.obs;
  void updateOnTap(int index){
    activeBtnIndex.value = index;
    update();
  }
}