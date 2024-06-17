import 'package:flutter/material.dart';
import 'package:fox/core/app_export.dart';
import 'package:fox/presentation/main_screen/controller/main_screen_controller.dart';
import 'package:fox/presentation/sticker_screen/controller/sticker_controller.dart';
import 'package:fox/presentation/sticker_screen/models/sticker_models.dart';
import 'package:fox/theme/primitives.dart';

Primitives primitives = new Primitives();
class StickerScreen extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<StickerController>(
        builder: (controller) => Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(flex: 1, child: ListPackSticker(controller)),
              Expanded(flex: 10, child: ShowSticker(controller)),
        
            ],
          ),
        ),
      ),
    );
  }
  Widget DisplayStickers(MainScreenController mainController) {
    return GetBuilder<StickerController>(
        builder: (controller) => Stack(children: [
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
                child: CustomSticker(controller, i, controller.stickerInserted[i].isChoose),
              ),
            )
        ]));
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
        ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.listNamePack.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:  5.0, vertical: 15),
              child: OutlinedButton(
                  onPressed: () {
                    controller.ChoosePackSticker(index);
                  },
                  child: Text(
                      controller.listNamePack[index],
                    style: TextStyle(fontSize: 17,
                        color: Colors.cyan,
                        backgroundColor: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue, width: 1), // Border color and width
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                overlayColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                ),
              )),
            );
          });
    }
  }
  Widget ShowSticker(StickerController controller){
    return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: controller.currentPack.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  controller.ChooseSticker(index);
                  Get.back();
                  },
                  child: Image.asset(controller.currentPack.elementAt(index), fit: BoxFit.contain,)
              ),
            );
          },
    );
  }


}
