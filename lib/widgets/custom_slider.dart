import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/primitives.dart';

class SliderController extends GetxController {
  var sliderValue = 0.0.obs;
  Function func = (){};
  void updateSlider(double currentSliderValue) {
    sliderValue.value = currentSliderValue;
    func(currentSliderValue);
    update();
  }
}
class CustomSlider extends StatelessWidget {
  final double minValueSlider = -100;
  final double maxValueSlider = 100;
  final primitives = Get.put(Primitives());
  final sliderController = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    return  Obx(() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
          child: Column(children: [
            Stack(alignment: AlignmentDirectional.center, children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                  sliderController.updateSlider(newValue);
                },
              ),
            ]),
          ])),
    )
    );
  }
}
