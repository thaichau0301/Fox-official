import 'package:fox/core/app_export.dart';
import 'package:get/get.dart';

class mainTextController extends GetxController {
  var selectedFont = 0.obs;
  var indexChildWidget = 0.obs;
  var selectedFormatText = List.filled(3, false);
  var selectedAlignHorizontal = List.filled(3,false).obs;
  var selectedAlignVertical = List.filled(3,false).obs;
  var minFontSize = 14.0.obs;

  void changeTabIndex(int index) {
    print(index);
    indexChildWidget.value = index;
    update();
  }
  void changeFontIndex(int index) {
    print(index);
    selectedFont.value = index;
    update();
  }
  void changeFormatIndex (int index) {
    selectedFormatText[index] == false ? selectedFormatText[index] = true : selectedFormatText[index] = false;
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
}