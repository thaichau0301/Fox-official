import 'package:flutter/material.dart';
import 'package:fox/widgets/app_bar/custom_app_bar.dart';
import 'package:fox/widgets/custom_slider.dart';
import 'package:get/get.dart';
import 'package:fox/theme/primitives.dart';
import '../../widgets/custom_navigation_top.dart';
import '../../widgets/custom_placeholder_image_upload.dart';

custom_slider controller_slider = Get.put(custom_slider());
var selectedIndex = -1;

class text_edit_screen extends StatelessWidget {
  const text_edit_screen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: buildBody(),
      bottomNavigationBar: customBottomAppBar(),
    );
  }
  Widget buildBody () {
    Primitives primitives = Get.put(Primitives());
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: primitives.surface_secondary.value),
      child: Column(
        children: [
          navigationTop(),
          place_holder(),
          visualText(),
          // if (selectedIndex == 0) visualText()
          //   else if (selectedIndex == 1) visualFormat()
          //     else if (selectedIndex == 2) visualAlign()
          //       else if (selectedIndex == 3) visualAlign()
          //         else if (selectedIndex == 4) visualFontSize(),

        ],
      ),
    );;

  }
  BottomAppBar customBottomAppBar () {
    var listOptionBottomBar = ['Text', 'Format','Background' 'Align', 'Font size'];
    return BottomAppBar(
      color: Colors.transparent,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listOptionBottomBar.length,
        padding: EdgeInsets.all(5),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
              child: customBottomBarItem(listOptionBottomBar[index],  index)
          );
          //
          // // choose font and color for text
          // customBottomBarItem('Background', 1),
          // // color background for text
          // customBottomBarItem('Format', () => visualText()),
          // // bold, underline, italic for text
          // customBottomBarItem('Align', () => visualText()),
          // // include top, middle, bottom, left, center, right
          // customBottomBarItem('Font size', () => visualText()),
          // // slider for adjust font size
        },
      ),
    );
  }
  ElevatedButton customBottomBarItem(text, index) {
      return ElevatedButton(
        onPressed: (){selectedIndex = index;},
        child: Text(
            text,
          style: TextStyle(
            color: Color(0xFFA1A1A1),
            fontSize: 15,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.all(10),
        ),
      );
  }

  Widget visualText() {
    var listFont = [
      'Arial',
      'Roboto',
      'Calibre',
      'Courier New',
      'Didot',
      'Garamond',
      'Times New Roman',
      'Verdana',
    ];
    return ListView.builder(
        itemCount: listFont.length,
        itemBuilder: (BuildContext context, index) {
          return TextButton(onPressed: (){}, child: Text(listFont[index]));
        }
    );
  }
  Widget visualFormat(){
    return Center(
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.format_bold_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.format_italic_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.format_underline_outlined)),
        ],
      ),
    );
  }
  Widget visualAlign(){
    return Center(
      child: Row(
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.align_vertical_top_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.align_horizontal_center_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.align_vertical_bottom_outlined)),
          SizedBox(width: 10,),
          IconButton(onPressed: (){}, icon: Icon(Icons.align_horizontal_left_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.align_vertical_center_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.align_horizontal_right_outlined)),
        ],
      ),
    );
  }
  Widget visualFontSize() {
    return controller_slider.slider_primary();
  }
}
