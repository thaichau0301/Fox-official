import 'package:flutter/material.dart';
import 'package:fox/presentation/main_adjust_screen/controller/main_adjust_controller.dart';
import 'package:get/get.dart';
import '../theme/primitives.dart';

class SliderController extends GetxController {
  var sliderValue = 0.0.obs;
  void updateSlider(currentSliderValue) {
    sliderValue.value = currentSliderValue;
    update();
  }
}
class CustomSlider extends StatelessWidget {
  final double minValueSlider = -100;
  final double maxValueSlider = 100;
  final primitives = Get.put(Primitives());
  final sliderController = Get.put(SliderController());
  final mainAdjustController = Get.put(MainAdjustController());

  @override
  Widget build(BuildContext context) {
    return  Obx(() => Center(
        child: Column(children: [
          Stack(alignment: AlignmentDirectional.center, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25,35,25,35),
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                        value: 1 - sliderController.sliderValue / minValueSlider,
                        color: primitives.inactive(),
                        backgroundColor: primitives.active()),
                    flex: minValueSlider.abs().round(),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                        value: sliderController.sliderValue / maxValueSlider,
                        color: primitives.active(),
                        backgroundColor: primitives.inactive()),
                    flex: maxValueSlider.abs().round(),
                  ),
                ],
              ),
            ),
            Slider(
              value: sliderController.sliderValue.value,
              activeColor: Colors.transparent,
              inactiveColor: Colors.transparent,
              // Tắt animation cho thumb
              thumbColor: sliderController.sliderValue == 0
                  ? primitives.surface_text()
                  : sliderController.sliderValue > 0
                  ? primitives.text_secondary()
                  : primitives.text_secondary(),
              min: minValueSlider,
              max: maxValueSlider,
              divisions: (minValueSlider.abs() + maxValueSlider.abs()).round(),
              label: sliderController.sliderValue.toInt().toString(),
              onChanged: (double newValue) {
                mainAdjustController.brightnessImg.value = newValue;
                sliderController.updateSlider(newValue);
              },
            ),
          ]),
        ])));
  }
}
