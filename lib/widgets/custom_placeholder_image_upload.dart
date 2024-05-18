import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fox/presentation/home_bottom_navigation/controller/home_bottom_navigation_controller.dart';
import 'package:fox/presentation/main_navigation/controller/main_bottom_navigation_controller.dart';
import 'package:get/get.dart';


class place_holder extends StatelessWidget {
  const place_holder({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Expanded(
      flex: 13,
      child: Container(// placeholder for image upload
        // width: dou,
        // height: 300,
=======
    final homeController = Get.put(HomeBottomBarController());
    return Expanded(
      flex: 13,
      child: Container(
>>>>>>> main
        padding: const EdgeInsets.all(10),
        child: Container(
          height: double.infinity,
          child: Image.file(homeController.image as File),
          // decoration: BoxDecoration(image: DecorationImage(image: Image.file(homeController.image))
        ),
      ),
    );
  }
}

