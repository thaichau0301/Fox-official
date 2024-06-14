import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Primitives {  //0xFF    A1A1A1
  final Rx<Color> color30 = Color(0xFF5A91F7).obs;
  // colors/yellow
  //static const Color color30 = Color(0xFF);
   Color yellow1 = Color(0xFFFBBC05);
   Color yellow2 = Color(0xFFF7D046);
  Color yellow3 = Color(0xFFFFFF00);
  //colors/grey
   Color grey50 = Color(0xFFFFFFFF);

  Color grey100 = Color(0xFFF2F2F2);
  Color grey120 = Color(0xFFF6F6F6);
  Color grey150 = Color(0xFFFBFBFB);
  Color grey180 = Color(0xFFC5C5CD);
  Color grey200 = Color(0xFFA1A1A1);
  Color grey230 = Color(0xFF97979D);
  Color grey250 = Color(0xFF8E8E92);
  Color grey300 = Color(0xFF5E5E5E);
  Color grey350 = Color(0xFF5B5C60);
  Color grey400 = Color(0xFF3E3E3E);
  Color grey450 = Color(0xFF434343);
  Color grey480 = Color(0xFF3B3B3B);
   Color grey500 = Color(0xFF232323);
   Color grey550 = Color(0xFF2C2C2D);
   Color grey600 = Color(0xFF141414);
   Color grey700 = Color(0xFF000000);
  // colors/blue
  Color blue1 = Color(0xFF2667FF);
  Color blue2 = Color(0xFF1D4E89);
  Color blue3 = Color(0xFF5A91F7);
  //colors/red
  Color red1 = Color(0xFFDF5243);

  // object
  final Rx<double> object1 = 25.0.obs;
  final Rx<double> object2 = 30.0.obs;
  final Rx<double> object3 = 35.0.obs;
  final Rx<double> object4 = 40.0.obs;

  // radius
  final Rx<double> radius1 = 4.0.obs;
  final double radius2 = 8.0;
  final Rx<double> radius3 = 16.0.obs;
  final Rx<double> radius4 = 20.0.obs;
  final Rx<double> radius5 = 24.0.obs;
  final Rx<double> radius6 = 28.0.obs;
  final Rx<double> radius7 = 32.0.obs;
  final Rx<double> radius8 = 36.0.obs;

  //spacing
  final double spacing_none = 0;
  final double spacing_xs = 4;
  final double spacing_sm = 8;
  final double spacing_md = 12;
  final double spacing_lg = 16;
  final double spacing_xl = 20;
  final double spacing_2xl = 24;

  // font size
  final double font_xs = 10;
  final double font_sm = 12;
  final double font_md = 14;
  final double font_lg = 16;

  //Token
  Color get surface_text => grey480;
  Color get text_primary => grey700;
  Color get text_secondary => grey200;
  Color get text_third => grey150;
  Color get text_dialog => blue3;
  // Color  text_fourth = blue2;
  // Surface
  Color get surface_primary => grey50;
  Color get surface_secondary => grey600;
  Color get surface_tools => grey500;
  // Rx<Color> get surface_button_1 => blue1;
  // Rx<Color> get surface_button_2 => yellow2;
  // Rx<Color> get surface_textbox => grey120;
  // Rx<Color> get surface_dialog => grey550;
  Color get surface_icon1 => grey230;
  Color get surface_icon2 => grey350;
  Color get surface_icon3 => grey450;
  // Rx<Color> get surface_icon4 => yellow1;

  Color  inactiveIconBottomBar = Color(0xFF97979D);
  Color  activeIconBottomBar = Color(0xFFFFFFFF);
  // Border
  Color border_primary = Color(0xFF5E5E5E);
  Color border_secondary = Color(0xFFC5C5CD);

  // active and inactive
  Color active = Color(0xFF8E8E92);
  Color inactive = Color(0xFF3B3B3B);

  // active and inactive of icon button
  Color inactiveIconButton = Color(0xFFFFFFFF);
  Color activeIconButton = Color(0xFF5A91F7);


  Color inactiveIconButton2 = Color(0xFFFFFFFF);
  Color activeIconButton2 = Color(0xFFFBBC05);
  final double space = 20;

}
