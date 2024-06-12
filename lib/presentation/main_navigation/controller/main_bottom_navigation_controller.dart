import 'dart:io';
import 'package:fox/presentation/draw_screen/draw_screen.dart';
import 'package:fox/presentation/main_crop_screen/main_crop_screen.dart';
import 'package:get/get.dart';
import '../../main_filter_screen/main_filter_screen.dart';
import '../../text_edit_screen/text_edit_screen.dart';

class MainBottomNavController extends GetxController {
  // XFile? originalImage;
  Rx<File?> editedImage = Rx<File?>(null);
  String nameImage = '';
  void onInit(){
    super.onInit();
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
      case 5: Get.to(() => TextEditTools()); break;
      case 6: Get.to(() => DrawTools()); break;
    }
    update();
  }
  void updateEditedImage(File newFile)  {
    // final File? temporaryFileImage = editedImage.value;
     editedImage.value =  newFile;
    // temporaryFileImage!.deleteSync();
     update();

  }
}