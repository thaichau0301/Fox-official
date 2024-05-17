import 'package:flutter/material.dart';
import 'package:fox/presentation/main_adjust_screen/main_adjust_screen.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';
class sliderController extends GetxController {
  var sliderValue = 1.0.obs;

  void updateValueSlider(newValue) {
    if(sliderValue != newValue){
      sliderValue = newValue;
    }
    update();
  }

}
class CustomSliderPositive extends StatelessWidget {
   const CustomSliderPositive({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(sliderController());
    final primitives = Get.put(Primitives());
    return Obx(() => SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2,
        overlayShape: SliderComponentShape.noOverlay
      ),
      child: Slider(
        activeColor: primitives.active.value,
        inactiveColor: primitives.inactive.value,
        value: controller.sliderValue.value,
        onChanged: (newValue) {
          controller.sliderValue.value = newValue;
        },
        min: 1,
        max: 100,
        divisions: 150,
      ),
    ),);
  }
}