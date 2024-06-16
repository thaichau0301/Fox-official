import 'package:flutter/material.dart';
import 'package:fox/core/app_export.dart';
import 'package:fox/presentation/main_screen/controller/main_screen_controller.dart';
import 'package:fox/widgets/colors_picker.dart';
import 'package:get/get.dart';
import '../text_edit_model.dart';

class TextController extends GetxController {
  var selectedFont;
  var selectedColor;
  var indexChildWidget = 0.obs;
  RxInt currentIndexText = 0.obs;
  var selectedFormatText = List.filled(3, false);
  var selectedAlignHorizontal = List.filled(3,false).obs;
  var selectedAlignVertical = List.filled(3,false).obs;
  Map<String, double>? locationWidgetImage;
  var listFont = [ 'Open Sans', 'Oswald', 'Inter', 'Courier Prime', 'Roboto', 'Poppins',  'Playfair Display',  ];
  List<TextInfo> texts = [];
  TextEditingController textEditingController = new TextEditingController();
  MainScreenController mainController = Get.find();

  var sliderValue = 30.0.obs;
  void onInit(){
    super.onInit();
    selectedFont = 0.obs;
    selectedColor = 0.obs;
    indexChildWidget = 0.obs;
    texts = [];
  }
  void updateValueSlider(newValue) {
    sliderValue.value = newValue;
    mainController.update();
  }
  void changeTabIndex(int index) {
    indexChildWidget.value = index;
    mainController.update();
  }
  void changeFontIndex(int index) {
    selectedFont.value = index;
    texts[currentIndexText.value].fontFamily = listFont[index];
    mainController.update();
  }
  void changeFormatIndex (int index) {
    selectedFormatText[index] == false ? selectedFormatText[index] = true : selectedFormatText[index] = false;
    switch(index){
      case 0: if(texts[currentIndexText.value].fontWeight == FontWeight.normal){
        texts[currentIndexText.value].fontWeight = FontWeight.bold;
      }
      else {
        texts[currentIndexText.value].fontWeight = FontWeight.normal;
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
    mainController.update();
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
      fontFamily: 'Roboto', isChoose: false,
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
        fontFamily: duplicate.fontFamily, isChoose: false,
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
  setCurrentIndex(int index) {
    try {
      currentIndexText.value = index;
      for (var text in texts) {
        text.isChoose = false;
      }
      texts[currentIndexText.value].isChoose = true;
    }
    catch(e) {
      print(e);
    }
    update();
  }
  // if write ColorsPickerController().Pick , index color will be always reset
  ColorsPickerController colorsPickerController = Get.put(ColorsPickerController());
  changeTextColor(){
    texts[currentIndexText.value].color = colorsPickerController.Picker();
    update();
  }
  changeTextSize(double size) {
    if (size != 30) {
      texts[currentIndexText.value].fontSize = size;
      update();
    }
  }

}