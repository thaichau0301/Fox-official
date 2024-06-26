import 'package:flutter/material.dart';
import 'package:fox/presentation/text_edit_screen/text_edit_screen.dart';
import 'package:get/get.dart';
import 'controller/text_edit_controller.dart';

final TextController controller = Get.put(TextController());
class EnterText extends StatelessWidget {
  const EnterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Positioned.fill( child: Image.file(Get.arguments['image'], fit: BoxFit.cover,)),
          Container(
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          textEditingController.clear();
                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if(controller.currentIndexText.value == -1){
                            controller.addNewText(textEditingController.text);
                          }
                          else {
                            controller.updateText(textEditingController.text);
                          }
                          textEditingController.clear();
                          Get.back();
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                const Spacer(flex: 1,),
                FormEnterText(),
                const Spacer(flex: 3,),
              ],),
          )
        ],)
    );
  }
}
Widget FormEnterText(){
  return TextField(
    maxLines: null,
    textAlign: TextAlign.center,
    autofocus: true,
    style: TextStyle(fontSize : 20.0, color: Colors.white),
    controller: textEditingController,
    decoration: InputDecoration(
      hintText: 'Enter text...',
      hintStyle: TextStyle(color: primitives.text_secondary, fontSize: 15),
      filled: true,
      fillColor: Colors.transparent,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
    ),
  );
}