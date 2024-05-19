import 'package:flutter/material.dart';
import 'package:fox/presentation/main_adjust_screen/controller/main_adjust_controller.dart';
import 'package:fox/widgets/custom_placeholder_image_upload.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/custom_slider.dart';
import '../home_bottom_navigation/controller/home_bottom_navigation_controller.dart';

Primitives primitives = Get.put(Primitives());

class adjustmentButton {
  late IconData iconAdjust;
  late String labelIcon;
  Function function;
  adjustmentButton({required this.iconAdjust, required this.labelIcon, required this.function});
}
var listIcon = [
  Icons.sunny, // brightness
  Icons.thermostat_outlined, // temperature
  Icons.contrast_outlined, // contrast
  Icons.ac_unit, // saturation
  Icons.details_outlined // sharpen
];
var listLabelIcon = [
  'Brightness', 'Warmth', 'Contrast', 'Saturation', 'Sharpen'
];
List<adjustmentButton> listAdjustButton = List.generate(
  listIcon.length,
      (index) => adjustmentButton(
    iconAdjust: listIcon[index],
    labelIcon: listLabelIcon[index],
    function: () {},
  ),
);
class AdjustTools extends StatelessWidget {

  final controller_slider = Get.put(CustomSlider());


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainAdjustController());
    return GetBuilder<MainAdjustController>(
      builder : (controller) =>  Expanded(
        flex: 4,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              visualAdjustment(),
              CustomSlider(),
            ],
          ),
        ),
      ),
    );
  }
  Expanded visualAdjustment() {
    return Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Row(
              // mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children:  List.generate( listAdjustButton.length , (index) => customTextButton(index)),
            )
          ),
        );
  }
  Widget customTextButton (index) {
    return Expanded(
      child: GetX<MainAdjustController>(
        builder: (controller) {
          return ElevatedButton(onPressed: () { controller.changeItemIndex(index); },
            style: ElevatedButton.styleFrom(
              backgroundColor: primitives.surface_secondary.value,
              foregroundColor: primitives.surface_secondary.value,
              surfaceTintColor: primitives.surface_secondary.value,
              padding: EdgeInsets.zero,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(listAdjustButton.elementAt(index).iconAdjust,
                  size: 30,
                  color:  controller.selectedItem.value == index ?  primitives.activeIconButton.value : primitives.inactiveIconButton.value,
                ),
                SizedBox(height: 10,),
                Text(listAdjustButton.elementAt(index).labelIcon, style: TextStyle(fontSize: 10,
                   color:  controller.selectedItem.value == index ?  primitives.activeIconButton.value : primitives.inactiveIconButton.value) ,
                ),
                SizedBox(height: 15,),
              ],
            ),

          );
        }
      ),
    );
  }
  Column dotMarkChoose(_val) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Container(
          height: 3,
          width: 3,
          decoration: BoxDecoration(color: Colors.yellow.withOpacity(_val != 0 ? 1 : 0), shape: BoxShape.circle),
        ),
      ],
    );
  }
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}