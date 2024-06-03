import 'dart:io';
import 'package:fox/presentation/main_crop_screen/main_crop_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../main_filter_screen/main_filter_screen.dart';

class MainBottomNavController extends GetxController {
  XFile? originalImage;
  // Rx<File>? editedImage = File('').obs;
  Rx<File?> editedImage = Rx<File?>(null);
  String? nameImage;

  void onInit(){
    super.onInit();
    // holder XFile image
    originalImage = Get.arguments['imagePicked']!;
    // holder File image
    editedImage.value = Get.arguments['fileImage']!;
    // holder name of image picked
    nameImage = Get.arguments['nameImage'];
    print(editedImage.value);
  }

  void changeTabIndex(int index) {
    switch(index) {
      // case 0: Get.to(() => AdjustTools()); break;
      case 1: ApplyFilters().apply(); break;
      case 2: CropTools().CropImage(); break;
    }
    update();
  }
}