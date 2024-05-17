
import 'package:flutter/material.dart';
import 'package:fox/presentation/main_adjust_screen/main_adjust_screen.dart';
import 'package:get/get.dart';
import 'package:fox/presentation/main_remove_screen/controller/main_remove_controller.dart';
import '../../widgets/custom_slider_positive.dart';

class RemoveTools extends StatefulWidget {
  const RemoveTools({super.key});

  @override
  State<RemoveTools> createState() => _RemoveToolsState();
}

class _RemoveToolsState extends State<RemoveTools> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(mainRemoveController());
    final controller_slider = Get.put(sliderController());
    return GetBuilder<mainRemoveController>(
      builder: (controller) => Expanded(
        flex: 3,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(

            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){} ,
                      child: Text('Remove', style: TextStyle(fontSize: 15, color: Colors.white),),
                    style: TextButton.styleFrom(
                      backgroundColor: primitives.activeIconButton.value,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text('Size', style: TextStyle(fontSize: 12, color: Colors.white),),
                    SizedBox(width: 10,),
                    Expanded(child: CustomSliderPositive()),
                    SizedBox(width: 10,),
                    Obx(() => Text('${controller_slider.sliderValue.value.toInt()}', style: TextStyle(fontSize: 12, color: Colors.white),)),
                  ],
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
