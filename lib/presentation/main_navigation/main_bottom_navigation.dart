import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/custom_bottom_sheet_confirm_cancel.dart';
import 'controller/main_bottom_navigation_controller.dart';

Primitives primitives = Get.put(Primitives());
class MainBottomBar extends GetView<MainBottomNavController> {
  const MainBottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    //delete a particular instance of controller, force = true to reset controller
    // Get.delete<MainBottomNavController>(force: true);
    final controller = Get.put(MainBottomNavController());
    return Scaffold(

      backgroundColor: Colors.white12,
      appBar: customAppBar(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        color: Colors.black45),
        child: Obx(() => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.file(controller.editedImage.value!),
        )),
        ),
      bottomNavigationBar: customBottomBar(),
    );
  }
  customAppBar(context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        backgroundColor: Colors.black12,
        iconTheme:IconThemeData(color: Colors.white),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(onPressed: (){ bottomSheetConfirm().confirmCancel();}, icon: Icon(Icons.arrow_back_ios), highlightColor: Colors.transparent,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(200, 90, 0, 100),
                  // Adjust position as needed
                  color: Colors.black,
                  items: [
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Save to camera roll',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Save to studio',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                );
              },
              icon: Icon(
                Icons.file_upload_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customBottomBar() {
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
    var listBottomLabel = [
      'Adjust',
      'Filters',
      'Crop',
      'Remove',
      'Remove BG',
      'Text',
      'Draw',
      'Stickers',
    ];
    final controller = Get.put(MainBottomNavController());
    return Container(
      height: 90,
      color: primitives.surface_secondary.value,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listBottomIcon.length,
          itemBuilder: (context, index) {
            return TextButton(
                onPressed: () {
                  controller.changeTabIndex(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Icon(listBottomIcon[index],
                          size: 30,
                          color: primitives.activeIconBottomBar.value
                      ),
                    ),
                    SizedBox(height: 15,),
                    Expanded(
                      child: Text(
                        listBottomLabel[index], style: TextStyle(
                          color: primitives.activeIconBottomBar.value,
                          fontSize: primitives.font_sm
                      ),),
                    )
                  ],
                )
            );
          }),
    );
  }
}
