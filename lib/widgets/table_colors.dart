import 'package:flutter/material.dart';
import 'package:get/get.dart';

class tableColorsController extends GetxController {
  var selectedColor = 0.obs;
  void updateSelected(index) {
    selectedColor.value = index;
    update();
  }
  @override
  void onClose() {
    print('onClose table colors');
    super.onClose();
  }
}
class tableColors extends StatelessWidget {
  const tableColors({super.key});

  @override
  Widget build(BuildContext context) {
    var listColors = [
      Colors.white,
      Colors.white70,
      Colors.white38,
      Colors.white24,
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
    double sizeIcon = 35;
    return Center(
      child: Container(
        height: sizeIcon,
        child: ListView.builder(
          padding: EdgeInsets.all(0.0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listColors.length,
          itemBuilder: (context, index) {
            return GetX<tableColorsController>(
              init: tableColorsController(),
              builder: (controller) => GestureDetector(
                onTap: (){controller.updateSelected(index);},
                child: Container(
                  width: sizeIcon,
                  decoration: BoxDecoration(
                    color: listColors[index],
                    border: Border.all(
                      color: controller.selectedColor == index ?  Colors.white : Colors.transparent,
                      width: 2,
                    ),
                  ),

                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
