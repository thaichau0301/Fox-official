import 'package:flutter/material.dart';
import 'package:get/get.dart';

class mainRemoveBgController extends GetxController {
  var selectedIndex = 0.obs;
  void onTapChangeTab(index) {
    selectedIndex.value = index;
    update();
  }
}
