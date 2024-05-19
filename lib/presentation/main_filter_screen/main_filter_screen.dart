
import 'package:flutter/material.dart';
import 'package:fox/presentation/main_filter_screen/controller/main_filter_controller.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_navigation_top.dart';
import '../../widgets/custom_placeholder_image_upload.dart';
import '../../widgets/custom_slider.dart';

class InsertFilters extends StatefulWidget {
  InsertFilters({super.key});

  @override
  State<InsertFilters> createState() => _InsertFiltersState();
}

class _InsertFiltersState extends State<InsertFilters> {
  Primitives primitives = Get.put(Primitives());
  CustomSlider controller_slider = Get.put(CustomSlider());
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(mainFilterController());
    return GetBuilder<mainFilterController>(
      builder: (controller) => Expanded(
        flex: 2,
        child: Container(
          child: Column(
            children: [
              CustomSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
