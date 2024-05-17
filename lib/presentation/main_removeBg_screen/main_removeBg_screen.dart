import 'package:fox/presentation/main_removeBg_screen/controller/main_removeBg_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fox/theme/primitives.dart';
import '../text_edit_screen/text_edit_screen.dart';

final controller = Get.put(mainRemoveBgController());
final primitives = Get.put(Primitives());

class RemoveBgTools extends StatelessWidget {
  const RemoveBgTools({super.key});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.white54,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (()  {
              switch (controller.selectedIndex.value) {
                case 0 : return customTableColors();
                case 1 : return customTableColors();
                default: return Text('Nothing'); }
            })(),
            SizedBox(height: 10,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextButton(Icons.color_lens, 'Colors', 0),
                  customTextButton(Icons.image_outlined, 'Colors', 1),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget customTextButton(IconData icon, String label, int index) {
    return GetBuilder<mainRemoveBgController>(
        builder: (controller)
        => TextButton(
            onPressed: () { controller.onTapChangeTab(0);},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(icon,
                    size: 30,
                    color: controller.selectedIndex.value == index ? primitives.activeIconBottomBar.value : primitives.inactiveIconBottomBar.value,
                  ),
                ),
                SizedBox(height: 15,),
                Expanded(
                  child: Text(label, style: TextStyle(
                      color: controller.selectedIndex.value == index ?
                      primitives.activeIconBottomBar.value : primitives.inactiveIconBottomBar.value,
                      fontSize: primitives.font_sm
                  ),),
                )
              ],
            )
        ),
    );
  }

  Widget customTableColors() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: table_colors
    );
  }
}
