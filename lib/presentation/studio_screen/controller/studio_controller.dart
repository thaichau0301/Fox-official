import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../image_model.dart';

class StudioController extends GetxController {
  var isSelected = false.obs;
  List<ImageModel> images = [];
  void onReady() {
    listUserFiles();
  }
  void onClose(){
    super.onClose();
  }
  Future<void> listUserFiles() async {
    final user= FirebaseAuth.instance.currentUser;
    if (user != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final userFolderRef = storageRef.child('user_folders/${user.uid}');
      try {
        final listResult = await userFolderRef.listAll();
        for (var ref in listResult.items) {
          final url = await ref.getDownloadURL();
          images.add(
            ImageModel(url: url, isCheck: false),
          );
        };
      } on FirebaseException catch (e) {
        print('Error listing files: $e');
      }
    }
  }
  void ShowSelectedImage() {
    isSelected.value = true;
    update();
  }
  void selectedImage(bool newValue, int index) {
    images[index].isCheck = newValue;
    update();
  }
  void selectedAllImage() {
    for(var image in images) {
      image.isCheck = true;
    }
    update();
  }
  void FunctionExitStudio() {
    Get.back();
    isSelected.value = false;
    for(var image in images) {
      image.isCheck = false;
    }
  }
  void deleteImage() {
    List<ImageModel> elementsToRemove = [];
    images.forEach((element){
      if(element.isCheck == true) {
        FirebaseStorage.instance.refFromURL(element.url).delete();
        elementsToRemove.add(element);
      }
    });
    images.removeWhere((element) => elementsToRemove.contains(element));
    update();
  }
  String getFileName(String url) {
    Uri uri = Uri.parse(url);
    String fileName = uri.pathSegments.last.split("/").last;
    return fileName;
  }
  Future<void> EditImage(String imageUrl) async {
    // route to main to edit that image
    // save network image to cache to pass path to main
    final imageData = await http.get(Uri.parse(imageUrl));
    Directory cacheDir = await getApplicationCacheDirectory();
    final fileName = getFileName(imageUrl);
    final file = File('${cacheDir.path}/$fileName');
    // bodyBytes convert Response to Uint8List
    await file.writeAsBytes(imageData.bodyBytes);
    Get.toNamed('/main_screen',arguments: {'fileImage': file, 'nameImage' : fileName});
  }
}