import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  void onInit(){
    super.onInit();
    try {
      // holder File image
      editedImage.value = Get.arguments['fileImage'];
    } catch(e) {
      print(e);
    }
    // holder name of image picked
    nameImage = Get.arguments['nameImage'];
  }
  void onClose(){
    Get.deleteAll();
  }
  RxInt tabIndex = 0.obs;
  void changeBottom(int index) {
    tabIndex.value = index;
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

  Future<void> saveImageStudio() async {
    final user = FirebaseAuth.instance.currentUser;
    // ... (cacheDir logic if needed)

    String time = DateTime.now().toIso8601String();
    if (user != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final userFolderRef = storageRef.child('user_folders/${user.uid}');

      try {final image = await screenshotController.capture(); // Use await here
      if (image != null) {
        final fileRef = userFolderRef.child('editedImage_$time');
        await fileRef.putData(image);
        // Handle successful upload (e.g., show a success message)
      } else {
        // Handle case where capture() returns null
      }
      } catch (e) {
        // Handle potential errors during capture or upload
        print('Error saving image: $e');
      }
    }
  }

  Future<void> changeTabIndex(int index) async {
    switch(index)  {
      case 0: break;
      case 1: {
        screenshotController.capture().then((Uint8List? imageFile) {
          Get.find<TextController>().texts.clear();
          Get.find<StickerController>().stickerInserted.clear();
          // Now check and apply filter
          if (imageFile != null) {
            FiltersScreen().apply(imageFile);
          } else {
            print('image null');
          }
        });
        break;
      }
      case 2: {
        Directory directory = await getApplicationDocumentsDirectory();
        String? path = await screenshotController.captureAndSave(directory.path, fileName: 'c_' + nameImage);
        Get.find<TextController>().texts.clear();
        Get.find<StickerController>().stickerInserted.clear();
        CropScreen().CropImage(path!);
        break;
      }
      case 3: {
        Get.toNamed('enter_text_screen', arguments: {'image' : editedImage.value });
        // delay to fix error splash bottom when route to enter text screen
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