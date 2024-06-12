import 'package:flutter/material.dart';
import 'package:fox/presentation/main_navigation/controller/main_bottom_navigation_controller.dart';
import 'package:fox/presentation/main_navigation/main_bottom_navigation.dart';
import 'package:fox/presentation/text_edit_screen/controller/text_edit_controller.dart';
import 'package:fox/presentation/text_edit_screen/form_enter_text.dart';
import 'package:fox/widgets/custom_slider_positive.dart';
import 'package:fox/widgets/main_frame.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';
import 'package:screenshot/screenshot.dart';
import '../../theme/theme_helper.dart';
import 'text_edit_model.dart';

final TextEditingController textEditingController = TextEditingController();
Primitives primitives = new Primitives();
MainBottomNavController mainController = Get.find();

class TextEditTools extends StatelessWidget {
  TextEditTools({super.key});
  final ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainTextController>(
      init: MainTextController(),
      builder: (controller) => MainFrame(
          customAppBar:  buildAppBar(),
          customFrameImage: builderDisplayImage(),
          customMenuTools: buildMenuTools(),
          customBottomNavigationBar: buildBottomNavigationBar()).FrameForAll(),
    );
  }
  Widget buildBottomNavigationBar() {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: primitives.spacing_md),
      color: primitives.surface_secondary,
      child: Theme(
        data: theme.copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: primitives.surface_secondary,
            onTap: (int index){ controller.changeTabIndex(index);},
            currentIndex: controller.indexChildWidget.value,
            selectedItemColor:primitives.activeIconBottomBar,
            unselectedItemColor: primitives.inactiveIconBottomBar,
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.font_download_outlined), label: 'Font'),
            BottomNavigationBarItem(icon: Icon(Icons.format_bold_outlined), label: 'Format'),
            BottomNavigationBarItem(icon: Icon(Icons.format_color_text_outlined), label: 'Colors'),
            BottomNavigationBarItem(icon: Icon(Icons.format_size_outlined), label: 'Font size'),
          ]),
        ),
      );
}
  Widget buildMenuTools() {
    return Container(
      color: primitives.surface_secondary,
      child: Column(
        children: [
          Expanded(flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                      IconButton(
                          onPressed: () {
                            controller.duplicateText();
                          },
                          icon: Icon(
                            Icons.copy_outlined,
                            size: 25,
                            color: primitives.surface_icon1,
                          )),
                      IconButton(
                          onPressed: () {
                            controller.deleteText();
                          },
                          icon: Icon(
                            Icons.close_outlined,
                            size: 25,
                            color: primitives.surface_icon1,
                          )),
                      IconButton(
                          onPressed: () {
                            if (controller
                                    .texts[controller.currentIndexText.value]
                                    .text !=
                                '') {
                              // to text field input text not empty
                              textEditingController.text = controller
                                  .texts[controller.currentIndexText.value]
                                  .text;
                              Get.to(() => EnterText(),
                                  arguments: {'image': Get.arguments['image']});
                            }
                            // back to enter text
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 25,
                            color: primitives.surface_icon1,
                          )),
                    ],
                  ))),
          Expanded(
              flex: 1,
              child: Obx(() {
                switch (controller.indexChildWidget.value) {
                  case 0:
                    return visibilityText();
                  case 1:
                    return visibilityFormat();
                  case 2:
                    return visibilityColors();
                  case 3:
                    return visibilityFontSize();
                  default:
                    return SizedBox(
                      height: 5,
                    );
                }
              })),
        ],
      ),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: primitives.activeIconBottomBar),
      centerTitle: true,
      title: Text(
        'Text',
        style: TextStyle(color: primitives.activeIconBottomBar),
      ),
      backgroundColor: primitives.surface_secondary,
      leading: IconButton(
        onPressed: () {
          controller.texts.clear();
          Get.to(() => MainBottomBar());
        },
        icon: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.check_outlined),
          onPressed: () {
            Get.to(() => MainBottomBar());
          },
        )
      ],
    );
  }

  Widget builderDisplayImage() {
    return Screenshot(
      controller: screenshotController,
      child: Container(
        child:
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
          Image.file(
            Get.arguments['image'],
            fit: BoxFit.fitWidth,
          ),
          for (int i = 0; i < controller.texts.length; i++)
            Positioned(
              left: controller.texts[i].left,
              top: controller.texts[i].top,
              child: GestureDetector(
                  onTap: () {
                    controller.setCurrentIndex(i);
                  },
                  onPanUpdate: (details) {
                    controller.texts[i].left += details.delta.dx;
                    controller.texts[i].top += details.delta.dy;
                    controller.update();
                  },
                  child: ImageText(
                    textInfo: controller.texts[i],
                  )),
            ),
        ]),
      ),
    );
  }

  Widget visibilityText() {
    int selected = controller.selectedFont.value;
    Color active = primitives.activeIconButton2;
    Color inactive = primitives.inactiveIconButton2;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.listFont.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                width: primitives.spacing_sm,
              ),
              TextButton(
                  onPressed: () {
                    controller.changeFontIndex(index);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(primitives.radius2),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: primitives.spacing_sm,
                        horizontal: primitives.spacing_sm),
                    side: BorderSide(
                        color: selected == index ? active : inactive),
                  ),
                  child: Text(
                    controller.listFont[index],
                    style: TextStyle(
                        fontSize: primitives.font_md,
                        color: selected == index ? active : inactive),
                  )),
              SizedBox(
                width: primitives.spacing_sm,
              ),
            ],
          );
        });
  }

  Widget visibilityFormat() {
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
              color: Colors.white30,
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
              color: Colors.white30,
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

  Widget visibilityColors() {
    double sizeIcon = 35;
    return Container(
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
                    onTap: () {
                      controller.changeTextColor(index);
                    },
                    child: Container(
                      width: sizeIcon,
                      decoration: BoxDecoration(
                        color: controller.listColors[index],
                        border: Border.all(
                          color: controller.selectedColor == index
                              ? Colors.white
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ));
  }

  Widget visibilityFontSize() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
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