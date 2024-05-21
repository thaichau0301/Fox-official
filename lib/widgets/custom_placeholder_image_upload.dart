import 'dart:io';
import 'dart:typed_data';
import 'package:fox/presentation/home_bottom_navigation/home_bottom_navigation.dart';
import 'package:fox/presentation/main_adjust_screen/controller/main_adjust_controller.dart';
import 'package:fox/widgets/custom_slider.dart';
import 'package:fox/widgets/custom_slider_positive.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:fox/presentation/home_bottom_navigation/controller/home_bottom_navigation_controller.dart';
import 'package:get/get.dart';
final homeController = Get.put(HomeBottomBarController());
final mainAdjustController = Get.put(MainAdjustController());
final sliderController = Get.put(SliderController());
class PlaceHolderImage extends StatelessWidget {
  const PlaceHolderImage({super.key});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 13,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GetBuilder<MainAdjustController>(
          builder: (homeController) => Stack(
            alignment: Alignment.topCenter,
              children: [ adjustBrightness(sliderController.sliderValue/400),
            Text('${sliderController.sliderValue}', style: TextStyle(fontSize: 30, color: Colors.blue),)])

        ),
      ),
    );
  }
  Widget adjustBrightness(brightness) {
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
    return ColorFiltered(
        colorFilter: ColorFilter.matrix(_brightnessMatrix(brightness)),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image:  DecorationImage(image: MemoryImage((homeController.imagePNG), ),
              fit:  BoxFit.contain
          ),

        ),
    ));
  }
}

