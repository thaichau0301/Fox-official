
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../main_adjust_screen/main_adjust_screen.dart';
import '../main_crop_screen/main_crop_screen.dart';
import '../main_filter_screen/main_filter_screen.dart';
import '../main_insert_screen/main_insert_screen.dart';
import '../main_remove_screen/main_remove_screen.dart';
import 'controller/bottom_nav_controller.dart';

class mainBottomBar extends StatefulWidget {
  const mainBottomBar({super.key});

  @override
  State<mainBottomBar> createState() => _mainBottomBarState();
}
Primitives primitives = Get.put(Primitives());
class _mainBottomBarState extends State<mainBottomBar> {
  final controller = Get.put(mainBarController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<mainBarController>(builder: (context){
      return Scaffold(
        backgroundColor: primitives.surface_secondary.value,
        appBar: CustomAppBar(),
        body: IndexedStack(
          index: controller.tabIndex,
          children: [
            main_adjust(),
            main_filter(),
            main_crop(),
            main_remove(),
            main_insert(),
          ],
        ),
        bottomNavigationBar: _bottomNavigation(),
      );
    });
  }
  Widget _bottomNavigation() {
    return Theme(
            data: theme.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: primitives.surface_secondary(),
              iconSize: 30,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: primitives.surface_icon1(),
              selectedItemColor: primitives.surface_primary(),
              currentIndex: controller.tabIndex,
              onTap: (index) {
                controller.changeTabIndex(index);
              },
              items: [
                bottomBarItem(Icon(Icons.tune_outlined), 'Adjust'),
                bottomBarItem(Icon(Icons.filter_tilt_shift_outlined), 'Filters'),
                bottomBarItem(Icon(Icons.crop), 'Crop'),
                bottomBarItem(Icon(Icons.texture_outlined), 'Remove'),
                bottomBarItem(Icon(Icons.layers_outlined), 'Insert'),
                // bottomBarItem(Icon(Icons.draw_outlined), 'Draw'),
                // bottomBarItem(Icon(Icons.tag_faces_outlined), 'Stickers'),
              ],
            ),
    );
  }
  bottomBarItem(Icon icon, String label){
    return BottomNavigationBarItem(icon: icon, label: label);
  }
}
