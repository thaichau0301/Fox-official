import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeBottomBarController extends GetxController {
  var tabIndex;

  @override
  void onInit()
  {
    super.onInit();
    tabIndex = 0.obs;
  }
  void resetTabIndex(){
    tabIndex.value = 0;
    update();
  }

  void changeTab(int index) {
    tabIndex.value = index;
    if(index == 1) pickImage();
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
        // if directory null , create new directory
        if (!appDocumentsDir.existsSync())
        {
          appDocumentsDir.createSync(recursive: true);
        }
        String newNameImage = fileImage.path.split('/').last; // Extract the file name

        // move file image from cache to app_flutter - ready for editing will get image from here
        File newFileImage = await fileImage.copy('${appDocumentsDir.path}/$newNameImage');
        Get.toNamed('/main_navigation',arguments: {'imagePicked' : imagePicked, 'fileImage': newFileImage, 'nameImage' : newNameImage});

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