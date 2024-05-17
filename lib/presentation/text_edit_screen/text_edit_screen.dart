import 'package:flutter/material.dart';
import 'package:fox/presentation/text_edit_screen/controller/text_edit_controller.dart';
import 'package:fox/widgets/custom_slider_positive.dart';
import 'package:fox/widgets/table_colors.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';

final mainTextController controller = Get.put(mainTextController());
Primitives primitives = Get.put(Primitives());
final table_colors = Get.put(tableColors());
final controller_slider = Get.put(sliderController());

class TextEditTools extends StatelessWidget {
  TextEditTools({super.key});

  @override
  Widget build(BuildContext context) {
    final mainTextController controller = Get.put(mainTextController());
    return Expanded(
      flex: 3,
      child: GetBuilder<mainTextController>(builder: (controller) {
        return Column(
          children: [
            Expanded(flex: 1, child: listOption()),
            Expanded(
              flex: 2,
                child: Obx(() {
                  switch(controller.indexChildWidget.value){
                    case 0: return visibilityText();
                    case 1: return visibilityFormat();
                    case 2: return visibilityColors();
                    case 3: return visibilityFontSize();
                    default: return  SizedBox(height: 5,);
                  }
                })
            ),
          ],
        );
      },
      ),
    );
  }

  Widget listOption  () {
    var listNameFunction = [
      'Text', 'Format', 'Colors', 'Font size',
    ];
    return GetBuilder<mainTextController>(
        builder: (controller) {
          return SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
                itemCount: listNameFunction.length,
                itemBuilder: (context, index) {
                  return TextButton(
                      onPressed: (){controller.changeTabIndex(index);},
                      child: Text(listNameFunction[index],
                          style: TextStyle(fontSize: primitives.font_lg,
                              color: controller.indexChildWidget.value == index ?
                                  primitives.activeIconButton.value : primitives.inactiveIconButton.value
                          )
                      )
                  );
                }
            ),
          );
        }
    );
  }
  Widget visibilityText () {
    var listFont = [ 'Helvetica', 'Arial', 'Calibre', 'Courier New', 'Roboto', 'Impact', 'Times New Roman', 'DM sans',  ];

    return GetBuilder<mainTextController>(
        builder: (controller) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listFont.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    SizedBox(width: primitives.spacing_sm,),
                    TextButton(
                        onPressed: (){ controller.changeFontIndex(index); },
                        style:  TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(primitives.radius2.value),),
                          padding: EdgeInsets.symmetric(vertical: primitives.spacing_sm, horizontal: primitives.spacing_sm),
                          side: BorderSide(
                              color: controller.selectedFont.value == index ?
                              primitives.activeIconButton2.value : primitives.inactiveIconButton2.value
                          ),
                        ),
                        child: Text(listFont[index], style: TextStyle(fontSize: primitives.font_md,
                            color: controller.selectedFont.value == index ?
                            primitives.activeIconButton2.value : primitives.inactiveIconButton2.value
                        ),
                        )
                    ),
                    SizedBox(width: primitives.spacing_sm,),
                  ],
                );
              }
          );
        }
    );
  }
  Widget visibilityFormat () {
    var listIconFormatText = [
      Icons.format_bold_outlined,
      Icons.format_italic_outlined,
      Icons.format_underline_outlined,
    ];
    var listIconAlignHorizontal = [
      Icons.align_horizontal_left_outlined,
      Icons.align_horizontal_center_outlined,
      Icons.align_horizontal_right_outlined
    ];
    var listIconAlignVertical = [
      Icons.align_vertical_top_outlined,
      Icons.align_vertical_center_outlined,
      Icons.align_vertical_bottom_outlined,
    ];
    var colorActiveIcon = primitives.activeIconButton2.value;
    var colorInactiveIcon = primitives.inactiveIconButton2.value;
    return GetBuilder<mainTextController>(
      builder: (controller) {
        return  Container(
            width: double.infinity,
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: listIconAlignVertical.length,
                    itemBuilder: (context, index){
                      return IconButton(onPressed: () { controller.changeFormatIndex(index); },
                          icon: Icon(listIconFormatText[index],
                            color: controller.selectedFormatText[index] ? colorActiveIcon : colorInactiveIcon,)
                      );
                    }
                ),
                const VerticalDivider(indent: 30, endIndent: 30, thickness: 1, color: Colors.white30,),
                ListView.builder(
                  // button for align vertical
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: listIconAlignVertical.length,
                    itemBuilder: (context, index){
                      return IconButton(onPressed: (){controller.changeAlignVerticalIndex(index);},
                          icon: Icon(listIconAlignVertical[index],
                            color: controller.selectedAlignVertical[index] == true ? colorActiveIcon : colorInactiveIcon,)
                          );
                    }
                ),
                const VerticalDivider(indent: 30, endIndent: 30, thickness: 1, color: Colors.white30,),
                ListView.builder(
                  // button for align horizontal
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: listIconAlignHorizontal.length,
                    itemBuilder: (context, index){
                      return IconButton(onPressed: (){controller.changeAlignHorizontalIndex(index); },
                          icon: Icon(listIconAlignHorizontal[index],
                            color: controller.selectedAlignHorizontal[index] == true ?  colorActiveIcon : colorInactiveIcon,)
                      );
                    }
                ),
              ],
            )
        );
      },
    );
  }
  Widget visibilityColors () {
    return GetBuilder<mainTextController>(
      builder: (controller) {
        return  Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
            child: table_colors
        );
      },
    );
  }
  Widget visibilityFontSize () {
    controller_slider.updateValueSlider(controller.minFontSize);
    return GetBuilder<mainTextController>(
      builder: (controller) {
        return  Container(
          padding: const EdgeInsets.fromLTRB(25,10,25,0),
            child: Row(
              children: [
                Text('Size', style: TextStyle(fontSize: 12, color: Colors.white),),
                SizedBox(width: 10,),
                Expanded(child: CustomSliderPositive()),
                SizedBox(width: 10,),
                Obx(() => Text('${controller_slider.sliderValue.value.toInt()}', style: TextStyle(fontSize: 12, color: Colors.white),)),
              ],
            ),
        );
      },
    );
  }
}