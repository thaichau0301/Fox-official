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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: primitives.surface_secondary,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex:  10,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:  10.0),
                      child: customFrameImage,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: customBottom!)
          ],
        )),
    );
  }

}