import 'package:fox/widgets/custom_slider.dart';
import 'package:get/get.dart';

class MainAdjustController extends GetxController {
  var selectedItem;
  var brightnessImg= 0.0.obs;
  var saturationImg= 0.0.obs;
  final sliderController = Get.put(SliderController());

  void onInit(){
    super.onInit();
     selectedItem = 0.obs;
  }
  void changeItemIndex(int index) {
    selectedItem.value = index;
    switch(index) {
      case 0: updateValueSlider(brightnessImg); break;
      case 1: updateValueSlider(saturationImg); break;
    }
    update();
  }
  void resetValueAdjust(int index){
    switch(index) {
      case 0: brightnessImg.value = 0; break;
      case 1: saturationImg.value = 0;; break;
    }
    update();
  }
  void updateValueAdjust(RxDouble valueElement, double currentValueSlider){
    valueElement.value = currentValueSlider;
    update();
  }
  void updateValueSlider(RxDouble valueElement) {
    sliderController.sliderValue = valueElement;
    sliderController.func = (double currentValueSlider) => updateValueAdjust(valueElement, currentValueSlider);
  }
  List<double> brightnessAdjustMatrix({required double value})
  {
    if (value <= 0)
      value = value * 255;
    else
      value = value * 100;
    if (value == 0)
      return [
        1,0,0,0,0,
        0,1,0,0,0,
        0,0,1,0,0,
        0,0,0,1,0,
      ];
    return List<double>.from(<double>[
      1, 0, 0, 0, value, 0, 1, 0, 0, value, 0, 0, 1, 0, value, 0, 0, 0, 1, 0
    ]).map((i) => i.toDouble()).toList();
  }

  List<double> saturationAdjustMatrix({required double value})
  {
    value = value * 100;

    if (value == 0)
      return [
        1,0,0,0,0,
        0,1,0,0,0,
        0,0,1,0,0,
        0,0,0,1,0,
      ];
    double x = ((1 + ((value > 0) ? ((3 * value) / 100) : (value / 100)))).toDouble();
    double lumR = 0.3086;
    double lumG = 0.6094;
    double lumB = 0.082;

    return List<double>.from(<double>[
      (lumR * (1 - x)) + x, lumG * (1 - x), lumB * (1 - x),
      0, 0,
      lumR * (1 - x),
      (lumG * (1 - x)) + x,
      lumB * (1 - x),
      0, 0,
      lumR * (1 - x),
      lumG * (1 - x),
      (lumB * (1 - x)) + x,
      0, 0, 0, 0, 0, 1, 0,
    ]).map((i) => i.toDouble()).toList();
  }
}
