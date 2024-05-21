import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
class HomeBottomBarController extends GetxController {
  var tabIndex;

  @override
  void onInit()
  {
    super.onInit();
    tabIndex = 0.obs;
  }
  void resetTabIndex(){
    tabIndex.value = 0;
    update();
  }

  void changeTab(int index) {
    tabIndex.value = index;
    if(index == 1) pickImage();
    update();
  }

  File? image;
  var imagePNG;
  Future<void> pickImage() async {
    final image = (await ImagePicker().pickImage(source: ImageSource.gallery));
    final imageTemporary = File(image!.path);
    final bytes = imageTemporary.readAsBytesSync();
    imagePNG = img.encodePng(img.decodeImage(bytes)!);
    Get.toNamed('/main_navigation');
    update();
  }
}