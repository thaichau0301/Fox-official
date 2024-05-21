import 'package:flutter/material.dart';
import 'package:fox/core/app_export.dart';
import 'package:fox/presentation/user_screen/user_screen.dart';
import 'package:fox/theme/primitives.dart';
import '../../theme/theme_helper.dart';
import '../home_screen/home_screen.dart';
import 'controller/home_bottom_navigation_controller.dart';

class HomeBottomBar extends GetView<HomeBottomBarController> {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>HomeBottomBarController());
    // controller.resetTabIndex();
    return GetBuilder<HomeBottomBarController>(
      init: HomeBottomBarController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              (() {
                switch (controller.tabIndex.value) {
                  case 0 :
                    return HomeScreen();
                  case 1 :
                    return Container();
                  case 2 :
                    return Expanded(child: UserScreen());
                  default:
                    return Text('');
                }
              })(),
            ],
          ),
          bottomNavigationBar: buildBottomNavigationBar(controller),
        );
      },
    );

  }

  Widget buildBottomNavigationBar(HomeBottomBarController controller) {
    double iconSize = 30;
    Primitives primitives = Get.put(Primitives());
    return Container(
      height: 70,
      child: Theme(
        data: theme.copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          selectedItemColor: primitives.blue1.value,
          unselectedItemColor: Colors.black,
          currentIndex: controller.tabIndex.value,
          onTap: (index) {
            controller.changeTab(index);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled, size: iconSize), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline, size: iconSize),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: iconSize),
                label: ''
            ),
          ],
        ),
      ),
    );
  }

}
