import 'package:flutter/material.dart';
import 'package:fox/presentation/main_adjust_screen/controller/main_adjust_controller.dart';
import 'package:fox/presentation/main_navigation/controller/main_bottom_navigation_controller.dart';
import 'package:fox/presentation/main_navigation/main_bottom_navigation.dart';
import 'package:fox/widgets/custom_slider.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';

Primitives primitives = Get.find();
final controller = Get.put(MainAdjustController());


class AdjustTools extends StatelessWidget {
  static const Map<String, IconData> listCustomButton = {'Brightness' : Icons.sunny, 'Saturation' : Icons.contrast_outlined};

  @override
  Widget build(BuildContext context) {

    MainBottomNavController mainController = Get.find();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Adjust'),
          centerTitle: true,
          backgroundColor: Colors.grey,
          actions: <Widget>[
            IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.check_outlined))

          ],
        ),
        body: Container(
          color: primitives.surface_secondary.value,
          child: Obx(() => Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.matrix(
                          controller.brightnessAdjustMatrix(value: controller.brightnessImg.value/200),
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.matrix(
                            controller.saturationAdjustMatrix(value: controller.saturationImg.value/200),
                          ),
                          child: Image.file(mainController.editedImage.value!),
                        ),
                      ),
                  ),
                ),
                if(controller.selectedItem != -1) Expanded(flex: 2, child: CustomSlider()),
                Expanded(flex: 2, child: visualAdjustment())
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget visualAdjustment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  List.generate( listCustomButton.length , (index) => customTextButton(index)),
      ),
    );
  }

  Widget customTextButton (index) {
    dotMark (double valueAdjust) {
      return Container(
        height: 3,
        width: 3,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(color: Colors.yellow.withOpacity(valueAdjust != 0 ? 1 : 0), shape: BoxShape.circle),
      );
    }
    return Obx(() => ElevatedButton(onPressed: () { controller.changeItemIndex(index); },
            style: ElevatedButton.styleFrom(
              backgroundColor: primitives.surface_secondary.value,
              overlayColor: Colors.transparent,
              padding: EdgeInsets.zero,
            ),
            child: Column(
              children: [
                Icon(listCustomButton.values.elementAt(index),
                  size: 30,
                  color:  controller.selectedItem.value == index ?  primitives.activeIconButton.value : primitives.inactiveIconButton.value,
                ),
                SizedBox(height: 5,),
                Text(listCustomButton.keys.elementAt(index), style: TextStyle(fontSize: 10,
                   color:  controller.selectedItem.value == index ?  primitives.activeIconButton.value : primitives.inactiveIconButton.value) ,
                ),
                (() {
                  switch (index) {
                    case 0 :
                      return dotMark(controller.brightnessImg.value);
                    case 1 :
                      return dotMark(controller.saturationImg.value);
                    default:
                      return Text('Nothing');
                  }
                })(),
              ],
            ),
          ),
      );
  }
}