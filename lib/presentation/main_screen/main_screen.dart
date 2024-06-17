import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:fox/presentation/main_adjust_screen/controller/main_adjust_controller.dart';
import 'package:fox/presentation/main_adjust_screen/main_adjust_screen.dart';
import 'package:fox/presentation/paint_screen/paint_screen.dart';
import 'package:fox/presentation/sticker_screen/sticker_screen.dart';
import 'package:fox/widgets/main_frame.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import '../../theme/primitives.dart';
import '../../widgets/custom_bottom_sheet_confirm_cancel.dart';
import '../paint_screen/controller/paint_screen_controller.dart';
import '../sticker_screen/controller/sticker_controller.dart';
import '../text_edit_screen/controller/text_edit_controller.dart';
import '../text_edit_screen/text_edit_screen.dart';
import 'controller/main_screen_controller.dart';

Primitives primitives = new Primitives();
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainScreenController());
    Get.put(TextController());
    Get.put(PaintController());
    Get.put(StickerController());
    Get.put(MainAdjustController());
    return GetBuilder<MainScreenController>(
      builder: (controller) => MainFrame(
        customAppBar: customAppBar(context, controller),
        customFrameImage: customFrameImage(controller),
        customBottom: changeBottom(controller),
      ).FrameForAll(),
    );
  }

  Widget changeBottom(MainScreenController controller) {
    switch (controller.tabIndex.value) {
      case -1:
        return Column(
          children: [
            Expanded(
                flex: 2, child: Container()),
            Expanded(
                flex: 3,
                child: customBottomBar(controller)),
          ],
        );
      case 0:
        return AdjustTools().visualAdjustment(controller);
      case 1:
      case 2:
      case 3:
        return GetBuilder<TextController>(
          builder: (controller) =>  Column(
            children: [
              Expanded(flex: 2, child: TextEditScreen().BuildMenuTools()),
              Expanded(
                  flex: 3, child: TextEditScreen().BuildBottomText()),
            ],
          ),
        );
      case 4:
        return GetBuilder<PaintController>(
          builder: (controller) => Column(
            children: [
              Expanded(flex: 2, child: PaintScreen().CustomTools(controller)),
              Expanded(flex: 3, child: PaintScreen().CustomBottomPaint()),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  Widget MarkupPaint() {
    return GetBuilder<PaintController>(
      builder: (controller) =>
          ClipRect(
            child: CustomPaint(
              painter: DrawingPainter(lines: controller.lines),
            ),
          ),
    );
  }

  Widget MarkupText(MainScreenController mainController) {
    return TextEditScreen().BuildDisplayImage(mainController);
  }

  Widget MarkupSticker(MainScreenController mainController) {
    return StickerScreen().DisplayStickers(mainController);
  }

  PreferredSizeWidget customAppBar(context, MainScreenController controller) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        backgroundColor: primitives.surface_tools,
        iconTheme: IconThemeData(color: Colors.white),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              bottomSheetConfirm().confirmCancel();
            },
            icon: Icon(Icons.arrow_back_ios),
            highlightColor: Colors.transparent,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(200, 70, 0, 100),
                  color: Colors.black,
                  items: [
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () async {
                          controller.saveImageGallery();
                          Get.toNamed('/home_screen');
                        },
                        child: const Text(
                          'Save to camera roll',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {
                          controller.saveImageStudio();
                          Get.toNamed('/home_screen');
                        },
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
                Icons.file_download_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customFrameImage(MainScreenController controller) {
    return Screenshot(
      controller: controller.screenshotController,
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          GetBuilder<MainAdjustController>(
            builder: (adjustController) => ColorFiltered(
              colorFilter: ColorFilter.matrix(
                adjustController.brightnessAdjustMatrix(
                    value: adjustController.brightnessImg.value / 200),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix(
                  adjustController.saturationAdjustMatrix(
                      value: adjustController.saturationImg.value / 200),
                ),
                child: Image.file(
                  controller.editedImage.value!,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),

          if (controller.tabIndex.value == 4)
            Positioned.fill(child: PaintScreen().buildPaint()) // can paint
          else
            Positioned.fill(child: MarkupPaint()), // only show line paint

          Positioned.fill(child: MarkupText(controller)),
          Positioned.fill(child: MarkupSticker(controller)),
        ],
      ),
    );
  }

  Widget customBottomBar(MainScreenController controller) {
    List<Map<String, dynamic>> listButton = [
      {'Adjust' : Icons.tune_outlined,},
      {'Filters' : Icons.filter_tilt_shift_outlined,},
      {'Crop' : Icons.crop,},
      {'Text' : FeatherIcons.type,},
      {'Brush' : Icons.draw_outlined,},
      {'Stickers' : Icons.tag_faces_outlined,},
    ];
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listButton.length,
        itemBuilder: (context, index) {
          return TextButton(
              onPressed: () {
                controller.changeTabIndex(index);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Icon(listButton[index].values.first,
                        size: 30, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Text(
                      listButton[index].keys.first,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            style: TextButton.styleFrom(
              overlayColor: Colors.transparent
            ),
          );
        });
  }
}
