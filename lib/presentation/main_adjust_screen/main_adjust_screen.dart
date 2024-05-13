import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_navigation_top.dart';
import '../../widgets/custom_placeholder_image_upload.dart';
import '../../widgets/custom_slider.dart';

Primitives primitives = Get.put(Primitives());

class adjustmentButton {
  late IconData iconAdjust;
  Function function;
  adjustmentButton({required this.iconAdjust, required this.function});
}
List<IconData> listIcon = [Icons.sunny,
  Icons.thermostat_outlined,
  Icons.contrast_outlined,
  Icons.ac_unit,
  Icons.change_history_rounded
];
double paddingIcon = 15;
double sizeIcon = 25;
List<adjustmentButton> listAdjustButton = [
  adjustmentButton(iconAdjust: listIcon[0], function: (){}),
  adjustmentButton(iconAdjust: listIcon[1], function: (){}),
  adjustmentButton(iconAdjust: listIcon[2], function: (){}),
  adjustmentButton(iconAdjust: listIcon[3], function: (){}),
  adjustmentButton(iconAdjust: listIcon[4], function: (){}),
];
class main_adjust extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildMainAdjustBody(),
    );
  }
}
class buildMainAdjustBody extends StatelessWidget {

  custom_slider controller_slider = Get.put(custom_slider());
  var selectedItem = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: primitives.surface_secondary.value),
      child: Column(
        children: [
          navigationTop(),
          place_holder(),
          visualAdjustment(),
          controller_slider.slider_primary(),
        ],
      ),
    );
  }
  Expanded visualAdjustment() {
    return Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                elementAdjust(0),
                elementAdjust(1),
                elementAdjust(2),
                elementAdjust(3),
                elementAdjust(4),
              ],
            )
          ),
        );
  }
  Widget elementAdjust (index){
    return Material(
      type: MaterialType.transparency,
      //Makes it usable on any background color, thanks @IanSmith
      child: Obx(() => Ink(
        decoration: BoxDecoration(
          border: Border.all(color: selectedItem.value == index ?  primitives.yellow1.value : primitives.border_secondary.value,),
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(1000.0),
          splashColor: Colors.transparent,
          onTap: () {
            selectedItem.value = index;
          },
          child: Padding(
              padding: EdgeInsets.all(paddingIcon),
              child: Icon(
                listAdjustButton.elementAt(index).iconAdjust,
                size: sizeIcon,
                color: selectedItem.value == index ?  primitives.yellow1.value : primitives.border_secondary.value,
              )),
        ),
      ),
      ),);
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