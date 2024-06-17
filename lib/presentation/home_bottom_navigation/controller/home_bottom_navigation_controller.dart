import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class HomeBottomBarController extends GetxController {
  var tabIndex = 0.obs;
  void changeTab(int index) {
    if(index == 1) {
      pickImage();
      return;
    }
    tabIndex.value = index;
    update();
  }
  Future<void> pickImage() async {
    try{
      // type XFile
      final imagePicked = (await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100));
      File fileImage = File(imagePicked!.path);
      try
      {
        final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
        String nameImage = basename(fileImage.path);
        // move file image from cache to app_flutter - ready for editing will get image from here
        File newFileImage = await fileImage.copySync('${appDocumentsDir.path}/$nameImage');
        Get.toNamed('/main_screen',arguments: {'fileImage': newFileImage, 'nameImage' : nameImage});
      }
      catch (e)
      {
        print('Error move image picked from cache to app_flutter $e');
      }
    }
    catch(e) {
      changeTab(0);
      print('Error pick image $e');
    }
  }
}