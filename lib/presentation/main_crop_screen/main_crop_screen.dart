import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../main_navigation/controller/main_bottom_navigation_controller.dart';
import 'package:path/path.dart';
class CropTools {
  var isLoading = false.obs;
  var hasError = false.obs;
  final mainController = Get.find<MainBottomNavController>();
  Primitives primitives = new Primitives();
  Future<void> CropImage() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      print('sourcePath for crop image' + mainController.editedImage.value!.path);
      CroppedFile? cropImage = await ImageCropper().cropImage(
        sourcePath: mainController.editedImage.value!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '' ,
            toolbarWidgetColor: Colors.white,
            toolbarColor: Colors.black87,
            statusBarColor: Colors.black87,
            backgroundColor: primitives.surface_secondary,
            activeControlsWidgetColor: Colors.blue,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
        compressQuality: 100,
        compressFormat: ImageCompressFormat.jpg,
      );
      if(File(cropImage!.path).existsSync()) {
        try {
          // default name file of crop so long, i change it to c_originalNameImage
          int lastIndex = mainController.editedImage.value!.path.lastIndexOf(
              '/');
          final nameImage = basename(mainController.editedImage.value!.path);
          // create new file name for assign crop image, fix error not update UI in main
          final newFileImage = mainController.editedImage.value!.path.substring(
              0, lastIndex) + '/c_' + nameImage;
          // delete old file image
          mainController.editedImage.value!.deleteSync();
          // copy new image was cropped to that location of old file
          mainController.updateEditedImage(
              File(cropImage.path).copySync(newFileImage));
          // delete file cropped image  was create by package , sync to fix error not find file
          Future.delayed(Duration(milliseconds: 100), () {
            File(cropImage.path).deleteSync();
          });
        }
        catch (e) {
          print("Error update crop image: $e");
        }
      }
    }
    catch(e)
    {
      print("Error crop image: $e");
    }
    finally
    {
      isLoading.value = false;
    }
  }

}