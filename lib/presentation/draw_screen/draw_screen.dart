import 'package:flutter/material.dart';
import 'package:fox/presentation/main_adjust_screen/main_adjust_screen.dart';
import 'package:fox/widgets/custom_slider_positive.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Primitives primitives = new Primitives();
class DrawToolsController extends GetxController {
  var selectedIndex = 0.obs;
  void onTapChange(index) {
    selectedIndex.value = index;
    update();
  }
}
class DrawTools extends StatelessWidget {
  const DrawTools({super.key});

  @override
  Widget build(BuildContext context) {
    Primitives primitives = Get.put(Primitives());
    final controller_slider = Get.put(sliderController());
    controller_slider.sliderValue.value = 30;
    return Expanded(
      flex: 4,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: primitives.surface_secondary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(                        
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Expanded(child: CustomSliderPositive()),
                    SizedBox(width: 10,),
                    Obx(() => Text('${controller_slider.sliderValue.value.toInt()}', style: TextStyle(fontSize: primitives.font_md, color: Colors.white),)),
                  ],
                ),
              ),
            ),
            Expanded(flex: 4, child: customMenuTools()),
          ],
        ),
      ),
    );
  }
  BottomAppBar customBottomAppBar () {
    final controller = Get.put(DrawToolsController());
    return BottomAppBar(
      color: primitives.surface_secondary,
      child: Container(
        height: 30,
        child: GetBuilder<DrawToolsController>(
          builder: (controller) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {controller.onTapChange(0);}, icon: FaIcon(FontAwesomeIcons.paintbrush,
              color: controller.selectedIndex.value == 0 ? primitives.activeIconButton : primitives.inactiveIconButton,)
            ),
            IconButton(onPressed: () {controller.onTapChange(1);}, icon: FaIcon(FontAwesomeIcons.pencil,
              color: controller.selectedIndex.value == 1 ? primitives.activeIconButton : primitives.inactiveIconButton,)
            ),
            IconButton(onPressed: () {controller.onTapChange(0);}, icon: FaIcon(FontAwesomeIcons.highlighter,
              color: controller.selectedIndex.value == 0 ? primitives.activeIconButton : primitives.inactiveIconButton,)
            ),
            IconButton(onPressed: () {controller.onTapChange(0);}, icon: FaIcon(FontAwesomeIcons.eraser,
              color: controller.selectedIndex.value == 0 ? primitives.activeIconButton : primitives.inactiveIconButton,)
            ),
            IconButton(onPressed: () {controller.onTapChange(0);}, icon: FaIcon(FontAwesomeIcons.palette,
              color: controller.selectedIndex.value == 0 ? primitives.activeIconButton : primitives.inactiveIconButton,)
            ),
          ],
          ),
        ),
      ),
    );
  }

  Widget customMenuTools () {
    var listIcon = [
      FaIcon(FontAwesomeIcons.paintbrush),
      FaIcon(FontAwesomeIcons.pencil),
      FaIcon(FontAwesomeIcons.highlighter),
      FaIcon(FontAwesomeIcons.eraser),
      FaIcon(FontAwesomeIcons.palette),
    ];
    final controller = Get.put(DrawToolsController());
    return GetBuilder<DrawToolsController>(
      builder: (controller) => ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,

        itemCount: listIcon.length,
        itemBuilder: (context, index)  {
          return SizedBox(
            width: 60,
            child: IconButton(
                highlightColor: Colors.transparent,
                onPressed: () {controller.onTapChange(index);},
                icon: listIcon[index],
                  color: controller.selectedIndex.value == index ?
                    primitives.activeIconButton : primitives.inactiveIconButton,
            ),
          );
        },
      ),
    );
  }
}
