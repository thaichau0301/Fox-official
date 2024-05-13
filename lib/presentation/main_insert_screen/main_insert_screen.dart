import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fox/theme/primitives.dart';
import 'package:fox/widgets/custom_placeholder_image_upload.dart';
import 'package:fox/widgets/custom_slider.dart';
import 'package:get/get.dart';

class main_insert extends StatelessWidget {
  const main_insert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Primitives primitives = Get.put(Primitives());
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: primitives.surface_secondary.value),
        child: Column(
          children: [
            place_holder(),
            optionInsert(),
          ]
        )
      ),
    );
  }
}


Row optionInsert() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      customText('Draw'),
      SizedBox(width: 10,),
      customText('Text'),
      SizedBox(width: 10,),
      customText('Sticker'),
    ],
  );
}
Widget customText(text) {
  return TextButton(
    onPressed: () { Get.toNamed('/text_edit_screen'); },
    child: Text(
      text,
      style: TextStyle(
        color: Color(0xFFA1A1A1),
        fontSize: 15,
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

void showBottomSheetDraw() {
  custom_slider controller_slider = Get.put(custom_slider());
  Get.bottomSheet(
      backgroundColor: Colors.amber,
      Column(
        children: [
          controller_slider.slider_primary(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.brush_outlined)),
              IconButton(onPressed: (){}, icon: Icon(Icons.mode_edit_outlined)),
              IconButton(onPressed: (){}, icon: Icon(Icons.highlight)),
              IconButton(onPressed: (){}, icon: Icon(Icons.format_paint_outlined)),
              IconButton(onPressed: (){}, icon: Icon(Icons.color_lens_outlined)),
            ],
          ),
        ],
      )
  );
}

// IconButton(onPressed: (){}, icon: Icon(Icons.brush_outlined)),
// IconButton(onPressed: (){}, icon: Icon(Icons.mode_edit_outlined)),
// IconButton(onPressed: (){}, icon: Icon(Icons.highlight)),
// IconButton(onPressed: (){}, icon: Icon(Icons.format_paint_outlined)),
// IconButton(onPressed: (){}, icon: Icon(Icons.color_lens_outlined)),