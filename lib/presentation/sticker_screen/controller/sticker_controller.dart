import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fox/presentation/sticker_screen/models/sticker_models.dart';
import 'package:get/get.dart';

class StickerController extends GetxController {
  var isLoading = true.obs;
  var indexSticker = 0.obs;
  // store current pack sticker to show in bottom
  Set currentPack = {};
  // store sticker user have chosen
  List<StickerInfo> stickerInserted = [];
  List listNamePack = ['food', 'hiphop'];
  List previewPackSticker = [];
  // Set type store all pack sticker
  List<Set<dynamic>> packStickers = List.generate(10, (_) => {});
  @override
  void onReady() {
    super.onReady();
    createListSticker();
    currentPack = packStickers[0];
  }
  void ChooseSticker(int index){
    stickerInserted.add(
        StickerInfo(
            asset: currentPack.elementAt(index),
            left: 100,
            top: 100,
            isChoose: false
        ),
    );
    update();
  }
  void EditSticker(int index) {
    stickerInserted[index].isChoose = true;
    update();
  }

  void ChoosePackSticker(int index) {
    currentPack = packStickers[index];
    update();
  }
  void DeleteSticker(int index) {
    stickerInserted.removeAt(index);
    update();
  }
  void CopySticker(int index) {
    stickerInserted.add(
        StickerInfo(
            asset: stickerInserted[index].asset,
            left: stickerInserted[index].left + 20,
            top: stickerInserted[index].top + 20,
            isChoose: false)
    );
    update();
  }

  void createListSticker() async {
    isLoading.value = true;
    String nameSticker = '';
    for(int index = 0; index < listNamePack.length; index++) {
      nameSticker = listNamePack[index];
      for (int i = 0; i < await getNumberOfSticker(nameSticker); i++) {
        try {
          packStickers[index].add('assets/sticker/$nameSticker/img_$i.png');
        } catch(e) {
          print('error add sticker $e');
        }
      }
      // add sticker preview
      previewPackSticker.add(packStickers[index].elementAt(0));
    }
    isLoading.value = false;
    update();
  }

  Future<int> getNumberOfSticker(String packName) async {
    String path = 'assets/sticker/$packName/';
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final List<String> assets = manifestMap.keys
                                  .where((String key) => key.startsWith(path))
                                  .toList();
      return assets.length;
    } catch(e) {
      print('error loading assets: $e');
    }
    update();
    return 0;
  }
}