import 'dart:io';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/main_bottom_navigation_controller.dart';

Primitives primitives = Get.put(Primitives());
class MainBottomBar extends StatelessWidget {
  MainBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainBottomNavController());
    return Scaffold(
      // backgroundColor: primitives.surface_secondary.value,
      backgroundColor: Colors.white12,
      appBar: CustomAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
        color: Colors.black45),
        child: Obx(() => Image.file(controller.editedImage.value!)),
        ),
      bottomNavigationBar: customBottomBar(),
    );
  }
  Widget customBottomBar() {
    var listBottomIcon = [
      Icons.tune_outlined,
      Icons.filter_tilt_shift_outlined,
      Icons.crop,
      Icons.texture_outlined,
      Icons.broken_image,
      FeatherIcons.type,
      Icons.draw_outlined,
      Icons.tag_faces_outlined,
    ];
    var listBottomLabel = [
      'Adjust',
      'Filters',
      'Crop',
      'Remove',
      'Remove BG',
      'Text',
      'Draw',
      'Stickers',
    ];
    final controller = Get.put(MainBottomNavController());
    return Container(
      height: 90,
      color: primitives.surface_secondary.value,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listBottomIcon.length,
          itemBuilder: (context, index) {
            return TextButton(
                onPressed: () {
                  controller.changeTabIndex(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Icon(listBottomIcon[index],
                          size: 30,
                          color: primitives.activeIconBottomBar.value
                      ),
                    ),
                    SizedBox(height: 15,),
                    Expanded(
                      child: Text(
                        listBottomLabel[index], style: TextStyle(
                          color: primitives.activeIconBottomBar.value,
                          fontSize: primitives.font_sm
                      ),),
                    )
                  ],
                )
            );
          }),
    );
  }
}
