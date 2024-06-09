import 'package:flutter/material.dart';
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
   const CustomSliderPositive({super.key, required this.slider});
   final Widget slider;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(sliderController());
    final primitives = Get.put(Primitives());
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2,
        overlayShape: SliderComponentShape.noOverlay
      ),
      child: slider,
      // child: Slider(
      //   activeColor: primitives.active,
      //   inactiveColor: primitives.inactive,
      //   value: controller.sliderValue.value,
      //   onChanged: (newValue) {
      //     controller.sliderValue.value = newValue;
      //   },
      //   min: 1,
      //   max: 100,
      //   divisions: 150,
      // ),
    );
  }
}