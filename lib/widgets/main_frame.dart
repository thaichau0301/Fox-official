import 'package:flutter/material.dart';
import 'package:fox/theme/primitives.dart';

Primitives primitives = new Primitives();
class MainFrame {
  final PreferredSizeWidget customAppBar;
  final Widget customFrameImage;
  final Widget? customBottom;

  MainFrame(
    {
    required this.customAppBar,
    required this.customFrameImage,
    required this.customBottom,
    });

  Widget FrameForAll() {
    return Scaffold(
      appBar: customAppBar,
      backgroundColor: primitives.surface_secondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Center(child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: customFrameImage,
            )),
          ),
          Expanded(
            flex: 1,
            child: customBottom!)
        ],
      ),
    );
  }

}