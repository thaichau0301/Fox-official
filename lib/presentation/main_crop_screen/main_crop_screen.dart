import 'package:flutter/material.dart';
import 'package:fox/presentation/main_crop_screen/controller/main_crop_controller.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/custom_slider.dart';

class LabelAndFunction {
  String label;
  Function function;
  LabelAndFunction({required this.label ,required this.function});
}
List<LabelAndFunction> buttonRatio = [
  LabelAndFunction(label: 'Original', function: (){}),
  LabelAndFunction(label: 'Freeform', function: (){}),
  LabelAndFunction(label: 'Square', function: (){}),
  LabelAndFunction(label: '3:2', function: (){}),
  LabelAndFunction(label: '4:3', function: (){}),
  LabelAndFunction(label: '5:4', function: (){}),
  LabelAndFunction(label: '19:6', function: (){}),
  LabelAndFunction(label: '2:3', function: (){}),
  LabelAndFunction(label: '3:4', function: (){}),
  LabelAndFunction(label: '6:19', function: (){}),
  LabelAndFunction(label: '4:5', function: (){}),
];

Primitives primitives = Get.put(Primitives());

class CropTools extends StatefulWidget {
  const CropTools({super.key});

  @override
  State<CropTools> createState() => _CropToolsState();
}
class _CropToolsState extends State<CropTools> {
  custom_slider controller_slider = Get.put(custom_slider());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(mainCropController());
    Color iconColor =  primitives.inactiveIconButton.value;

    return GetBuilder<mainCropController>(
      builder: (controller) => Expanded(
        flex: 3,
        child: Column(
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.rotate_90_degrees_ccw_outlined ,color: iconColor,)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.rotate_90_degrees_cw_outlined ,color: iconColor,)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.flip_outlined, color: iconColor,)
              ),
            ],
          ),
          list_aspect_ratio(),
          ],
        ),
      ),
    );
  }
  Widget list_aspect_ratio (){
    final double textSize = 15;
    return Expanded(
      child: GetBuilder<mainCropController>(
        builder: (controller) => ListView.builder(
          // shrinkWrap: true,
          itemCount: buttonRatio.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, int index) {
            return TextButton(onPressed: (){
              controller.updateOnTap(index);
              },
              child: Text(buttonRatio.elementAt(index).label,
                  style: TextStyle(
                    color: controller.activeBtnIndex == index ? primitives.activeIconButton.value : primitives.inactiveIconButton.value,
                    fontSize: textSize
                  ),
                  ),
              style: TextButton.styleFrom(
                foregroundColor: primitives.surface_secondary.value.withOpacity(0),
              ),
            );
          }
        ),
      ),
    );
  }
}
