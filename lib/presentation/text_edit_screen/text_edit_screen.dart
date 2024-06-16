import 'package:flutter/material.dart';
import 'package:fox/presentation/main_screen/controller/main_screen_controller.dart';
import 'package:fox/presentation/text_edit_screen/controller/text_edit_controller.dart';
import 'package:fox/widgets/colors_picker.dart';
import 'package:fox/widgets/custom_slider_positive.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';
import 'text_edit_model.dart';

final TextEditingController textEditingController = TextEditingController();
Primitives primitives = new Primitives();
MainScreenController mainController = Get.find();
TextController controller = Get.find();

class TextEditScreen {
  int keyIndex;
  TextEditScreen({required this.keyIndex});
  Widget BuildBottomText(MainScreenController controller) {
    List<Map<String, IconData>> iconButton = [
      {'Font': Icons.font_download_outlined},
      {'Format': Icons.format_bold_outlined},
      {'Colors': Icons.format_color_text_outlined},
      {'Font size': Icons.format_size_outlined}
    ];
    return Container(
      height: 100,
      color: primitives.surface_secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    controller.changeBottom(0);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ))),
          Expanded(
              flex: 6,
              child: ListView.builder(
                  itemCount: iconButton.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: ElevatedButton(
                          onPressed: () {
                            controller.changeTabText(index);
                          },
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Icon(
                                    iconButton[index].values.first,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    iconButton[index].keys.first,
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primitives.surface_secondary,
                            overlayColor: Colors.transparent,
                          )),
                    );
                  }))
        ],
      ),
    );
  }

  Widget BuildMenuTools() {
    return GetBuilder<MainScreenController>(
        builder: (mainController) => switch (mainController.tabText.value) {
              0 => FontText(),
              1 => FormatText(),
              2 => ColorsPicker(
                  passedFunc: Get.find<TextController>().changeTextColor),
              3 => SizeText(),
              // TODO: Handle this case.
              int() => throw UnimplementedError(),
            });
  }

  Widget BuildDisplayImage(MainScreenController mainController) {
    return GetBuilder<TextController>(
      builder: (controller) => IntrinsicWidth(
        child:
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
          for (int i = 0; i < controller.texts.length; i++)
            Positioned(
              left: controller.texts[i].left,
              top: controller.texts[i].top,
              child: GestureDetector(
                  onTap: () {
                    controller.setCurrentIndex(i);
                    mainController.changeBottom(keyIndex);
                  },
                  onPanUpdate: (details) {
                    controller.texts[i].left += details.delta.dx;
                    controller.texts[i].top += details.delta.dy;
                    controller.update();
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.loose,
                        children: [
                          Positioned(
                              top: 0,
                              left: -10,
                              child: Visibility(
                                visible: controller.texts[i].isChoose,
                                child: ElevatedButton(
                                    onPressed: () {
                                      controller.deleteText();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.black,
                                      size: 15,
                                    )),
                              )),
                          Positioned(
                              top: 0,
                              right: -10,
                              child: Visibility(
                                visible: controller.texts[i].isChoose,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (controller
                                              .texts[controller
                                                  .currentIndexText.value]
                                              .text !=
                                          '') {
                                        // to text field input text not empty
                                        textEditingController.text = controller
                                            .texts[controller
                                                .currentIndexText.value]
                                            .text;
                                        Get.toNamed('enter_text_screen',
                                            arguments: {
                                              'image': mainController
                                                  .editedImage.value!
                                            });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.edit_outlined,
                                      color: Colors.black,
                                      size: 15,
                                    )),
                              )),
                          Positioned(
                              bottom: 0,
                              left: -10,
                              child: Visibility(
                                visible: controller.texts[i].isChoose,
                                child: ElevatedButton(
                                    onPressed: () {
                                      controller.duplicateText();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.copy_rounded,
                                      color: Colors.black,
                                      size: 15,
                                    )),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.texts[i].isChoose == true
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: DisplayText(
                                textInfo: controller.texts[i],
                              ),
                            ),
                          ),
                        ]),
                  )),
            ),
        ]),
      ),
    );
  }

  Widget FontText() {
    int selected = controller.selectedFont.value;
    Color active = primitives.activeIconButton2;
    Color inactive = primitives.inactiveIconButton2;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.listFont.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(primitives.spacing_sm),
            child: TextButton(
                onPressed: () {
                  controller.changeFontIndex(index);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: primitives.spacing_sm),
                  side:
                      BorderSide(color: selected == index ? active : inactive),
                ),
                child: Text(
                  controller.listFont[index],
                  style: TextStyle(
                      fontSize: primitives.font_md,
                      color: selected == index ? active : inactive),
                )),
          );
        });
  }

  Widget FormatText() {
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
    Color active = primitives.activeIconButton2;
    Color inactive = primitives.inactiveIconButton2;
    return Container(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listIconAlignVertical.length,
                itemBuilder: (context, index) {
                  return IconButton(
                      onPressed: () {
                        controller.changeFormatIndex(index);
                      },
                      icon: Icon(
                        listIconFormatText[index],
                        color: controller.selectedFormatText[index]
                            ? active
                            : inactive,
                      ));
                }),
            const VerticalDivider(
              indent: 30,
              endIndent: 30,
              thickness: 1,
              color: Colors.white,
            ),
            ListView.builder(
                // button for align vertical
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listIconAlignVertical.length,
                itemBuilder: (context, index) {
                  return IconButton(
                      onPressed: () {
                        controller.changeAlignVerticalIndex(index);
                      },
                      icon: Icon(
                        listIconAlignVertical[index],
                        color: controller.selectedAlignVertical[index] == true
                            ? active
                            : inactive,
                      ));
                }),
            const VerticalDivider(
              indent: 30,
              endIndent: 30,
              thickness: 1,
              color: Colors.white,
            ),
            ListView.builder(
                // button for align horizontal
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listIconAlignHorizontal.length,
                itemBuilder: (context, index) {
                  return IconButton(
                      onPressed: () {
                        controller.changeAlignHorizontalIndex(index);
                      },
                      icon: Icon(
                        listIconAlignHorizontal[index],
                        color: controller.selectedAlignHorizontal[index] == true
                            ? active
                            : inactive,
                      ));
                }),
          ],
        ));
  }

  Widget SizeText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          const Text(
            'Size',
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomSliderPositive(
              slider: Slider(
                activeColor: primitives.active,
                inactiveColor: primitives.inactive,
                value: controller.sliderValue.value,
                min: 20,
                max: 100,
                divisions: 100,
                onChanged: (value) {
                  controller.updateValueSlider(value);
                  controller.texts[controller.currentIndexText.value].fontSize =
                      value;
                },
              ),
            ),
          )),
          Text(
            '${controller.sliderValue.value.toInt()}',
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
