import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:fox/widgets/main_frame.dart';
import 'package:get/get.dart';
import '../../theme/primitives.dart';
import '../../widgets/custom_bottom_sheet_confirm_cancel.dart';
import '../text_edit_screen/controller/text_edit_controller.dart';
import '../text_edit_screen/text_edit_model.dart';
import 'controller/main_bottom_navigation_controller.dart';

Primitives primitives = new Primitives();


class MainBottomBar extends StatelessWidget {
  const MainBottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    //delete a particular instance of controller, force = true to reset controller
    // Get.delete<MainBottomNavController>(force: true);
    final controller = Get.put(MainBottomNavController());
    return MainFrame(
        customAppBar: customAppBar(context),
        customFrameImage: customPlaceImage(controller),
        customMenuTools: Container(),
        customBottomNavigationBar: customBottomBar()).FrameForAll();
  }

  Widget markupText(){
    final textController = Get.put(MainTextController());
      return Stack(
        children: [
            for(int i = 0; i < textController.texts.length; i++)
              Positioned(
                  left: textController.texts[i].left,
                  top: textController.texts[i].top,
                  child: ImageText(textInfo: textController.texts[i],)
              ),

        ],
      );
  }
  PreferredSizeWidget customAppBar(context) {
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
                        child: const Text(
                          'Save to camera roll',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Save to studio',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                );
              },
              icon: const Icon(
                Icons.file_upload_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget customPlaceImage(MainBottomNavController controller) {
    return Stack(
      alignment: Alignment.center,
      children: [
      Image.file(controller.editedImage.value!),
      markupText(),
        IconButton(onPressed: (){print(controller.editedImage.value!);}, icon: Icon(Icons.camera,color: Colors.white,))
    ],
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
    final controller = Get.find<MainBottomNavController>();
    return Container(
      height: 90,
      color: primitives.surface_secondary,
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
                          color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Expanded(
                      child: Text(
                        listBottomLabel[index], style: TextStyle(
                          color: Colors.white,
                          fontSize: 12
                      ),),
                    )
                  ],
                )
            );
          }),
    );
  }
}
