
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_placeholder_image_upload.dart';

class main_crop extends StatefulWidget {
  const main_crop({super.key});

  @override
  State<main_crop> createState() => _main_cropState();
}
Primitives primitives = Get.put(Primitives());

class LabelAndFunction {
  String label;
  Function function;
  LabelAndFunction({required this.label, required this.function});
}
List<LabelAndFunction> buttonRatio = [
  LabelAndFunction(label: 'Original', function: (){}),
  LabelAndFunction(label: 'Freeform', function: (){}),
  LabelAndFunction(label: 'Square', function: (){}),
  LabelAndFunction(label: '3:2', function: (){}),
  LabelAndFunction(label: '4:3', function: (){}),
  LabelAndFunction(label: '5:4', function: (){}),
  LabelAndFunction(label: '19:6', function: (){}),
  LabelAndFunction(label: '2:3', function: (){}),
  LabelAndFunction(label: '3:4', function: (){}),
  LabelAndFunction(label: '6:19', function: (){}),
  LabelAndFunction(label: '4:5', function: (){}),
];
var activeBtnIndex = 0;
class _main_cropState extends State<main_crop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildBody()
    );
  }

  Container buildBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: primitives.surface_secondary.value),
        child: Column(
          children: [
            customNavigationTop(),
            place_holder(),
            list_aspect_ratio()
          ],
        ),
      );
  }
  Widget list_aspect_ratio (){
    final double textSize = 15;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: buttonRatio.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        itemBuilder: (BuildContext context, int index) {
          return TextButton(onPressed: (){
              setState(() {
                activeBtnIndex = index;
              });
            },
            child: Text(buttonRatio.elementAt(index).label,
                style: TextStyle(
                  color: activeBtnIndex == index ? primitives.yellow1.value : primitives.text_secondary.value,
                  fontSize: textSize
                ),
                ),
            style: TextButton.styleFrom(
              foregroundColor: primitives.surface_secondary.value.withOpacity(0),
            ),
          );
        }
      ),
    );

  }

  Widget customNavigationTop () {
    return Container( // navigation menu top
      width: double.infinity,
      height: 35,
      color: primitives.surface_secondary(),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.sync_alt_outlined, color: primitives.surface_icon2(),)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.crop_rotate_outlined ,color: primitives.surface_icon2(),)
              ),
            ],
          ),
        ],
      ),
    );

  }


}
