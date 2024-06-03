// import 'dart:io';
//
// import 'package:fox/presentation/main_adjust_screen/controller/main_adjust_controller.dart';
// import 'package:fox/presentation/main_navigation/controller/main_bottom_navigation_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:fox/widgets/custom_navigation_top.dart';
// import 'package:get/get.dart';
// import 'package:image/image.dart' as img;
// import 'package:photofilters/filters/filters.dart';
// import 'package:photofilters/filters/preset_filters.dart';
// import 'package:photofilters/widgets/photo_filter.dart';
// import 'dart:typed_data';
// import 'package:path/path.dart';
// List<Filter> filters = presetFiltersList;
// class PlaceHolderImage extends StatelessWidget {
//   bool showFilter = false;
//   PlaceHolderImage(this.showFilter);
//
//   @override
//   Widget build(BuildContext context) {
//     final mainController = Get.find<MainBottomNavController>();
//     final adjustController = Get.put(MainAdjustController());
//     return  PhotoFilterSelector(
//           customAppBar: navigationTop(),
//           image: img.decodeImage(File(mainController.editedImage!.path).readAsBytesSync())!,
//           filters: presetFiltersList,
//           filename: basename(mainController.editedImage!.path),
//           loader: const Center(child: CircularProgressIndicator(strokeWidth: 1.0, )),
//           fit: BoxFit.contain,
//           isFilter: showFilter,
//         );
//   }
// }
//
