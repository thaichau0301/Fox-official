import 'package:flutter/material.dart';
import 'package:fox/presentation/main_adjust_screen/controller/main_adjust_controller.dart';
import 'package:fox/presentation/main_screen/controller/main_screen_controller.dart';
import 'package:fox/widgets/custom_slider.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';

Primitives primitives = new Primitives();
final controller = Get.put(MainAdjustController());

class AdjustTools {
  static const Map<String, IconData> listCustomButton = {
    'Brightness' : Icons.sunny,
    'Saturation' : Icons.contrast_outlined};

  Widget visualAdjustment(MainScreenController mainController ) {
    return GetBuilder<MainAdjustController>(
      builder: (controller) => Column(
        children: [
          Expanded(flex: 1, child: CustomSlider()),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  8.0),
                  child: IconButton(
                      onPressed: () {
                        // reset all of value adjust
                        for (int i = 0; i < listCustomButton.length; i++)
                          controller.resetValueAdjust(i);
                        mainController.resetBottomBar();
                      },
                      icon: Icon(Icons.close_outlined, color: Colors.white, size: 20,)),
                ),
                ...List.generate( listCustomButton.length , (index) => customTextButton(index)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  8.0),
                  child: IconButton(onPressed: (){
                    // change bottom
                    mainController.resetBottomBar();
                  }, icon: Icon(Icons.check_outlined, color: Colors.white, size: 20,)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // controller.changeItemIndex(index);
  Widget customTextButton (index) {
    dotMark (double valueAdjust) {
      return Container(
        height: 3,
        width: 3,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(color: Colors.yellow.withOpacity(valueAdjust != 0 ? 1 : 0), shape: BoxShape.circle),
      );
    }
    return GestureDetector(
      onTap: (){
        controller.changeItemIndex(index);
      },
      onDoubleTap: (){
        controller.resetValueAdjust(index);
      },
      child: Column(
        children: [
          Icon(listCustomButton.values.elementAt(index),
            size: 30,
            color:  controller.selectedItem == index ?  primitives.activeIconButton : primitives.inactiveIconButton,
          ),
          SizedBox(height: 5,),
          Text(listCustomButton.keys.elementAt(index), style: TextStyle(fontSize: 10,
             color:  controller.selectedItem == index ?  primitives.activeIconButton : primitives.inactiveIconButton) ,
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
    );

  }
}