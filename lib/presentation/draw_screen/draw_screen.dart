import 'package:flutter/material.dart';
import 'package:fox/widgets/custom_slider.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';

import '../../widgets/custom_navigation_top.dart';
import '../../widgets/custom_placeholder_image_upload.dart';


class draw_screen extends StatelessWidget {
  const draw_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }
  Widget buildBody () {
    Primitives primitives = Get.put(Primitives());
    custom_slider controller_slider = Get.put(custom_slider());
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: primitives.surface_secondary.value),
      child: Column(
        children: [
          navigationTop(),
          place_holder(),
          controller_slider.slider_primary(),
          customBottomAppBar(),
        ],
      ),
    );;

  }
  BottomAppBar customBottomAppBar () {
    return BottomAppBar(
      child: Row(
      children: [
        TextButton(onPressed: () {}, child: Text('Brush')),
        TextButton(onPressed: () {}, child: Text('Pencil')),
        TextButton(onPressed: () {}, child: Text('Highlight')),
        TextButton(onPressed: () {}, child: Text('Erase')),
        IconButton(onPressed: (){} , icon: Icon(Icons.color_lens)),
      ],
      ),
    );
  }
}
