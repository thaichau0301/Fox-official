import 'package:flutter/material.dart';
import 'package:fox/theme/primitives.dart';

Primitives primitives = new Primitives();
class MainFrame {
  final PreferredSizeWidget customAppBar;
  final Widget customFrameImage;
  final Widget? customMenuTools;
  final Widget customBottomNavigationBar;

  MainFrame(
    {
    required this.customAppBar,
    required this.customFrameImage,
    required this.customMenuTools,
    required this.customBottomNavigationBar
    });

  Widget FrameForAll() {
    return Scaffold(
      backgroundColor: primitives.surface_secondary,
      appBar: customAppBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black45),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      // Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex:  10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: customFrameImage,
                        ),
                      ),
                      // Expanded(flex: 1, child: Container()),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: customMenuTools!)
              ],
            )
        )),
      bottomNavigationBar: customBottomNavigationBar,
    );
  }

}