import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fox/presentation/main_screen/controller/main_screen_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import 'package:path/path.dart';

class CropScreen {
  final isLoading = false.obs;
  final hasError = false.obs;
  final mainController = Get.find<MainScreenController>();
  final Primitives primitives = new Primitives();

  Future<void> CropImage(String path) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      CroppedFile? cropImage = await ImageCropper().cropImage(
        sourcePath: path,
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
        // clear mark up to avoid duplicate when back to main
        mainController.clearMarkup();
        try {
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