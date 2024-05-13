
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_navigation_top.dart';
import '../../widgets/custom_placeholder_image_upload.dart';
import '../../widgets/custom_slider.dart';

class main_filter extends StatefulWidget {
  const main_filter({super.key});

  @override
  State<main_filter> createState() => _main_filterState();
}

class _main_filterState extends State<main_filter> {
  Primitives primitives = Get.put(Primitives());
  custom_slider controller_slider = Get.put(custom_slider());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF141414)),
        child: Column(
          children: [
            navigationTop(),
            place_holder(),
            controller_slider.slider_primary(),
          ],
        ),
      )
      );
  }
}
