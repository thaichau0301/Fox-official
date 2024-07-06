import 'dart:io';
import 'package:fox/presentation/main_crop_screen/main_crop_screen.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import '../../main_filter_screen/main_filter_screen.dart';
import '../../sticker_screen/controller/sticker_controller.dart';
import '../../text_edit_screen/controller/text_edit_controller.dart';
import 'package:gal/gal.dart';
class MainScreenController extends GetxController {
  // XFile? originalImage;
  Rx<File?> editedImage = Rx<File?>(null);
  String nameImage = '';
  ScreenshotController screenshotController = Get.put(ScreenshotController());
  RxInt tabIndex = (-1).obs;
  void onInit(){
    super.onInit();
    editedImage.value = Get.arguments['fileImage'];
    nameImage = Get.arguments['nameImage'];
  }
  void resetBottomBar(){
    tabIndex.value = -1;
    update();
  }

  Uint8List? readyImageFilter()  {
    try {
      screenshotController.capture().then((Uint8List? imageFile) {
        Get.find<TextController>().texts.clear();
        Get.find<StickerController>().stickerInserted.clear();
        return imageFile;
      });
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }
  void saveImageGallery() async {
    screenshotController.capture().then((Uint8List? image) {
      Gal.putImageBytes(image!, name: nameImage, album: 'Fox');
    });
  }


  Future hideAllChooseMarkup() async {
    int listStickerLength = Get.find<StickerController>().stickerInserted.length;
    for(int i=0; i<listStickerLength; i++){
      Get.find<StickerController>().stickerInserted[i].isChoose = false;
    }
    update();
  }
  Future<void> navigateToFilter() async {
    // hide buttons of mark up before screen shot and pass that image to other screen
    await hideAllChooseMarkup();
    await screenshotController.capture().then((Uint8List? imageFile) {
      // Now check and apply filter
      if (imageFile != null) {
        FiltersScreen().apply(imageFile);
      } else {
        print('image null');
      }
    });
  }
  Future<void> navigateToCrop() async {
    // hide buttons of mark up before screen shot and pass that image to other screen
    await hideAllChooseMarkup();
    Directory directory = await getApplicationDocumentsDirectory();
    String? path = await screenshotController
        .captureAndSave(directory.path, fileName: 'c_' + nameImage);
    CropScreen().CropImage(path!);
  }
  void navigateToText(int index) {
    Get.toNamed('enter_text_screen',
        arguments: {'image': editedImage.value});
    // delay to fix error splash bottom when route to enter text screen
    Future.delayed(Duration(milliseconds: 200),
            () => {tabIndex.value = index, update()});
  }
  void navigateToUpdateText() {
    tabIndex.value = 3;
    update();
  }
  void changeTabIndex(int index) async {
    switch(index)  {
      case 0:
        {
          tabIndex.value = index;
          update();
          break;
        }
      case 1:
        {
          navigateToFilter();
          break;
        }
      case 2:
        {
          navigateToCrop();
          break;
        }
      case 3:
      {
        navigateToText(index);
        break;
      }
      case 4: tabIndex.value = index; update(); break;
      case 5: {
        Get.toNamed('sticker_screen', arguments: {'image' : editedImage.value});
        update();
        break;
      }
    }
  }
  void clearMarkup() {
    Get.find<TextController>().texts.clear();
    Get.find<StickerController>().stickerInserted.clear();
    update();
  }
  void updateEditedImage(File newFile)  {
     editedImage.value =  newFile;
     update();
  }
  RxInt tabText = 0.obs;
  void changeTabText(int index) {
    tabText.value = index;
    update();
  }
}