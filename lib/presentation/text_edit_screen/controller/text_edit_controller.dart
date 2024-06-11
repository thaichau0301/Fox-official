import 'package:flutter/material.dart';
import 'package:fox/core/app_export.dart';
import 'package:fox/presentation/main_navigation/controller/main_bottom_navigation_controller.dart';
import 'package:get/get.dart';
import '../text_edit_model.dart';

class MainTextController extends GetxController {
  var selectedFont;
  var selectedColor;
  var indexChildWidget;
  RxInt currentIndexText = 0.obs;
  var selectedFormatText = List.filled(3, false);
  var selectedAlignHorizontal = List.filled(3,false).obs;
  var selectedAlignVertical = List.filled(3,false).obs;
  Map<String, double>? locationWidgetImage;

  var listFont = [ 'Open Sans', 'Oswald', 'Inter', 'Courier Prime', 'Roboto', 'Poppins',  'Playfair Display',  ];
  List<TextInfo> texts = [];
  TextEditingController textEditingController = new TextEditingController();
  MainBottomNavController mainController = Get.find();
  var sliderValue = 30.0.obs;
  void onInit(){
    super.onInit();
    selectedFont = 0.obs;
    selectedColor = 0.obs;
    indexChildWidget = 0.obs;
    texts = [];
  }
  void updateValueSlider(newValue) {
    if(sliderValue.value != newValue){
      sliderValue.value = newValue;
    }
    update();
  }
  void changeTabIndex(int index) {
    indexChildWidget.value = index;
    update();
  }
  void changeFontIndex(int index) {
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
      textDecoration: TextDecoration.none,
      left: 100,
      top: 100,
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      fontSize: 30,
      textAlign: TextAlign.center,
      fontFamily: 'Roboto',
    ));
    update();
  }
  void duplicateText(){
    if(texts[currentIndexText.value].text != '') {
      TextInfo duplicate = texts[currentIndexText.value];
      texts.add(TextInfo(
        text: duplicate.text,
        textDecoration: duplicate.textDecoration,
        left: duplicate.left + 20,
        top: duplicate.top + 20,
        color: duplicate.color,
        fontWeight: duplicate.fontWeight,
        fontStyle: duplicate.fontStyle,
        fontSize: duplicate.fontSize,
        textAlign: duplicate.textAlign,
        fontFamily: duplicate.fontFamily,
      ));
      update();
    }
  }
  void updateText(String newText){
    texts.elementAt(currentIndexText.value).text = newText;
    update();
  }
  void deleteText(){
    if(texts.isNotEmpty){
      texts.removeAt(currentIndexText.value);
      update();
    }
    else {
      print('have not text');
    }
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
    // update();
    // Get.back();
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
//   final directory = await getApplicationDocumentsDirectory();
//   // new name image
//   String newName = 't_' + mainController.nameImage;
//   // save image
//   String? newImage = await screenshotController.captureAndSave(
//   delay: Duration(milliseconds: 100),
//   directory.path , fileName: newName);
//   // assign editedImage with new image
//   mainController.updateEditedImage(File(newImage!));
//   print(newImage);
// // delete temporary image
// // File(directory.path + newName).deleteSync();

}