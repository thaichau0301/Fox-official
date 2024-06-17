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
TextController controller = Get.find();

class TextEditScreen {
  Widget BuildBottomText() {
    List<Map<String, IconData>> iconButton = [
      {'Font': Icons.font_download_outlined},
      {'Format': Icons.format_bold_outlined},
      {'Colors': Icons.format_color_text_outlined},
      {'Font size': Icons.format_size_outlined}
    ];
    int _index = controller.indexChildWidget.value;
    Color active = primitives.activeIconBottomBar;
    Color inactive = primitives.inactiveIconBottomBar;
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
                        controller.currentIndexText.value = -1;
                        Get.find<MainScreenController>().resetBottomBar();
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
                                controller.changeTabIndex(index);
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        iconButton[index].values.first,
                                        color: _index == index ? active : inactive,
                                        size: 25,
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        iconButton[index].keys.first,
                                        style: TextStyle(color: _index == index ? active : inactive,),
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
    return switch (controller.indexChildWidget.value) {
              0 => FontText(),
              1 => FormatText(),
              2 => ColorsPicker(
                  passedFunc: Get.find<TextController>().changeTextColor),
              3 => SizeText(),
              // TODO: Handle this case.
              int() => throw UnimplementedError(),
            };
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
                    mainController.hideAllChooseMarkup();
                    controller.setCurrentIndex(i);
                    mainController.navigateToUpdateText();
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
                                visible: controller.currentIndexText.value == i,
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
                                visible: controller.currentIndexText.value  == i,
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
                                visible: controller.currentIndexText.value  == i,
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
                                  color: controller.currentIndexText.value == i
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
    Color active = primitives.activeIconButton2;
    Color inactive = primitives.inactiveIconButton2;
    return Container(
        height: 50,
        child: Center(
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: listIconFormatText.length,
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
            ],
          ),
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
