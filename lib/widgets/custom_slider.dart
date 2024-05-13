import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

import '../theme/primitives.dart';

class custom_slider extends GetxController {
  var sliderValue = 0.0.obs;
  double _min = -100;
  double _max = 100;

  Primitives primitives = Get.put(Primitives());

  Widget slider_primary() {
    return Obx(() => Center(
            child: Column(children: [
              Stack(alignment: AlignmentDirectional.center, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25,35,25,35),
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                            value: 1 - sliderValue / _min,
                            color: primitives.inactive(),
                            backgroundColor: primitives.active()),
                        flex: _min.abs().round(),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                            value: sliderValue / _max,
                            color: primitives.active(),
                            backgroundColor: primitives.inactive()),
                        flex: _max.abs().round(),
                      ),
                    ],
                  ),
                ),
                Slider(
                  value: sliderValue.value,
                  activeColor: Colors.transparent,
                  inactiveColor: Colors.transparent,
                  // Tắt animation cho thumb
                  thumbColor: sliderValue == 0
                      ? primitives.surface_text()
                      : sliderValue > 0
                          ? primitives.text_secondary()
                          : primitives.text_secondary(),
                  min: _min,
                  max: _max,
                  divisions: (_min.abs() + _max.abs()).round(),
                  label: sliderValue.toInt().toString(),
                  onChanged: (double newValue) {
                    sliderValue.value = newValue;
                  },
                ),
          ]),
        ])));
  }
}
