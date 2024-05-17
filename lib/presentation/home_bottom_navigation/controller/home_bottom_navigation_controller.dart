import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class HomeBottomBarController extends GetxController {
  var tabIndex = 0.obs;
  void changeTab(int index) {
    tabIndex.value = index;
    if(index == 1) pickImage();
    update();
  }

  File? image;
  Future<void> pickImage() async {
    final image = (await ImagePicker().pickImage(source: ImageSource.gallery));
    final imageTemporary = File(image!.path);
    this.image = imageTemporary;
    Get.toNamed('/main_navigation');
    update();
  }
}