import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fox/widgets/custom_slider_positive.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main_adjust_screen/main_adjust_screen.dart';
import 'controller/draw_screen_controller.dart';

final Primitives primitives = Get.put(Primitives());

final controller = Get.put(PaintController());
class DrawTools extends StatelessWidget {
  const DrawTools({super.key});


  @override
  Widget build(BuildContext context) {
    Primitives primitives = Get.put (Primitives());
    final controller_slider = Get.put(sliderController());
    final controller = Get.put(PaintController());
    controller_slider.sliderValue.value = 30;
    return SafeArea(
      child: GetBuilder<PaintController>(

        builder: (context) => Scaffold(
          appBar: buildAppBar(),
          body: buildPaint(controller),
          bottomNavigationBar: customBottomBar(),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        title: Text('Paint', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.check_outlined),
            onPressed: () {},
          ),
        ],
      );
  }

  Column buildPaint(PaintController controller) {
    return Column(
        children: [
          Expanded(
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
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: DrawingPainter(lines: controller.lines, currentLine: controller.line),
                ),
              ),
            ),
          ),
        ],
      );
  }
  customBottomBar() {
    return GetBuilder<PaintController>(
      builder: (controller) => BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,

        unselectedItemColor: primitives.inactiveIconButton,
          selectedItemColor: primitives.activeIconButton,

          currentIndex: controller.selectedIndex.value,
          onTap: (index){controller.onTapChange(index);},
          items: [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.paintbrush,), label: ''
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.pencil,), label: ''
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.highlighter,), label: ''
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.eraser,), label: ''
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.palette,), label: ''
        ),
      ]
      ),
    );
  }

}
