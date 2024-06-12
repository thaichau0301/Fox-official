import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorsPickerController extends GetxController {
  var _index = 0.obs;
  var listColors = [
    Colors.white,
    Colors.grey,
    Colors.black,
    Colors.blueAccent.shade700,
    Colors.blueAccent.shade400,
    Colors.blueAccent.shade200,
    Colors.blueAccent.shade100,
    Colors.redAccent.shade700,
    Colors.redAccent.shade400,
    Colors.redAccent.shade200,
    Colors.redAccent.shade100,
    Colors.brown,
    Colors.greenAccent.shade700,
    Colors.greenAccent.shade400,
    Colors.greenAccent.shade200,
    Colors.greenAccent.shade100,
    Colors.yellowAccent.shade700,
    Colors.yellowAccent.shade400,
    Colors.yellowAccent.shade200,
    Colors.yellowAccent.shade100,
  ];

  void onTapChangeColor(int index) {
    _index.value = index;
    update();
  }
  Color Picker() {
    return listColors[_index.value];
  }
}

class ColorsPicker extends StatelessWidget {
  final VoidCallback passedFunc;
  ColorsPicker({required this.passedFunc});

  @override
  Widget build(BuildContext context) {
    double sizeIcon = 35;

    return GetBuilder<ColorsPickerController>(
      init: ColorsPickerController(),
      builder: (controller) => Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Container(
              height: sizeIcon,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.listColors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        controller.onTapChangeColor(index);
                        passedFunc();
                      },
                      child: Container(
                        width: sizeIcon,
                        decoration: BoxDecoration(
                          color: controller.listColors[index],
                          border: Border.all(
                            color: controller._index.value == index ? Colors.white : Colors.transparent,
                            width: 2,
                          ),
                        ),

                      ),
                    );
                  }
              ),
            ),
          )
      ),
    );
  }
}
