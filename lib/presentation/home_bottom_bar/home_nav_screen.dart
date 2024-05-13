import 'package:flutter/material.dart';
import 'package:fox/core/app_export.dart';
import 'package:fox/presentation/home_bottom_bar/controller/controller.dart';
import 'package:fox/presentation/user_screen/user_screen.dart';
import 'package:fox/theme/primitives.dart';

import '../../theme/theme_helper.dart';
import '../home_screen/home_screen.dart';
import '../mainBottomNav/bottom_nav_screen.dart';
class homeBottomBar extends StatefulWidget {
  const homeBottomBar({super.key});

  @override
  State<homeBottomBar> createState() => _homeBottomBarState();
}

class _homeBottomBarState extends State<homeBottomBar> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(homeBarController());
    return GetBuilder<homeBarController>(
      builder: (context) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
              children: [Home(),mainBottomBar(), UserScreen()]
          ),
          bottomNavigationBar:buildBottomNavigationBar(),
        );
      },
    );
  }
  Widget buildBottomNavigationBar() {
    double iconSize = 30;
    homeBarController controller = Get.put(homeBarController());
    Primitives primitives = Get.put(Primitives());
    return Theme(
      data: theme.copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        selectedItemColor: primitives.blue1.value,
        unselectedItemColor: Colors.black,
        currentIndex: controller.tabIndex,
        onTap: (index){
          controller.changeTabIndex(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: iconSize) ,label: ''),
          BottomNavigationBarItem(
              icon: IconButton(onPressed: () { Get.toNamed('/main_bottom_nav_bar'); }, icon: Icon(Icons.add,size: iconSize),),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: iconSize),
              label: ''
          ),
        ],

      ),
    );
  }
}
