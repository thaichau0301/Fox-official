import 'package:flutter/material.dart';
import 'package:fox/core/app_export.dart';
import 'package:get/get.dart';
import '../text_edit_model.dart';

class MainTextController extends GetxController {
  var selectedFont = 0.obs;
  var selectedColor = 0.obs;
  var indexChildWidget = 0.obs;
  RxInt currentIndexText = 0.obs;
  var selectedFormatText = List.filled(3, false);
  var selectedAlignHorizontal = List.filled(3,false).obs;
  var selectedAlignVertical = List.filled(3,false).obs;
  Map<String, double>? locationWidgetImage;

  var listFont = [ 'Open Sans', 'Oswald', 'Inter', 'Courier Prime', 'Roboto', 'Poppins',  'Playfair Display',  ];
  List<TextInfo> texts = [];
  TextEditingController textEditingController = new TextEditingController();
  var sliderValue = 30.0.obs;


  void updateValueSlider(newValue) {
    if(sliderValue.value != newValue){
      sliderValue.value = newValue;
    }
    update();
  }
  void changeTabIndex(int index) {
    print(index);
    indexChildWidget.value = index;
    update();
  }
  void changeFontIndex(int index) {
    print(index);
    selectedFont.value = index;
    texts[currentIndexText.value].fontFamily = listFont[index];
    update();
  }
  void changeFormatIndex (int index) {
    selectedFormatText[index] == false ? selectedFormatText[index] = true : selectedFormatText[index] = false;
    switch(index){
      case 0: if(texts[currentIndexText.value].fontWeight == FontWeight.bold){
        texts[currentIndexText.value].fontWeight = FontWeight.normal;
      }
      else {
        texts[currentIndexText.value].fontWeight = FontWeight.bold;
      } break;

      case 1: if(texts[currentIndexText.value].fontStyle == FontStyle.normal){
        texts[currentIndexText.value].fontStyle = FontStyle.italic;
      }
      else {
        texts[currentIndexText.value].fontStyle = FontStyle.normal;
      } break;

      case 2: if(texts[currentIndexText.value].textDecoration == TextDecoration.none){
        texts[currentIndexText.value].textDecoration = TextDecoration.underline;
      }
      else {
        texts[currentIndexText.value].textDecoration = TextDecoration.none;
      } break;

    }
    update();
  }
  void changeAlignHorizontalIndex(int index) {
    selectedAlignHorizontal.assignAll(List.filled(3,false));
    selectedAlignHorizontal[index] = true;
    update();
  }

  void changeAlignVerticalIndex(int index) {
    selectedAlignVertical.assignAll(List.filled(3, false));
    selectedAlignVertical[index] = true;
    update();
  }

  void addNewText(String inputText) {
    texts.add(TextInfo(
      text: inputText,
    ));
    update();
  }
  void deleteText(){
    texts.removeAt(currentIndexText.value);
    update();
  }
  var listColors = [
    Colors.white,
    Colors.white70,
    Colors.white38,
    Colors.white24,
    Colors.black,
    Colors.blueAccent.shade700,
    Colors.blueAccent.shade400,
    Colors.blueAccent.shade200,
    Colors.blueAccent.shade100,
    Colors.redAccent.shade700,
    Colors.redAccent.shade400,
    Colors.redAccent.shade200,
    Colors.redAccent.shade100,
    Colors.brown,
    Colors.greenAccent.shade700,
    Colors.greenAccent.shade400,
    Colors.greenAccent.shade200,
    Colors.greenAccent.shade100,
    Colors.yellowAccent.shade700,
    Colors.yellowAccent.shade400,
    Colors.yellowAccent.shade200,
    Colors.yellowAccent.shade100,
  ];

  setCurrentIndex(int index) {
    currentIndexText.value = index;
    update();
    Get.snackbar('Selected', 'Style text');
  }
  changeTextColor(int indexColor){
    selectedColor.value = indexColor;
    texts[currentIndexText.value].color = listColors[indexColor];
    update();
  }
  changeTextSize(double size) {
    if (size != 30) {
      texts[currentIndexText.value].fontSize = size;
      update();
    }
  }
  isEmpty(){
    if(texts.isEmpty) {
      print('text empty');
    }
    else {
      print('text not empty');
    }
  }
}