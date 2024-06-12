import 'package:flutter/material.dart';
import 'package:fox/presentation/text_edit_screen/text_edit_screen.dart';
import 'package:fox/widgets/colors_picker.dart';
import 'package:fox/widgets/custom_slider_positive.dart';
import 'package:fox/widgets/main_frame.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'controller/draw_screen_controller.dart';

Primitives primitives = new Primitives();

class DrawTools extends StatelessWidget {
  const DrawTools({super.key});

  @override
  Widget build(BuildContext context) {
    final controller_slider = Get.put(sliderController());
    // final controller = Get.put(PaintController());
    controller_slider.sliderValue.value = 30;

    return GetBuilder<PaintController>(
      init: PaintController(),
      builder: (controller) => MainFrame(
          customAppBar: buildAppBar(),
          customFrameImage: buildPaint(controller),
          customMenuTools: customMenuTools(controller),
          customBottomNavigationBar: customBottomBar()).FrameForAll(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: primitives.activeIconBottomBar),
      centerTitle: true,
      title: Text('Paint', style: TextStyle(color : primitives.activeIconBottomBar ),),
      backgroundColor: primitives.surface_secondary,
      leading: IconButton(
        onPressed: () {
          Get.find<PaintController>().lines.clear();
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios_outlined),),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.check_outlined),
          onPressed: (){
            Get.back();
          },
        )
      ],
    );
  }

  buildPaint(PaintController controller) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: Image.file(Get.arguments['image'], fit: BoxFit.fitWidth,)),
          Positioned.fill(
            child: ClipRect(
              child:
              GestureDetector(
                onPanStart: (details) {
                  Get.find<PaintController>().startLine(details.localPosition);
                },
                onPanUpdate: (details) {
                  Get.find<PaintController>().updateLine(details.localPosition);
                },
                onPanEnd: (details) {
                  Get.find<PaintController>().endLine();
                },
                child:CustomPaint(
                  size: Size.infinite,
                  painter: DrawingPainter(lines: controller.lines, currentLine: controller.line),
                  // child: Image.file(mainController.editedImage.value!),
                )
                                  ),
            ),
          ),
        ],
      ),
    );
  }
  Widget SliderStrokeWidth (PaintController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: CustomSliderPositive(slider: Slider(
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
      ),),
    );
  }
  customMenuTools(PaintController controller) {
    return Column(
      children: [
        Expanded(flex: 1, child : SliderStrokeWidth(controller)),
        Expanded(flex: 1, child: ColorsPicker(passedFunc: controller.updateColorLine)),

    ]);
  }
  customBottomBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GetBuilder<PaintController>(
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
        ]

        ),
      ),
    );
  }

}
