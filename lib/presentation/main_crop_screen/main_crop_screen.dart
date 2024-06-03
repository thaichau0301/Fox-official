import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../main_navigation/controller/main_bottom_navigation_controller.dart';

class CropTools {
  var isLoading = false.obs;
  var hasError = false.obs;
  final mainController = Get.find<MainBottomNavController>();
  Future<void> CropImage() async {
    try {
      isLoading.value = true;
      hasError.value = false;
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
            toolbarWidgetColor: Colors.black45,
            statusBarColor: Colors.white12,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
        compressQuality: 70,
        compressFormat: ImageCompressFormat.jpg,
      );
      // Load image from cache directory
        try
        {
          int lastIndex = mainController.editedImage.value!.path.lastIndexOf('/');
          final nameImage = mainController.editedImage.value!.path.split('/').last;
          final newFileImage = mainController.editedImage.value!.path.substring(0, lastIndex) + '/c_' + nameImage;
          mainController.editedImage.value = await File(cropImage!.path).copy(newFileImage);
          File(cropImage.path).deleteSync();
        }
        catch (e)
        {
          print("Error loading image: $e");
        }
    }
    catch(e)
    {
      print("Error: $e");
    }
    finally
    {
      isLoading.value = false;
    }
  }

}