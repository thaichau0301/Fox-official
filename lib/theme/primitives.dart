import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Primitives {  //0xFF    A1A1A1
  // final Rx<Color> text_primary = Color(0xFF000000).obs; // Thay đổi mã màu cho biến màu của bạn
  // static const Color text_secondary = Color(0xFFA1A1A1);
  // static const Color text_third = Color(0xFFFBFBFB);
  // Thêm các biến màu khác ở đây
  final Rx<Color> color30 = Color(0xFF5A91F7).obs;
  // colors/yellow
  //static const Color color30 = Color(0xFF);
  final Rx<Color> yellow1 = Color(0xFFFBBC05).obs;
  final Rx<Color> yellow2 = Color(0xFFF7D046).obs;
  final Rx<Color> yellow3 = Color(0xFFFFFF00).obs;
  //colors/grey
  final Rx<Color> grey50 = Color(0xFFFFFFFF).obs;

  final Rx<Color> grey100 = Color(0xFFF2F2F2).obs;
  final Rx<Color> grey120 = Color(0xFFF6F6F6).obs;
  final Rx<Color> grey150 = Color(0xFFFBFBFB).obs;
  final Rx<Color> grey180 = Color(0xFFC5C5CD).obs;
  final Rx<Color> grey200 = Color(0xFFA1A1A1).obs;
  final Rx<Color> grey230 = Color(0xFF97979D).obs;
  final Rx<Color> grey250 = Color(0xFF8E8E92).obs;
  final Rx<Color> grey300 = Color(0xFF5E5E5E).obs;
  final Rx<Color> grey350 = Color(0xFF5B5C60).obs;
  final Rx<Color> grey400 = Color(0xFF3E3E3E).obs;
  final Rx<Color> grey450 = Color(0xFF434343).obs;
  final Rx<Color> grey480 = Color(0xFF3B3B3B).obs;
  final Rx<Color> grey500 = Color(0xFF232323).obs;
  final Rx<Color> grey550 = Color(0xFF2C2C2D).obs;
  final Rx<Color> grey600 = Color(0xFF141414).obs;
  final Rx<Color> grey700 = Color(0xFF000000).obs;
  // colors/blue
  final Rx<Color> blue1 = Color(0xFF2667FF).obs;
  final Rx<Color> blue2 = Color(0xFF1D4E89).obs;
  final Rx<Color> blue3 = Color(0xFF5A91F7).obs;
  //colors/red
  final Rx<Color> red1 = Color(0xFFDF5243).obs;

  // object
  final Rx<double> object1 = 25.0.obs;
  final Rx<double> object2 = 30.0.obs;
  final Rx<double> object3 = 35.0.obs;
  final Rx<double> object4 = 40.0.obs;

  // radius
  final Rx<double> radius1 = 4.0.obs;
  final Rx<double> radius2 = 8.0.obs;
  final Rx<double> radius3 = 16.0.obs;
  final Rx<double> radius4 = 20.0.obs;
  final Rx<double> radius5 = 24.0.obs;
  final Rx<double> radius6 = 28.0.obs;
  final Rx<double> radius7 = 32.0.obs;
  final Rx<double> radius8 = 36.0.obs;

  //spacing
  final Rx<int> spacing0 = 4.obs;

  //Token
  Rx<Color> get surface_text => grey250;
  Rx<Color> get text_primary => grey700;
  Rx<Color> get text_secondary => grey200;
  Rx<Color> get text_third => grey150;
  Rx<Color> get text_dialog => blue3;
  Rx<Color> get text_fourth => blue2;
  // Surface
  Rx<Color> get surface_primary => grey50;
  Rx<Color> get surface_secondary => grey600;
  Rx<Color> get surface_tools => grey500;
  Rx<Color> get surface_button_1 => blue1;
  Rx<Color> get surface_button_2 => yellow2;
  Rx<Color> get surface_textbox => grey120;
  Rx<Color> get surface_dialog => grey550;
  Rx<Color> get surface_icon1 => grey230;
  Rx<Color> get surface_icon2 => grey350;
  Rx<Color> get surface_icon3 => grey450;
  Rx<Color> get surface_icon4 => yellow1;
  // Radius
  Rx<double> get radius_xs => radius1;
  Rx<double> get radius_sm => radius2;
  Rx<double> get radius_md => radius3;
  Rx<double> get radius_lg => radius4;
  Rx<double> get radius_xl => radius5;
  // Border
  Rx<Color> get border_primary => grey300;
  Rx<Color> get border_secondary => grey180;
  
  // active and inactive
  Rx<Color> get active => grey250;
  Rx<Color> get inactive => grey480;



}

// Sử dụng các biến màu và số trong ứng dụng của bạn bằng cách:
// AppColors.color1, AppColors.number1, v.v.