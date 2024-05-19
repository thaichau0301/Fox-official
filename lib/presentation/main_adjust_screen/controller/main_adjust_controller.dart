import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fox/widgets/custom_placeholder_image_upload.dart';
import 'package:fox/widgets/custom_slider.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import '../../home_bottom_navigation/controller/home_bottom_navigation_controller.dart';

class MainAdjustController extends GetxController {
  var selectedItem = 0.obs;
  var brightnessImg = 0.0.obs;
  var warmthImg = 0.0.obs;
  var contrastImg = 0.0.obs;
  var saturationImg = 0.0.obs;
  var sharpenImg = 0.0.obs;
  final sliderController = Get.put(SliderController());
  final homeController = Get.put(HomeBottomBarController());

  void changeItemIndex(int index) {
    print(index);
    selectedItem.value = index;
    switch(index) {
      case 0: updateValueAdjusts(brightnessImg); ever(condition: true, brightnessImg, (newValue) {
        sliderController.sliderValue(newValue as double);
      }); adjustBrightness(); update(); break;
      case 1: updateValueAdjusts(warmthImg); break;
      case 2: updateValueAdjusts(contrastImg); break;
      case 3: updateValueAdjusts(saturationImg); break;
      case 4: updateValueAdjusts(sharpenImg); break;
    }
    update();
  }
  // void onInit() {
  //   super.onInit();
  //   ever(condition: true, brightnessImg, (newValue) {
  //     sliderController.sliderValue(newValue as double);
  //     print('onInit....' + brightnessImg.toString());
  //
  //   });
  //
  // }
  void updateValueAdjusts(valueElement) {
    sliderController.sliderValue = valueElement;
    // ever(valueElement , (sliderController.sliderValue));
    ever(valueElement, (newValue) {
      sliderController.sliderValue(newValue as double);
    });
    update();
  }
  void adjustBrightness()  {
  final homeController = Get.put(HomeBottomBarController());
  final uploadImage = homeController.image;

  if (uploadImage != null) {
  final tempDir =  getTemporaryDirectory();
  final image = img.decodeImage(File(uploadImage.path).readAsBytesSync())!;

  // Điều chỉnh độ sáng ảnh
  homeController.imagePNG = img.adjustColor(homeController.imagePNG, brightness: 50);
  print(brightnessImg.value);// Thay đổi giá trị brightness tùy theo nhu cầu
  // uploadImage = image;
  List<double> _brightnessMatrix(double value) {
    double brightness = value * 255;
    // Gamma correction values
    double gamma = value > 0 ? (1.0 / (1.0 - value)) : (1.0 + value);
    double invGamma = 1.0 / gamma;

    return [
      gamma, 0, 0, 0, brightness,
      0, gamma, 0, 0, brightness,
      0, 0, gamma, 0, brightness,
      0, 0, 0, 1, 0,
    ];
  }
  // final newImagePath = '${tempDir.path}/adjusted_image.jpg';
  // File(newImagePath).writeAsBytesSync(img.encodeJpg(image));

  // Get.to(ImageViewer(imagePath: newImagePath));
  }
}
}