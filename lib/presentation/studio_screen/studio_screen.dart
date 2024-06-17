import 'package:fox/presentation/studio_screen/controller/studio_controller.dart';
import 'package:fox/presentation/studio_screen/image_model.dart';
import 'package:fox/theme/primitives.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

Primitives primitives = new Primitives();

class StudioScreen extends StatelessWidget {
  const StudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StudioController());
    return SafeArea(
        child: GetBuilder<StudioController>(
      builder: (StudioController controller) => Scaffold(
          appBar: buildAppBar(controller, context),
          body: controller.images.isNotEmpty
              ? ShowImages(controller)
              : Center(
                  child: Text(
                    'No images',
                    style: TextStyle(fontSize: 25),
                  ),
                )),
    ));
  }

  AppBar buildAppBar(StudioController controller, BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          controller.FunctionExitStudio();
        },
        icon: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      actions: [
        Visibility(
          visible: controller.isSelected.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              onPressed: () {
                controller.deleteImage();
              },
              icon: Icon(Icons.delete_outline),
            ),
          ),
        ),
        Visibility(
          visible: controller.images.isNotEmpty,
          child: IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(200, 70, 0, 100),
                color: primitives.surface_primary,
                items: [
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () async {
                        controller.ShowSelectedImage();
                        Get.back();
                      },
                      child: const Text(
                        'Select',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      style: TextButton.styleFrom(
                          overlayColor: Colors.transparent),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () {
                        controller.ShowSelectedImage();
                        controller.selectedAllImage();
                        Get.back();
                      },
                      child: const Text(
                        'Select all',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      style: TextButton.styleFrom(
                          overlayColor: Colors.transparent),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                ],
              );
            },
            icon: Icon(Icons.menu_outlined),
            style: IconButton.styleFrom(highlightColor: Colors.transparent),
          ),
        )
      ],
    );
  }

  Widget ShowImages(StudioController controller) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust as needed
      ),
      itemCount: controller.images.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
            child: GestureDetector(
                onDoubleTap: () {
                  controller.EditImage(controller.images[index].url);
                },
                child: Stack(
                  alignment: Alignment.topRight,
                    children: [
                  Positioned.fill(
                    child: DisplayImage(
                      imageModel: ImageModel(
                          url: controller.images[index].url,
                          isCheck: controller.images[index].isCheck),
                    ),
                  ),
                  Visibility(
                    visible: controller.isSelected.value,
                    child: Checkbox(
                      value: controller.images[index].isCheck,
                      onChanged: (bool? newValue) {
                        controller.selectedImage(newValue!, index);
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ])));
      },
    );
  }
}
