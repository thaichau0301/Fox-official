import 'package:flutter/material.dart';
import 'package:fox/core/app_export.dart';
import 'package:fox/presentation/sticker_screen/controller/sticker_controller.dart';
import 'package:fox/presentation/sticker_screen/models/sticker_models.dart';
import 'package:fox/theme/primitives.dart';

import '../main_navigation/main_bottom_navigation.dart';

Primitives primitives = new Primitives();
class StickerOverlay extends StatelessWidget {
  const StickerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StickerController());
    return SafeArea(
        child: Scaffold(
          backgroundColor: primitives.surface_secondary,
          body: GetBuilder<StickerController>(
            builder: (controller) => Column(
              children: [
                  Expanded(
                      flex: 2,
                      child: Stack(children: [
                        Image.file(
                          Get.arguments['image'],
                          fit: BoxFit.contain,
                        ),
                        for(int i=0; i<controller.stickerInserted.length; i++)
                          Positioned(
                            top: controller.stickerInserted[i].top,
                            left: controller.stickerInserted[i].left,
                            child: GestureDetector(
                              onTap: ()  {
                                controller.EditSticker(i);
                              },
                              onPanUpdate: (details)  {
                                controller.stickerInserted[i].left += details.delta.dx;
                                controller.stickerInserted[i].top += details.delta.dy;
                                controller.update();
                              },
                              child: CustomSticker(controller, i, controller.stickerInserted[i].isShowButton),
                            ),
                          )
                      ])),
                  SizedBox(height: 20,),
                Expanded(flex: 1, child: Column(
                  children: [
                    Expanded(flex: 1, child: ListPackSticker(controller)),
                    SizedBox(height: 10,),
                    Expanded(flex: 4, child: ShowSticker(controller)),
                  ],
                ))
              ],
            ),
          ),
        ));
  }

  Widget CustomSticker(StickerController controller, int i, bool isShowButton) {
    return Container(
      height: 200,
      width: 200,
      child: Stack(
        alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              left: 10,
              child: Visibility(
                visible: isShowButton,
                child: ElevatedButton(
                    onPressed: () { controller.CopySticker(i); },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      backgroundColor: Colors.white,
                    ),
                    child: Icon(
                      Icons.copy_rounded,
                      color: Colors.black,
                      size: 15,
                    )),
              )
            ),
            Positioned(
              top: 20,
              right: 10,
              child: Visibility(
                visible: isShowButton,
                child: ElevatedButton(
                    onPressed: () { controller.DeleteSticker(i); },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      backgroundColor: Colors.white,
                    ),
                    child: Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.black,
                      size: 15,
                    )),
              )
            ),
        Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.symmetric(vertical:  10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border:
                  Border.all(color: isShowButton == true ? Colors.white : Colors.transparent, width: 2.0),
            ),
            child: StickerModels(
              stickerInfo: controller.stickerInserted[i],
            )),
      ]),
    );
  }
  Widget ListPackSticker(StickerController controller) {
    if(controller.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }
    else {
      return
        Row(
          children: [
            Expanded(
              child: Container(
                height: 60,
                color: primitives.surface_secondary,
                padding: EdgeInsets.all(5),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.previewPackSticker.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            controller.ChoosePackSticker(index);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                                controller.previewPackSticker[index]),
                          )
                      );
                    }
                ),
              ),
            ),
            IconButton(onPressed: (){
              Get.to(() => MainBottomBar());
            },
                icon: Icon(Icons.check_outlined, color: Colors.white,))
          ],
        );
    }
  }
  Widget ShowSticker(StickerController controller){
    return Container(
      color: Colors.white,
      child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemCount: controller.currentPack.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    controller.ChooseSticker(index);
                    },
                    child: Image.asset(controller.currentPack.elementAt(index), fit: BoxFit.contain,)
                ),
              );
            },
      ),
    );
  }
}
