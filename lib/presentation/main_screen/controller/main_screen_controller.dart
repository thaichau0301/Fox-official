import 'dart:io';
import 'package:fox/presentation/main_crop_screen/main_crop_screen.dart';
import 'package:get/get.dart';
import '../../main_filter_screen/main_filter_screen.dart';

class MainScreenController extends GetxController {
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
  RxInt tabIndex = 0.obs;
  void changeBottom(int index) {
    tabIndex.value = index;
    update();
  }
  Future<void> changeTabIndex(int index) async {
    switch(index)  {
      // case 0: Get.to(() => AdjustTools()); break;
      case 1: FiltersScreen().apply(); break;
      case 2: CropScreen().CropImage(); break;

      case 3: {
        Get.toNamed('enter_text_screen', arguments: {'image' : editedImage.value });
        Future.delayed (Duration(milliseconds: 200),() => changeBottom(index));
        break;
      }
      case 4: changeBottom(index); break;
      case 5: Get.toNamed('sticker_screen', arguments: {'image' : editedImage.value }); break;

    }
    update();
  }
  void updateEditedImage(File newFile)  {
    // final File? temporaryFileImage = editedImage.value;
     editedImage.value =  newFile;
    // temporaryFileImage!.deleteSync();
     update();

  }
  RxInt tabText = 0.obs;
  void changeTabText(int index) {
    tabText.value = index;
    update();
  }
}