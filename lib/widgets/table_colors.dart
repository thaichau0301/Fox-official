import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableColorsController extends GetxController {
  var selectedColor = 0.obs;
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
  void updateSelected(index) {
    selectedColor.value = index;
    update();
  }
  Color chooseColor(Function passColor){
    passColor(listColors[selectedColor.value]);
    return listColors[selectedColor.value];
  }

  @override
  void onClose() {
    print('onClose table colors');
    super.onClose();
  }
}
class tableColors extends StatelessWidget {
  tableColors({super.key});

  @override
  Widget build(BuildContext context) {

    double sizeIcon = 35;
    return Center(
      child: Container(
        height: sizeIcon,
        child: GetX<TableColorsController>(
        init: TableColorsController(),
        builder: (controller) => ListView.builder(
          padding: EdgeInsets.all(0.0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.listColors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: (){controller.updateSelected(index); controller.chooseColor;},
                child: Container(
                  width: sizeIcon,
                  decoration: BoxDecoration(
                    color: controller.listColors[index],
                    border: Border.all(
                      color: controller.selectedColor == index ?  Colors.white : Colors.transparent,
                      width: 2,
                    ),
                  ),

                ),
              );
          }
        ),
      ),
    ));
  }
}
