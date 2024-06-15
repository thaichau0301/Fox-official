import 'package:flutter/material.dart';
import 'package:fox/presentation/main_screen/controller/main_screen_controller.dart';
import 'package:fox/widgets/colors_picker.dart';
import 'package:fox/widgets/custom_slider_positive.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'controller/paint_screen_controller.dart';

Primitives primitives = new Primitives();

class PaintScreen {
  Widget buildPaint() {
    return GetBuilder<PaintController>(
      init: PaintController(),
      builder: (controller) => ClipRect(
        child: GestureDetector(
            onPanStart: (details) {
              Get.find<PaintController>().startLine(details.localPosition);
            },
            onPanUpdate: (details) {
              Get.find<PaintController>().updateLine(details.localPosition);
            },
            onPanEnd: (details) {
              Get.find<PaintController>().endLine();
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: DrawingPainter(
                  lines: controller.lines, currentLine: controller.line),
            )),
      ),
    );
  }

  Widget SliderStrokeWidth(PaintController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: CustomSliderPositive(
        slider: Slider(
          activeColor: primitives.active,
          inactiveColor: primitives.inactive,
          value: controller.sliderValue.value,
          min: 1,
          max: 30,
          divisions: 100,
          onChanged: (value) {
            controller.updateValueSlider(value);
          },
          label: controller.sliderValue.value.toInt().toString(),
        ),
      ),
    );
  }

  Widget CustomTools(PaintController controller) {
    return Container(
      color: primitives.surface_secondary,
      child: ColorsPicker(passedFunc: controller.updateColorLine),
    );
  }

  Widget CustomBottomPaint() {
    double sizeIcon = 25;
    List<Map<String, dynamic>> iconButton = [
      {'Brush': FontAwesomeIcons.paintbrush},
      {'Pencil': FontAwesomeIcons.pencil},
      {'Highlight': FontAwesomeIcons.highlighter},
      {'Clear': FontAwesomeIcons.eraser},
    ];
    return GetBuilder<PaintController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    Get.find<MainScreenController>().changeBottom(0);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 30,
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
                            controller.onTapChange(index);
                          },
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Icon(
                                    iconButton[index].values.first,
                                    color: controller.selectedIndex == index
                                        ? primitives.active
                                        : primitives.inactive,
                                    size: sizeIcon,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    iconButton[index].keys.first,
                                    style: TextStyle(
                                      color: controller.selectedIndex == index
                                          ? primitives.active
                                          : primitives.inactive,
                                    ),
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
}
