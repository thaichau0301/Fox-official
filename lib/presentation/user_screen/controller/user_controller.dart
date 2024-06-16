import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fox/domain/googleauth/google_auth_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/app_export.dart';
import '../../main_screen/controller/main_screen_controller.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    GetInfoUser();
  }
  Rx<UserModel> userModelObj = UserModel().obs;
  User? firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  final googleController = Get.put(GoogleAuthHelper());
  RxString email = ''.obs;
  RxString photoUrl = ''.obs;

  void GetInfoUser()
  {
    auth.authStateChanges().listen((User? user) {
      firebaseUser = auth.currentUser;
      if(firebaseUser != null) {
        email.value = firebaseUser!.email!;
        photoUrl.value =  firebaseUser!.photoURL!;
      }
      else {
        email.value = '';
        photoUrl.value = '';
      }
    update();
  }
    );
  }


  Future<void> SignOutUser() async
  {
    if (firebaseUser != null)
    {
      for (UserInfo userInfo in firebaseUser!.providerData)
      {
        if (userInfo.providerId == 'facebook.com')
        {
          await FacebookAuth.instance.logOut();
        }
        else if (userInfo.providerId == 'google.com')
        {
          await GoogleSignIn().signOut();
        }
      }
      await FirebaseAuth.instance.signOut();
    }
    else {
      Get.snackbar('Failure', 'You can not log out');
    }
  }
  Future<void> DeleteAccount() async {
    if (firebaseUser != null)
    {
      for (UserInfo userInfo in firebaseUser!.providerData)
      {
        if (userInfo.providerId == 'facebook.com')
        {
          await FacebookAuth.instance.logOut();
        }
        else if (userInfo.providerId == 'google.com')
        {
          await GoogleSignIn().signOut();
        }
      }
      await firebaseUser!.delete();
    }
    else {
      Get.snackbar('Failure', 'You can not delete account');
    }
  }
  Set<String> imageUrls = {};
  Future<void> listUserFiles() async {
    final user= FirebaseAuth.instance.currentUser;
    if (user != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final userFolderRef = storageRef.child('user_folders/${user.uid}');
      try {
        final listResult = await userFolderRef.listAll();
        for (var ref in listResult.items) {
          final url = await ref.getDownloadURL();
          imageUrls.add(url);
        };
      } on FirebaseException catch (e) {
        print('Error listing files: $e');
      }
    }
  }
  Future<void> onTapImage(String imageUrl) async {
    // route to main to edit that image
    // save network image to cache to pass path to main
    final imageData = await http.get(Uri.parse(imageUrl));
    Directory cacheDir = await getApplicationCacheDirectory();
    final fileName = imageUrl.split('/').last;
    final file = File('${cacheDir.path}/$fileName');
    // bodyBytes convert Response to Uint8List
    await file.writeAsBytes(imageData.bodyBytes);
    Get.delete<MainScreenController>(force: true);
    Get.toNamed('/main_screen',arguments: {'fileImage': file, 'nameImage' : fileName});
  }
}
