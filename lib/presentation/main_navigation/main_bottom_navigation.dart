import 'package:fox/presentation/draw_screen/draw_screen.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fox/presentation/main_removeBg_screen/main_removeBg_screen.dart';
import 'package:fox/presentation/text_edit_screen/text_edit_screen.dart';
import 'package:fox/widgets/custom_navigation_top.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_placeholder_image_upload.dart';
import '../main_adjust_screen/main_adjust_screen.dart';
import '../main_crop_screen/main_crop_screen.dart';
import '../main_filter_screen/main_filter_screen.dart';
import '../main_remove_screen/main_remove_screen.dart';
import '../sticker_bottom_sheet_screen/sticker_bottom_sheet_screen.dart';
import 'controller/main_bottom_navigation_controller.dart';

class mainBottomBar extends StatefulWidget {
  const mainBottomBar({super.key});

  @override
  State<mainBottomBar> createState() => _mainBottomBarState();
}
Primitives primitives = Get.put(Primitives());

class _mainBottomBarState extends State<mainBottomBar> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(mainBarController());
    return GetBuilder<mainBarController>(builder: (controller){
      return Scaffold(
        backgroundColor: primitives.surface_secondary.value,
        appBar: CustomAppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: primitives.surface_secondary.value),
          child: Column(
            children: [
              navigationTop(),
              place_holder(),
              (()  {
                switch (controller.tabIndex.value) {
                case 0 : return AdjustTools();
                case 1 : return InsertFilters();
                case 2 : return CropTools();
                case 3 : return RemoveTools();
                case 4 : return RemoveBgTools();
                case 5 : return TextEditTools();
                case 6 : return DrawTools();
                case 7 : return InsertSticker();
                default: return Text('Nothing'); }
              })(),
              customBottomBar(),
            ],
          ),
        ),
      );
    });
  }
  Widget customBottomBar () {
    final controller = Get.find<mainBarController>();
    var listBottomIcon = [
      Icons.tune_outlined,
      Icons.filter_tilt_shift_outlined,
      Icons.crop,
      Icons.texture_outlined,
      Icons.broken_image,
      FeatherIcons.type,
      Icons.draw_outlined,
      Icons.tag_faces_outlined,
    ];
    var listBottomLabel = ['Adjust', 'Filters', 'Crop','Remove','Remove BG','Text','Draw','Stickers', ];
    return Container(
      height: 70,
      color: primitives.surface_tools.value,
        child: GetBuilder<mainBarController>(
          builder: (controller) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listBottomIcon.length,
            itemBuilder: (context, index) {
              return TextButton(
                  onPressed: () { controller.changeTabIndex(index);},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Icon(listBottomIcon[index],
                          size: 30,
                          color: controller.tabIndex.value == index ? primitives.activeIconBottomBar.value : primitives.inactiveIconBottomBar.value,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Expanded(
                        child: Text(listBottomLabel[index], style: TextStyle(
                            color: controller.tabIndex.value == index ?
                            primitives.activeIconBottomBar.value : primitives.inactiveIconBottomBar.value,
                          fontSize: primitives.font_sm
                        ),),
                      )
                    ],
              )
              );
          }),
        )
    );
  }

}
