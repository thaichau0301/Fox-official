import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fox/domain/googleauth/google_auth_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/app_export.dart';
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
}
