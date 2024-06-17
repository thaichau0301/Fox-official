import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
import '../../widgets/custom_navigation_top.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import '../main_screen/controller/main_screen_controller.dart';

class FiltersScreen{
  MainScreenController mainController = Get.find();
  Future<void> apply(Uint8List _image) async {
    try {
      Map getImage = await Get.to(() => PhotoFilterSelector(
                  customAppBar: navigationTop(),
                  image: img.decodeImage(_image)!,
                  filters: presetFiltersList,
                  filename: mainController.nameImage,
                  loader: const Center(child: CircularProgressIndicator(strokeWidth: 1.0, )),
                  fit: BoxFit.contain,
                  isFilter: true,
              )
      );
      if (getImage.containsKey('image_filtered')) {
        // clear mark up to avoid duplicate when back to main
        mainController.clearMarkup();

        mainController.editedImage.value!.deleteSync(); // delete old file
        mainController.updateEditedImage(getImage['image_filtered']);
        Future.delayed(Duration(milliseconds: 100));
      }
    }
    catch (e){
      print('error filters image $e');
    }
  }
}
