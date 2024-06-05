import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fox/presentation/user_screen/user_screen.dart';
import '../../theme/theme_helper.dart';
import '../home_screen/home_screen.dart';
import 'controller/home_bottom_navigation_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(HomeBottomBarController());

    return Obx(() => Scaffold(
          body: Center(
            child:
              IndexedStack(
                index: controller.tabIndex.value,
                children: [
                  HomeScreen(),
                  Container(),
                  UserScreen()
                ],
              )
          ),
          bottomNavigationBar: buildBottomNavigationBar(),
        ));
  }


  Widget buildBottomNavigationBar() {
    final controller = Get.find<HomeBottomBarController>();
    return Container(
      height: 80,
      child: Theme(
        data: theme.copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent.shade700,
          unselectedItemColor: Colors.black,
          currentIndex: controller.tabIndex.value,
          onTap: (int index) {
            controller.changeTab(index);
          },
          items: [
            const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house, size: 20,), label: 'Home'),
            const BottomNavigationBarItem(
                icon:  FaIcon(FontAwesomeIcons.circlePlus, size: 40, color: Colors.black26,) ,label: ''),
            const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.solidUser, size: 20,),  label: 'User'),
          ],
        ),
      ),
    );
  }

}
